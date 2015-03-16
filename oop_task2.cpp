#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

class Point {
public:
	double x,y;
	double altituge;

	Point (int nx, int ny, int altg) {
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

public:
	Point getPlace(){
		a++;
		if a>
		return way[a];
	}

	void kill (double nx, double ny, double naltituge){
		if (
				(abs(nx - x) < d)
			&&  (abs(ny - y) < d)
			&&  (abs(naltituge - altituge < d))
			) avalibale = false;

	}
	/*double getAltituge(int i){
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
	}*/
};

int main(){

	return 0;
}
