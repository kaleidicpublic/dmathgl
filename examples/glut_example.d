/***************************************************************************
 * glut_example.cpp is part of Math Graphic Library
 * Copyright (C) 2007-2014 Alexey Balakin <mathgl.abalakin@gmail.ru>       *
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 *   This program is distributed in the hope that it will be useful,       *
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of        *
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *
 *   GNU General Public License for more details.                          *
 *                                                                         *
 *   You should have received a copy of the GNU General Public License     *
 *   along with this program; if not, write to the                         *
 *   Free Software Foundation, Inc.,                                       *
 *   59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.             *
 ***************************************************************************/

import mgl;

void long_calculations()	// just delay which correspond to simulate calculations
{
}
//-----------------------------------------------------------------------------

int test_wnd(mglGraph *gr);
int sample(mglGraph *gr);
int sample_m(mglGraph *gr);
int sample_1(mglGraph *gr);
int sample_2(mglGraph *gr);
int sample_3(mglGraph *gr);
int sample_d(mglGraph *gr);
//-----------------------------------------------------------------------------
alias draw_func = int function(mglGraph *gr);

int main(int argc,char **argv)
{
	char key = 0;
	if(argc>1)	key = argv[1][0]!='-' ? argv[1][0] : argv[1][1];
	else	printf("You may specify argument '1', '2', '3' or 'd' for viewing examples of 1d, 2d, 3d or dual plotting\n");
	switch(key)
	{
	case '1':	new mglGLUT(sample_1, "1D plots");	break;
	case '2':	new mglGLUT(sample_2, "2D plots");	break;
	case '3':	new mglGLUT(sample_3, "3D plots");	break;
	case 'd':	new mglGLUT(sample_d, "Dual plots");	break;
	case 't':	new mglGLUT(test_wnd, "Testing");	break;
	default:	new mglGLUT(sample, "Example of molecules");	break;
	}
	return 0;
}
