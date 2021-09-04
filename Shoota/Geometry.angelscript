class Segment
{
	vector2 A;
	vector2 B;
	
	Segment(vector2 a, vector2 b)
	{
		A = a;
		B = b;
	}
	Segment(){}
}

float length(Segment s)
{
	return distance(s.A, s.B);
}

vector2 error = vector2(3,3);

class Polygon
{
	vector2[] points;
	vector2 topLeft;
	vector2 bottomRight;
	
	Polygon(){}
	
	void reset()
	{
		points.resize(0);
	}
	
	void insert(vector2 p)
	{
		if(points.length() != 0)
			checkLimits(p);
		else
		{
			topLeft = p;
			bottomRight = p;
		}
		points.insertLast(p);
	}
	
	void checkLimits(vector2 p)
	{
		if(topLeft.x > p.x)
			topLeft.x = p.x;
		if(topLeft.y > p.y)
			topLeft.y = p.y;
			
		if(bottomRight.x < p.x)
			bottomRight.x = p.x;
		if(bottomRight.y < p.y)
			bottomRight.y = p.y;
	}
	
	void debugDraw()
	{
		for(uint i=0;i<points.length()-1;i++)
			DrawLine(points[i], points[i+1], red, red, 5);
			
		DrawLine(points[0], points[points.length()-1], red, red, 5);
	}
	
	bool isPointInPolygon(vector2 p)
	{
		vector2 newTop = topLeft-error;
		vector2 newBottom = bottomRight+error;
		if(!isPointInRect(p, newTop, newBottom))
			return false;
		
		Segment projectionSegment = Segment(newTop, p);
		Segment[] others = getSegmentsFromPolygon(this);
		uint touched = 0;
		for(uint i=0;i<others.length();i++)
		{
			if(doIntersect(others[i], projectionSegment))
			{
				touched++;
			}
		}
		bool inside = (touched % 2 == 1);
		return inside;
	}
	
}


Segment[] getSegmentsFromPolygon(Polygon pol)
{
	Segment[] segments;
	vector2[] p = pol.points;
	uint len = p.length()-1;
	for(uint t=0;t<len;t++)
	{
		segments.insertLast(Segment(p[t], p[t+1]));
	}
	segments.insertLast(Segment(p[0], p[len]));
	return segments;
}


// Given three colinear points p, q, r, the function checks if 
// point q lies on line segment 'pr' 
bool onSegment(vector2 p, vector2 q, vector2 r) 
{ 
    if (q.x <= max(p.x, r.x) && q.x >= min(p.x, r.x) && 
        q.y <= max(p.y, r.y) && q.y >= min(p.y, r.y)) 
       return true; 
  
    return false; 
} 
  
// To find orientation of ordered triplet (p, q, r). 
// The function returns following values 
// 0 --> p, q and r are colinear 
// 1 --> Clockwise 
// 2 --> Counterclockwise 
int orientation(vector2 p, vector2 q, vector2 r) 
{ 
    // See https://www.geeksforgeeks.org/orientation-3-ordered-points/ 
    // for details of below formula. 
    int val = (q.y - p.y) * (r.x - q.x) - 
              (q.x - p.x) * (r.y - q.y); 
  
    if (val == 0) return 0;  // colinear 
  
    return (val > 0)? 1: 2; // clock or counterclock wise 
} 
  
// The main function that returns true if line segment 'p1q1' 
// and 'p2q2' intersect. 
bool doIntersect(Segment a, Segment b) 
{ 
    // Find the four orientations needed for general and 
    // special cases 
	vector2 p1 = a.A;
	vector2 q1 = a.B;
	vector2 p2 = b.A;
	vector2 q2 = b.B;
    int o1 = orientation(p1, q1, p2); 
    int o2 = orientation(p1, q1, q2); 
    int o3 = orientation(p2, q2, p1); 
    int o4 = orientation(p2, q2, q1); 
  
    // General case 
    if (o1 != o2 && o3 != o4) 
        return true; 
  
    // Special Cases 
    // p1, q1 and p2 are colinear and p2 lies on segment p1q1 
    if (o1 == 0 && onSegment(p1, p2, q1)) return true; 
  
    // p1, q1 and q2 are colinear and q2 lies on segment p1q1 
    if (o2 == 0 && onSegment(p1, q2, q1)) return true; 
  
    // p2, q2 and p1 are colinear and p1 lies on segment p2q2 
    if (o3 == 0 && onSegment(p2, p1, q2)) return true; 
  
     // p2, q2 and q1 are colinear and q1 lies on segment p2q2 
    if (o4 == 0 && onSegment(p2, q1, q2)) return true; 
  
    return false; // Doesn't fall in any of the above cases 
} 
  
