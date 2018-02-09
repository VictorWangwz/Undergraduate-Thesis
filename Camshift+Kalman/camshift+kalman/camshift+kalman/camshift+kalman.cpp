// CamShift+Kalman.cpp : 定义控制台应用程序的入口点。
//

#include "stdafx.h"
#include<iostream>
using namespace std;
#include <stdio.h>

#include <cxcore.h>

#include <cv.h>

#include <highgui.h>
#include <time.h>
#include <dos.h>
//*************************************
//调整矩形框B，使其在A的范围
CvRect my_ChangeRect(CvRect A, CvRect B)
{
	if (B.x<A.x)
		B.x = A.x;
	if (B.x + B.width>A.width)
		B.width = A.width - B.x;
	if (B.y<A.y)
		B.y = A.y;
	if (B.y + B.height>A.height)
		B.height = A.height - B.y;
	return(B);
}
//**************************************
//kalman初始化。。。http://blog.sina.com.cn/s/blog_71ee19c30101axq0.html
CvKalman* InitializeKalman(CvKalman* kalman)
{

	const float A[] = { 1,0,1,0,
		0,1,0,1,
		0,0,1,0,
		0,0,0,1 };
	kalman = cvCreateKalman(4, 2, 0);//状态，测量，控制向量维数
	memcpy(kalman->transition_matrix->data.fl, A, sizeof(A));//A
	//memcpy函数的功能是从源src所指的内存地址的起始位置开始拷贝n个字节到目标dest所指的内存地址的起始位置中。
	cvSetIdentity(kalman->measurement_matrix, cvScalarAll(1));//H，该函数的作用是将矩阵行与列相等的元素置为1，其余元素置为0
	cvSetIdentity(kalman->process_noise_cov, cvScalarAll(1e-5));//Q w ；
	cvSetIdentity(kalman->measurement_noise_cov, cvScalarAll(1e-1));//R v
	cvSetIdentity(kalman->error_cov_post, cvScalarAll(1));//P
	return kalman;
}
//***************************************
//point1上一帧中心，point2当前帧中心，把x,y,vx,vy存入kalman->state_post
void GetCurentState(CvKalman* kalman, CvPoint point1, CvPoint point2)
{
	float input[4] = { point2.x, point2.y, point2.x - point1.x, point2.y - point1.y };//currentstate
	memcpy(kalman->state_post->data.fl, input, sizeof(input));
}
//****************************************
//point1上一帧中心，point2当前帧中心，把x,y,vx,vy存入矩阵
CvMat* GetMeasurement(CvMat* mat, CvPoint point1, CvPoint point2)
{
	float input[4] = { point2.x, point2.y, point2.x - point1.x, point2.y - point1.y };
	memcpy(mat->data.fl, input, sizeof(input));
	return mat;
}
/*****************************************/
#define region 50
#define calc_point(kalman) cvPoint( cvRound(kalman[0]),cvRound(kalman[1]))////对一个double型的数进行四舍五入；；位置对应的像素值

IplImage *image = 0, *hsv = 0, *hue = 0, *mask = 0, *histimg = 0;
CvHistogram *hist;
IplImage *backproject;

CvPoint lastpoint; //上一帧的中心坐标
CvPoint predictpoint, measurepoint;//预测坐标以及当前帧的坐标

int select_object = 0;
int track_object;

CvPoint origin;
CvPoint point_text;
CvRect selection;
CvRect origin_box;

CvRect track_window;
CvBox2D track_box; // tracking 返回的区域 box，带角度
CvConnectedComp track_comp;
int hdims = 256; // 划分HIST的个数，越高越精确
float hranges_arr[] = { 0,180 };
float* hranges = hranges_arr;
int vmin = 10, vmax = 256, smin = 30;
int start_track = 0;
CvFont font;//显示的文本字体
char nchar[10];//显示数字字符串用
CvMat* measurement;
CvMat* realposition;
const CvMat* prediction;
CvRect search_window;
int filename1_n = 0;
int frame_count = 0;

