#pragma once
#include "stdafx.h"
#include "Transform.h"
#include "algorithm"

//структура соответствует уравнению прямой линии y = kx + b
struct line_ur {
	double b;
	double k;
};

//Уравнение прямой, проходящей через две заданные точки
line_ur getUr(point start, point end){
	double x0 = start.x;	double y0 = start.y;
	double x1 = end.x;		double y1 = end.y;
	//-------------------------------------------
	double k = (y0 - y1)/(x0 - x1);
	double b = y0 - k*x0;
	line_ur t;
	t.b = b;
	t.k = k;
	return t;
}

//Найти точку пересечения двух прямых
point peres (line_ur l1, line_ur l2){
	point t;
	if (l1.k == l2.k) {		//исключительный случай. Прямые параллельны
		t.x = 0;
		t.y = 0;
	}
	else {
		t.x = (l2.b - l1.b)/(l1.k - l2.k);
		t.y = l1.k * t.x + l1.b;
	}
	return t;
}


//Для удобства навигации по вершинам многоугольника
int prev(int i,int n){
	if (i) {
		return i-1;
	} else {
		return n-1;
	}
}
int succ(int i, int n){
	if ( i == (n-1) ) {
		return 0;
	} else {
		return i+1;
	}
}

point inside (polygon^ P) {
	double y_min  = 10000; double x_min  = 10000;
	double y_min2 = 10001; double x_min2 = 10001; 
	for (int i = 0; i < P->Count; i++){
		//два различных минимальных значения координаты y
			point t = P[i];
			if (t.y < y_min) {
				y_min2 = y_min;
				y_min = t.y;
			} else if ((t.y < y_min2) && (t.y != y_min)) {
				y_min2 = t.y;
			}
		}

	line_ur wund; wund.k = 0; wund.b = (y_min2 - y_min)/2;						// прикольная прямая линия

	for (int i = 0; i < P->Count; i++){
		point t = P[i];
		if (t.y == y_min){														//Если y равен y'
			if (P[prev(i, P->Count)].y != y_min) {								//И ребро не горизонтальное
				point tmp;
				 tmp = peres( getUr(P[prev(i, P->Count)], P[i]), wund);
				 if (tmp.x < x_min) {
				 	x_min2 = x_min;
				 	x_min = tmp.x;
				 } else if (tmp.x < x_min2){
				 	x_min2 = tmp.x;
				 }
			}
			if (P[succ(i, P->Count)].y != y_min) {
				point tmp;								//и ещё одно ребро не горизонтальное
				tmp = peres( getUr(P[i], P[succ(i, P->Count)]), wund);
				if (tmp.x < x_min) {
					x_min2 = x_min;
					x_min = tmp.x;
				} else if (tmp.x < x_min2){
					x_min2 = tmp.x;
				}
			}
		}
	}

	point out;
	out.x = (x_min2 - x_min)/2;
	out.y = (y_min2 - y_min)/2;
	return out;
}

