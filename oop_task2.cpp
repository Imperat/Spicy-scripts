#include <iostream>
#include <vector>
#include <cmath>


#define D 0.05
#define PT Point

using namespace std;

class Point {
public:
	double x,y;
	double altituge;

	Point (double nx, double ny, double altg) {
		x = nx;
		y = ny;
		altituge = altg;
	}

	double getLength () {
		return sqrt(x*x + y*y + altituge*altituge);
	}

};

class Plan {
private:
	int a;
	bool avalibale;
	vector <Point> way;

	Point getPoint(int i) {
		return way[i];
	}

	double getAltituge(int i){
		return way[i].altituge;
	}
	double getSpeed (int i){
		if (i==0) return 0;
		else
			return getPoint(i).getLength() - getPoint(i-1).getLength();
	}
	double getSpeedUp (int i){
			if (i<=1) return 0;
			else
				return getSpeed(i) - getSpeed(i-1);
	}

public:

	Plan (vector <Point> w){
		way = w;
		avalibale = true;
		a = 0;

	}

	Point getPlace(){
		a++;
		if (a < way.size())
			return way[a];
		else return Point(0, 0, 0);
	}

	void kill (double nx, double ny, double naltituge){
		double x = getPoint(a).x;
		double y = getPoint(a).y;
		double altituge = getPoint(a).altituge;

		if (
				(abs(nx - x) < D)
			&&  (abs(ny - y) < D)
			&&  (abs(naltituge - altituge < D))
			) avalibale = false;

	}
	bool isAvalibale (){
		return avalibale;
	}
};

int main(){
	vector <Point> p;

	p.push_back(PT(0,100,4));
	

	Plan a = Plan (p);

	return 0;
}