void on_mouse(int event, int x, int y, int flags, void *p)
{
	if (!image)
		return;

	if (image->origin)
		y = image->height - y;

	if (select_object)
	{
		selection.x = MIN(x, origin.x);
		selection.y = MIN(y, origin.y);
		selection.width = selection.x + CV_IABS(x - origin.x);
		selection.height = selection.y + CV_IABS(y - origin.y);

		selection.x = MAX(selection.x, 0);
		selection.y = MAX(selection.y, 0);
		selection.width = MIN(selection.width, image->width);
		selection.height = MIN(selection.height, image->height);
		selection.width -= selection.x;
		selection.height -= selection.y;
		//cout << origin.x<< endl<<origin.y<<endl;
	}

	switch (event)
	{
	case CV_EVENT_LBUTTONDOWN:
		origin = cvPoint(x, y);
		selection = cvRect(x, y, 0, 0);
		select_object = 1;
		break;
	case CV_EVENT_LBUTTONUP:
		select_object = 0;
		if (selection.width > 0 && selection.height > 0)
			track_object = -1;
		origin_box = selection;


#ifdef _DEBUG
		printf("\n # 鼠标的选择区域：");
		printf("\n X = %d, Y = %d, Width = %d, Height = %d",
			selection.x, selection.y, selection.width, selection.height);
#endif
		break;
	}
}
/*************************************main***************************/
int main(int argc, char** argv)
{
	CvCapture* capture = 0;
	IplImage* frame = 0;
	//capture = cvCaptureFromCAM(0);
	time_t t = time(NULL);
	time_t t_ori = t;
	int x_ori = 0;
	int y_ori = 0;
	int vx = 0;
	int vy = 0;
	capture = cvCaptureFromAVI("ex2.avi");
	if (!capture)
	{
		fprintf(stderr, "Could not initialize capturing...\n");
		return -1;
	}

	cvNamedWindow("CamShiftDemo", 1);
	cvSetMouseCallback("CamShiftDemo", on_mouse, NULL); // on_mouse 自定义事件
	cvCreateTrackbar("Vmin", "CamShiftDemo", &vmin, 256, 0);
	cvCreateTrackbar("Vmax", "CamShiftDemo", &vmax, 256, 0);
	cvCreateTrackbar("Smin", "CamShiftDemo", &smin, 256, 0);
	//初始化kalman
	CvKalman* kalman = 0;
	kalman = InitializeKalman(kalman);
	measurement = cvCreateMat(2, 1, CV_32FC1);//Z(k)，用来转换成矩阵形式，32位浮点型单通道
	realposition = cvCreateMat(4, 1, CV_32FC1);//real X(k)

	for (;;)
	{
		int i = 0, c;
		frame = cvQueryFrame(capture);//抓取capture的一帧
		if (!frame)
			break;
		if (!image)
		{
			/* allocate all the buffers */
			image = cvCreateImage(cvGetSize(frame), 8, 3);
			image->origin = frame->origin;//如果不加這一行的話  下面copy動作完之後，image->origin會從尾巴開始算  整張影像會倒過來
			
			cout <<"视频窗口的宽为"<< cvGetSize(frame).width << endl << "视频窗口的高为" << cvGetSize(frame).height << endl;
			hsv = cvCreateImage(cvGetSize(frame), 8, 3);
			hue = cvCreateImage(cvGetSize(frame), 8, 1);
			mask = cvCreateImage(cvGetSize(frame), 8, 1);

			backproject = cvCreateImage(cvGetSize(frame), 8, 1);
			backproject->origin = frame->origin;
			hist = cvCreateHist(1, &hdims, CV_HIST_ARRAY, &hranges, 1); // 计算直方图

		}
		cvCopy(frame, image, 0);
		cvCvtColor(image, hsv, CV_BGR2HSV); // 彩色空间转换 BGR to HSV 
		frame_count++;
		//*******************************************************************************************
		if (track_object) //开始跟踪
		{
			int _vmin = vmin, _vmax = vmax;
			cvInRangeS(hsv, cvScalar(0, smin, MIN(_vmin, _vmax), 0),
				cvScalar(180, 256, MAX(_vmin, _vmax), 0), mask); // 得到二值的MASK
			cvSplit(hsv, hue, 0, 0, 0); // 只提取 HUE 分量 
			if (track_object < 0)//初始化
			{
				float max_val = 0.f;
				cvSetImageROI(hue, origin_box); 
				// 得到选择区域 for ROI，//基于给定的矩形设置图像的ROI（感兴趣区域，region of interesting）
				cvSetImageROI(mask, origin_box); 
				// 得到选择区域 for mask
				cvCalcHist(&hue, hist, 0, mask); // 计算直方图//计算一张或多张单通道图像的直方图（hue色调H通道）
				cvGetMinMaxHistValue(hist, 0, &max_val, 0, 0); // 只找最大值，//找到最大和最小直方块
				cvConvertScale(hist->bins, hist->bins, max_val ? 255. / max_val : 0., 0); // 缩放 bin 到区间 [0,255] //使用线性变换转换数组
				cvResetImageROI(hue); // remove ROI
				cvResetImageROI(mask);
				track_window = origin_box;
				track_object = 1;//此值等於1代表model建好  可以追縱了

				/////////////////////
				lastpoint = predictpoint = cvPoint(track_window.x + track_window.width / 2,
					track_window.y + track_window.height / 2);//预测点为中点
				GetCurentState(kalman, lastpoint, predictpoint);//input curent state
			}



			//预测目标框的位置(x,y,vx,vy), 
			prediction = cvKalmanPredict(kalman, 0);//predicton=kalman->state_post 
			predictpoint = calc_point(prediction->data.fl);//预测坐标
			//预测出的矩形框
			track_window = cvRect(predictpoint.x - track_window.width / 2, predictpoint.y - track_window.height / 2,
				track_window.width, track_window.height);//通过矩形左上角坐标和矩形的宽和高来确定一个矩形区域
			track_window = my_ChangeRect(cvRect(0, 0, frame->width, frame->height), track_window);//将track window放在图像范围中
			//只对目标周围计算投影
			search_window = cvRect(track_window.x - region, track_window.y - region,
				track_window.width + 2 * region, track_window.height + 2 * region);//track window的相隔50的一圈范围
			//修正search_window，使其范围在图像内
			search_window = my_ChangeRect(cvRect(0, 0, frame->width, frame->height), search_window);
			cvSetImageROI(hue, search_window);
			cvSetImageROI(mask, search_window);
			cvSetImageROI(backproject, search_window);
			cvCalcBackProject(&hue, backproject, hist); 
			// 使用 back project 方法//直方图的反向投影。对比选定的直方图与图像上的直方图，得到位置
			cvAnd(backproject, mask, backproject, 0);//计算两个数组的按位与的结果
			//因为设置了_1ROI，所以更新track_window
			track_window = cvRect(region, region, track_window.width, track_window.height);
			// calling CAMSHIFT 算法模块 
			/* cvCamShift( backproject, track_window,
			cvTermCriteria( CV_TERMCRIT_EPS | CV_TERMCRIT_ITER, 10, 1 ),
			&track_comp, &track_box );*/
			cvMeanShift(backproject, track_window,
				cvTermCriteria(CV_TERMCRIT_EPS | CV_TERMCRIT_ITER, 10, 1),
				&track_comp);
			//******************************************************************************** 
			cvResetImageROI(hue);
			cvResetImageROI(mask);
			cvResetImageROI(backproject);
			track_window = track_comp.rect;//comp->rect是收敛后窗口位置，comp->area是最终窗口中所有像素点的和
			track_window = cvRect(track_window.x + search_window.x, track_window.y + search_window.y,
				track_window.width, track_window.height);
			//实际的质心坐标 
			measurepoint = cvPoint(track_window.x + track_window.width / 2,
				track_window.y + track_window.height / 2);
			
			int dx = abs(x_ori - measurepoint.x);
			int dy = abs(y_ori - measurepoint.y);
			x_ori = measurepoint.x;
			y_ori = measurepoint.y;
			t = time(NULL);
			time_t dt = t - t_ori;
			
			if (dt != 0)
			{
				t_ori = t;
				vx = dx / dt;
				vy = dy / dt;
			}

            cout <<"x坐标为"<< measurepoint.x << "，y坐标为"<<measurepoint.y<<",x方向速度为"<<vx<<",y方向速度为"<<vy<< ",采样间隔为"<<dt*1000<<endl;
			realposition->data.fl[0] = measurepoint.x;
			realposition->data.fl[1] = measurepoint.y;
			realposition->data.fl[2] = measurepoint.x - lastpoint.x;
			realposition->data.fl[3] = measurepoint.y - lastpoint.y;
			lastpoint = measurepoint;//keep the current real position
									 //实际算出的measurement只是当前的x，y
			cvMatMulAdd(kalman->measurement_matrix/*2x4*/, realposition/*4x1*/,/*measurementstate*/ 0, measurement); //先乘后加
			cvKalmanCorrect(kalman, measurement);
			cvRectangle(image, cvPoint(track_window.x, track_window.y),
				cvPoint(track_window.x + track_window.width, track_window.y + track_window.height),
				CV_RGB(255, 0, 0), 2, 8, 0);
			//把目标是第几个标出来
			cvInitFont(&font, CV_FONT_HERSHEY_SIMPLEX, 1.0F, 1.0F, 0, 3, 8);
			sprintf(nchar, "ID:%d", i + 1);
			point_text = cvPoint(track_window.x, track_window.y + track_window.height);
			cvPutText(image, nchar, point_text, &font, CV_RGB(255, 255, 0));
		}
		//*********************************************************************************************** 
		if (select_object && selection.width > 0 && selection.height > 0)
		{
			cvSetImageROI(image, selection);
			cvXorS(image, cvScalarAll(255), image, 0);//矩阵进行异或操作
			cvResetImageROI(image);
		}
		cvShowImage("CamShiftDemo", image);
		c = cvWaitKey(30);
		//根据键盘关闭跟踪目标
		if (c == 27)
			break; // exit from for-loop 
	}
	cvReleaseCapture(&capture);
	cvDestroyWindow("CamShiftDemo");
	return 0;
}