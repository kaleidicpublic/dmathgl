/**
	Ported to dlang 2015 by Laeeth Isharc
*/
/***************************************************************************
 * datac.h is part of Math Graphic Library
 * Copyright (C) 2007-2014 Alexey Balakin <mathgl.abalakin@gmail.ru>       *
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU Library General Public License as       *
 *   published by the Free Software Foundation; either version 3 of the    *
 *   License, or (at your option) any later version.                       *
 *                                                                         *
 *   This program is distributed in the hope that it will be useful,       *
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of        *
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *
 *   GNU General Public License for more details.                          *
 *                                                                         *
 *   You should have received a copy of the GNU Library General Public     *
 *   License along with this program; if not, write to the                 *
 *   Free Software Foundation, Inc.,                                       *
 *   59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.             *
 ***************************************************************************/
import data;

auto mgl2()
{
	return mreal(2);
}

auto mgl3()
{
	return mreal(3);
}

auto mgl4()
{
	return mreal(4);
}


/// Class for working with complex data array
class MglDataC:MglDataA
{
    //public : using MglDataA :  : Momentum;
    long nx; ///< number of points in 1st dimensions ('x' dimension)
    long ny; ///< number of points in 2nd dimensions ('y' dimension)
    long nz; ///< number of points in 3d dimensions ('z' dimension)
    dual* a; ///< data array
	string id; ///< column (or slice) names
    bool link; ///< use external data (i.e. don't free it)

    /// Initiate by other MglDataC variable
    this(in MglDataC* d)
    {
        a = 0;
        mgl_datac_set(this,  & d);
    } // NOTE: must be constructor for MglDataC& to exclude copy one

    this(in MglDataA* d)
    {
        a = 0;
        mgl_datac_set(this,  & d);
    }

    static if(HaveRval)
    {
    	this(MglDataC**  d)
    	{
    		this.nx=d.nx;
    		this.ny=d.ny;
    		this.nz=d.nz;
    		this.a=d.a;
    		this.id=d.id;
    		this.link=d.link;
	        //this.s = d.s;
	        //this.temp = d.temp;
	        func = d.func;
	        //this.o = d.o;
	        d.a = 0;
	        d.func = 0;
	    }
	}
    
    this(in MglDataA* re, in MglDataA* im)
    {
        a = 0;
        mgl_datac_set_ri(this,  & re,  *im);
    }

    this(HCDT d)
    {
        a = 0;
        mgl_datac_set(this, d);
    }

    this(HCDT re, HCDT im)
    {
        a = 0;
        mgl_datac_set_ri(this, re, im);
    }

    this(bool, MglDataC * d) // NOTE: Variable d will be deleted!!!
    {
        if (d)
        {
            nx = d.nx;
            ny = d.ny;
            nz = d.nz;
            a = d.a;
            d.a = 0;
            temp = d.temp;
            func = d.func;
            o = d.o;
            s = d.s;
            id = d.id;
            link = d.link;
            delete d;
        }
        else
        {
            a = 0;
            Create(1);
        }
    }

    /// Initiate by flat array
    this(int size, const dual * d)
    {
        a = 0;
        Set(d, size);
    }
    this(int rows, int cols, const dual * d)
    {
        a = 0;
        Set(d, cols, rows);
    }
    this(int size, const double * d)
    {
        a = 0;
        Set(d, size);
    }
    this(int rows, int cols, const double * d)
    {
        a = 0;
        Set(d, cols, rows);
    }
    this(int size, const float * d)
    {
        a = 0;
        Set(d, size);
    }
    this(int rows, int cols, const float * d)
    {
        a = 0;
        Set(d, cols, rows);
    }
    this(in dual * d, int size)
    {
        a = 0;
        Set(d, size);
    }
    this(in dual * d, int rows, int cols)
    {
        a = 0;
        Set(d, cols, rows);
    }
    this(in double * d, int size)
    {
        a = 0;
        Set(d, size);
    }
    this(in double * d, int rows, int cols)
    {
        a = 0;
        Set(d, cols, rows);
    }
    this(in float * d, int size)
    {
        a = 0;
        Set(d, size);
    }
    this(in float * d, int rows, int cols)
    {
        a = 0;
        Set(d, cols, rows);
    }
    /// read data from file
    this(string fname)
    {
        a = 0;
        read(fname);
    }
    /// Allocate the memory for data array and initialize it zero
    this(long xx = 1, long yy = 1, long zz = 1)
    {
        a = 0;
        Create(xx, yy, zz);
    }
    /// Delete the array
    ~this()
    {
        //if (!link && a)
          //  delete[] a;
    }

    dual getVal(long i, long j = 0, long k = 0) const
    {
        return mgl_datac_get_value(this, i, j, k);
    }

    void setVal(dual f, long i, long j = 0, long k = 0)
    {
        mgl_datac_set_value(this, f, i, j, k);
    }

    /// get sizes
    long getNx() const
    {
        return nx;
    }

    long getNy() const
    {
        return ny;
    }

    long getNz() const
    {
        return nz;
    }

    /// Link external data array (don't delete it at exit)
    void Link(dual* A, long NX, long NY = 1, long NZ = 1)
    {
        mgl_datac_link(this, A, NX, NY, NZ);
    }

    void Link(MglDataC* d)
    {
        Link(d.a, d.nx, d.ny, d.nz);
    }
    /// Allocate memory and copy the data from the gsl_vector
    void Set(gsl_vector* m)
    {
        mgl_datac_set_vector(this, m);
    }

    /// Allocate memory and copy the data from the gsl_matrix
    void Set(gsl_matrix* m)
    {
        mgl_datac_set_matrix(this, m);
    }

    /// Allocate memory and copy the data from the (float *) array
    void Set(const float* A, long NX, long NY = 1, long NZ = 1)
    {
        mgl_datac_set_float(this, A, NX, NY, NZ);
    }

    /// Allocate memory and copy the data from the (double *) array
    void Set(const double* A, long NX, long NY = 1, long NZ = 1)
    {
        mgl_datac_set_double(this, A, NX, NY, NZ);
    }

    /// Allocate memory and copy the data from the (complex *) array
    void Set(const dual* A, long NX, long NY = 1, long NZ = 1)
    {
        mgl_datac_set_complex(this, A, NX, NY, NZ);
    }

    /// Allocate memory and scanf the data from the string
    void Set(string str, long NX, long NY = 1, long NZ = 1)
    {
        mgl_datac_set_values(this, str.toStringz, NX, NY, NZ);
    }

    /// Import data from abstract type
    void Set(HCDT dat)
    {
        mgl_datac_set(this, dat);
    }

    void Set(in MglDataA* dat)
    {
        mgl_datac_set(this,  & dat);
    }
    void Set(in MglDataA* re, in MglDataA* im)
    {
        mgl_datac_set_ri(this,  & re,  & im);
    }
    void Set(HCDT re, HCDT im)
    {
        mgl_datac_set_ri(this, re, im);
    }

    void SetAmpl(in MglDataA* ampl, in MglDataA* phase)
    {
        mgl_datac_set_ap(this,  & ampl,  & phase);
    }
    /// Allocate memory and copy data from std::vector<T>
    void set(int[] d)
    {
        if (d.length < 1)
            return;
        Create(d.length());
        foreach(i;0..nx)
            a[i] = d[i];
    }
    void set(float[] d)
    {
        if (d.length < 1)
            return;
        create(d.length());
        foreach(i;0..nx)
            a[i] = d[i];
    }
    void set(double[] d)
    {
        if (d.length() < 1)
            return;
        Create(d.length);
        foreach(i;0..nx)
            a[i] = d[i];
    }
    
    void set(dual[] d)
    {
        if (d.length() < 1)
            return;
        create(d.length);
        foreach(i;0..nx)
            a[i] = d[i];
    }

    /// Create or recreate the array with specified size and fill it by zero
    void create(long mx, long my = 1, long mz = 1)
    {
        mgl_datac_create(this, mx, my, mz);
    }

    /// Rearange data dimensions
    void rearrange(long mx, long my = 0, long mz = 0)
    {
        mgl_datac_rearrange(this, mx, my, mz);
    }

    /// Transpose dimensions of the data (generalization of Transpose)
    void transpose(string dim = "yx")
    {
        mgl_datac_transpose(this, dim.toStringz);
    }

    /// Extend data dimensions
    void extend(long n1, long n2 = 0)
    {
        mgl_datac_extend(this, n1, n2);
    }

    /// Reduce size of the data
    void squeeze(long rx, long ry = 1, long rz = 1, bool smooth = false)
    {
        mgl_datac_squeeze(this, rx, ry, rz, smooth);
    }

    /// Crop the data
    void crop(long n1, long n2, char dir = 'x')
    {
        mgl_datac_crop(this, n1, n2, dir);
    }

    /// Insert data
    void insert(char dir, long at = 0, long num = 1)
    {
        mgl_datac_insert(this, dir, at, num);
    }

    /// Delete data
    void deleteData(char dir, long at = 0, long num = 1)
    {
        mgl_datac_delete(this, dir, at, num);
    }

    /// Join with another data array
    void join(in MglDataA* d)
    {
        mgl_datac_join(this,  & d);
    }

    /// Modify the data by specified formula
    void modify(string eq, long dim = 0)
    {
        mgl_datac_modify(this, eq, dim);
    }

    /// Modify the data by specified formula
    void modify(const char * eq, in MglDataA* vdat, in MglDataA* wdat)
    {
        mgl_datac_modify_vw(this, eq,  & vdat,  & wdat);
    }
    /// Modify the data by specified formula
    void modify(const char * eq, in MglDataA* vdat)
    {
        mgl_datac_modify_vw(this, eq,  & vdat, 0);
    }
    /// Modify the data by specified formula assuming x,y,z in range [r1,r2]
    void fill(mglBase* gr, string eq, string opt = "")
    {
        mgl_datac_fill_eq(gr, this, eq, 0, 0, opt);
    }

    void fill(mglBase * gr, const char * eq, in MglDataA* vdat, string opt = "")
    {
        mgl_datac_fill_eq(gr, this, eq,  & vdat, 0, opt.toStringz);
    }

    void Fill(mglBase * gr, const char * eq, in MglDataA* vdat, in MglDataA* wdat,string opt = "")
    {
        mgl_datac_fill_eq(gr, this, eq,  & vdat,  & wdat, opt.toStringz);
    }
    /// Equidistantly fill the data to range [x1,x2] in direction dir
    void fill(dual x1, dual x2 = mglNaN, char dir = 'x')
    {
        mgl_datac_fill(this, x1, x2, dir);
    }

    /// Put value to data element(s)
    void put(dual val, long i = -1, long j = -1, long k = -1)
    {
        mgl_datac_put_val(this, val, i, j, k);
    }

    /// Put array to data element(s)
    void put(in MglDataA* dat, long i =  - 1, long j =  - 1, long k =  - 1)
    {
        mgl_datac_put_dat(this,  & dat, i, j, k);
    }

    /// Set names for columns (slices)
    void setColumnId(string ids)
    {
        mgl_datac_set_id(this, ids);
    }

    /// Make new id
    void newId()
    {
        id.clear();
    }

    /// read data from tab-separated text file with auto determining size
    bool read(string fname)
    {
        return mgl_datac_read(this, fname.toStringz);
    }

    /// read data from text file with specifeid size
    bool read(string fname, long mx, long my = 1, long mz = 1)
    {
        return mgl_datac_read_dim(this, fname.toStringz, mx, my, mz);
    }

    /// save whole data array (for ns=-1) or only ns-th slice to text file
    void save(string fname, long ns = -1) const
    {
        mgl_datac_save(this, fname.toStringz, ns);
    }

    /// read data from tab-separated text files with auto determining size which filenames are result of sprintf(fname,templ,t) where t=from:step:to
    bool readRange(string templ, double from, double to,
        double step = 1, bool as_slice = false)
    {
        return mgl_datac_read_range(this, templ.toStringz, from, to, step, as_slice);
    }

    /// read data from tab-separated text files with auto determining size which filenames are satisfied to template (like "t_*.dat")
    bool readAll(string templ, bool as_slice = false)
    {
        return mgl_datac_read_all(this, templ.toStringz, as_slice);
    }

    /// read data from text file with size specified at beginning of the file
    bool readMat(string fname, long dim = 2)
    {
        return mgl_datac_read_mat(this, fname.toStringz, dim);
    }

    /// read data array from HDF file (parse HDF4 and HDF5 files)
    int readHDF(string fname, ubyte[] data)
    {
        return mgl_datac_read_hdf(this, fname, data.ptr);
    }

    /// save data to HDF file
    void saveHDF(string fname, ubyte[] data, bool rewrite = false) const
    {
        mgl_datac_save_hdf(this, fname, data.ptr, rewrite);
    }

    /// get real part of data values
    MglData getReal() const
    {
        return MglData(true, mgl_datac_real(this));
    }
    /// get imaginary part of data values
    MglData getImag() const
    {
        return MglData(true, mgl_datac_imag(this));
    }
    /// get absolute value of data values
    MglData getAbs() const
    {
        return MglData(true, mgl_datac_abs(this));
    }
    /// get argument of data values
    MglData getArg() const
    {
        return MglData(true, mgl_datac_arg(this));
    }

    /// get column (or slice) of the data filled by formulas of named columns
    MglDataC getColumn(string eq) const
    {
        return MglDataC(true, mgl_datac_column(this, eq.toStringz));
    }

    /// get momentum (1D-array) of data along direction 'dir'. String looks like "x1" for median in x-direction, "x2" for width in x-dir and so on.
    MglDataC getMomentum(char dir, string how) const
    {
        return MglDataC(true, mgl_datac_momentum(this, dir, how.toStringz));
    }
    /// get sub-array of the data with given fixed indexes
    MglDataC subData(long xx, long yy =  - 1, long zz =  - 1) const
    {
        return MglDataC(true, mgl_datac_subdata(this, xx, yy, zz));
    }
    MglDataC subData(in MglDataA* xx, in MglDataA* yy, in MglDataA* zz) const
    {
        return MglDataC(true, mgl_datac_subdata_ext(this,  & xx,  & yy,  & zz));
    }
    MglDataC subData(in MglDataA* xx, in MglDataA* yy) const
    {
        return MglDataC(true, mgl_datac_subdata_ext(this,  & xx,  & yy, 0));
    }
    MglDataC subData(in MglDataA* xx) const
    {
        return MglDataC(true, mgl_datac_subdata_ext(this,  & xx, 0, 0));
    }
    /// get trace of the data array
    MglDataC trace() const
    {
        return MglDataC(true, mgl_datac_trace(this));
    }
    /// get array which is result of summation in given direction or directions
    MglDataC sum(string dir) const
    {
        return MglDataC(true, mgl_datac_sum(this, dir.toStringz));
    }
    /// get the data which is direct multiplication (like, d[i,j] = this[i]*a[j] and so on)
    MglDataC combine(in MglDataA* dat) const
    {
        return MglDataC(true, mgl_datac_combine(this,  & dat));
    }
    /// Resize the data to new size of box [x1,x2]*[y1,y2]*[z1,z2]
    MglDataC resize(long mx, long my = 1, long mz = 1, mreal x1 = 0,
        mreal x2 = 1, mreal y1 = 0, mreal y2 = 1, mreal z1 = 0, mreal z2 = 1) const
    {
        return MglDataC(true, mgl_datac_resize_box(this, mx, my, mz, x1, x2, y1, y2,
            z1, z2));
    }
    /// get array which values is result of interpolation this for coordinates from other arrays
    MglDataC evaluate(const MglData* idat, bool norm = true) const
    {
        return MglDataC(true, mgl_datac_evaluate(this,  & idat, 0, 0, norm));
    }
    MglDataC evaluate(const MglData* idat, const MglData* jdat, bool norm = true) const
    {
        return MglDataC(true, mgl_datac_evaluate(this,  & idat,  & jdat, 0, norm));
    }
    MglDataC evaluate(const MglData* idat, const MglData* jdat,
        const MglData* kdat, bool norm = true) const
    {
        return MglDataC(true, mgl_datac_evaluate(this,  & idat,  & jdat,  & kdat, norm));
    }

    /// Find correlation with another data arrays
    MglDataC correlation(const MglData* dat, const char * dir) const
    {
        return MglDataC(true, mgl_datac_correl(this,  & dat, dir));
    }
    /// Find auto correlation function
    MglDataC autoCorrelation(const char * dir) const
    {
        return MglDataC(true, mgl_datac_correl(this, this, dir));
    }

    /// Create n-th points distribution of this data values in range [v1, v2]
    MglData hist(long n, mreal v1 = 0, mreal v2 = 1, long nsub = 0) const
    {
        return MglData(true, mgl_data_hist(this, n, v1, v2, nsub));
    }
    /// Create n-th points distribution of this data values in range [v1, v2] with weight w
    MglData hist(in MglDataA* w, long n, mreal v1 = 0, mreal v2 = 1, long nsub = 0) const
    {
        return MglData(true, mgl_data_hist_w(this,  & w, n, v1, v2, nsub));
    }
    /// get array which is result of maximal values in given direction or directions
    MglData max(const char * dir) const
    {
        return MglData(true, mgl_data_max_dir(this, dir.toStringz));
    }
    /// get array which is result of minimal values in given direction or directions
    MglData min(const char * dir) const
    {
        return MglData(true, mgl_data_min_dir(this, dir.toStringz));
    }

    /// Cumulative summation the data in given direction or directions
    void cumSum(string dir)
    {
        mgl_datac_cumsum(this, dir.toStringz);
    }

    /// Integrate (cumulative summation) the data in given direction or directions
    void integral(string dir)
    {
        mgl_datac_integral(this, dir.toStringz);
    }

    /// Differentiate the data in given direction or directions
    void diff(string dir)
    {
        mgl_datac_diff(this, dir.toStringz);
    }

    /// Double-differentiate (like laplace operator) the data in given direction
    void diff2(string dir)
    {
        mgl_datac_diff2(this, dir.toStringz);
    }

    /// Swap left and right part of the data in given direction (useful for fourier spectrums)
    void swap(string dir)
    {
        mgl_datac_swap(this, dir.toStringz);
    }

    /// Roll data along direction dir by num slices
    void roll(char dir, long num)
    {
        mgl_datac_roll(this, dir, num);
    }

    /// Mirror the data in given direction (useful for fourier spectrums)
    void mirror(string dir)
    {
        mgl_datac_mirror(this, dir.toStringz);
    }

    /// Smooth the data on specified direction or directions
    void smooth(string dirs = "xyz", mreal delta = 0)
    {
        mgl_datac_smooth(this, dirs, delta);
    }

    /// Hankel transform
    void hankel(string dir)
    {
        mgl_datac_hankel(this, dir.toStringz);
    }

    /// Fourier transform
    void fft(string dir)
    {
        mgl_datac_fft(this, dir.toStringz);
    }

    /// Calculate one step of diffraction by finite-difference method with parameter q
    void diffraction(string how, mreal q)
    {
        mgl_datac_diffr(this, how, q);
    }

    /// Interpolate by cubic spline the data to given point x=[0...nx-1], y=[0...ny-1], z=[0...nz-1]
    dual spline(mreal x, mreal y = 0, mreal z = 0) const
    {
        return mgl_datac_spline(this, x, y, z);
    }
    /// Interpolate by cubic spline the data to given point x,\a y,\a z which normalized in range [0, 1]
    dual spline1(mreal x, mreal y = 0, mreal z = 0) const
    {
        return mgl_datac_spline(this, x * (nx - 1), y * (ny - 1), z * (nz - 1));
    }
    /// Interpolate by linear function the data to given point x=[0...nx-1], y=[0...ny-1], z=[0...nz-1]
    dual linear(mreal x, mreal y = 0, mreal z = 0) const
    {
        return mgl_datac_linear(this, x, y, z);
    }
    /// Interpolate by line the data to given point x,\a y,\a z which normalized in range [0, 1]
    dual linear1(mreal x, mreal y = 0, mreal z = 0) const
    {
        return mgl_datac_linear(this, x * (nx - 1), y * (ny - 1), z * (nz - 1));
    }
    /// Interpolate by linear function the data and return its derivatives at given point x=[0...nx-1], y=[0...ny-1], z=[0...nz-1]
    dual linear(mglPoint* dif, mreal x, mreal y = 0, mreal z = 0) const
    {
        dual val, dx, dy, dz;
        val = mgl_datac_linear_ext(this, x, y, z,  & dx,  & dy,  & dz);
        dif = mglPoint(dx.getReal, dy.getReal, dz.getReal);
        return val;
    }
    /// Interpolate by line the data and return its derivatives at given point x,\a y,\a z which normalized in range [0, 1]
    dual linear1(mglPoint* dif, mreal x, mreal y = 0, mreal z = 0) const
    {
        dual val, dx, dy, dz;
        val = mgl_datac_linear_ext(this, x, y, z,  & dx,  & dy,  & dz);
        dif = mglPoint(dx.getReal, dy.getReal, dz.getReal);
        dif.x /= nx > 1 ? nx - 1 : 1;
        dif.y /= ny > 1 ? ny - 1 : 1;
        dif.z /= nz > 1 ? nz - 1 : 1;
        return val;
    }
    /// Return an approximated x-value (root) when dat(x) = val
    mreal solve(mreal val, bool use_spline = true, long i0 = 0) const
    {
        return mgl_data_solve_1d(this, val, use_spline, i0);
    }
    /// Return an approximated value (root) when dat(x) = val
    MglData solve(mreal val, char dir, bool norm = true) const
    {
        return MglData(true, mgl_data_solve(this, val, dir, 0, norm));
    }
    MglData solve(mreal val, char dir, const MglData* i0, bool norm = true) const
    {
        return MglData(true, mgl_data_solve(this, val, dir,  & i0, norm));
    }

    /// Copy data from other MglDataA variable
    MglDataA* opAssign(in MglDataA* d)
    {
        if (this !=  & d)
            set( & d);
        return d;
    
    }
    auto opAssign(in MglDataC* d)
    {
        if (this !=  * d)
            this=*d;
        return d;
    }
    auto opAssign(dual val)
    {
        for (long i = 0; i < nx * ny * nz; i++)
            a[i] = val;
        return val;
    }
    auto opAssign(mreal val)
    {
        for (long i = 0; i < nx * ny * nz; i++)
            a[i] = val;
        return val;
    }
    static if ((!SWIG) && false)
    {
    	// Direct access to the data cell
    	/+
	    	dual & operator[](long i)
	    	{
	        	return a[i];
		    }
		+/

	}

    debug
    {
		// get the value in given cell of the data with border checking
	    mreal v(long i, long j = 0, long k = 0) const
	    {
	        return mgl_abs(mgl_datac_get_value(this, i, j, k));
	    }
	    /// Set the value in given cell of the data
	    void set_v(mreal val, long i, long j = 0, long k = 0)
	    {
	        mgl_datac_set_value(this, val, i, j, k);
	    }
	}
	else
	{
		// get the value in given cell of the data
	    mreal v(long i, long j = 0, long k = 0) const
	    {
	        return abs(a[i + nx * (j + ny * k)]);
	    }
	    /// Set the value in given cell of the data
	    void set_v(mreal val, long i, long j = 0, long k = 0)
	    {
	        a[i + nx * (j + ny * k)] = val;
	    }
	}
	
	mreal vthr(long i) const
    {
        return abs(a[i]);
    }

    // add for speeding up !!!
    mreal dvx(long i, long j = 0, long k = 0) const
    {
        long i0 = i + nx * (j + ny * k);
        return i > 0 ? abs(i < nx - 1 ? (a[i0 + 1] - a[i0 - 1]) / mgl2 : a[i0] - a[i0 - 1]) : abs(
            a[i0 + 1] - a[i0]);
    }

    mreal dvy(long i, long j = 0, long k = 0) const
    {
        long i0 = i + nx * (j + ny * k);
        return j > 0 ? abs(j < ny - 1 ? (a[i0 + nx] - a[i0 - nx]) / mgl2 : a[i0] - a[i0 - nx]) : abs(
            a[i0 + nx] - a[i0]);
    }

    mreal dvz(long i, long j = 0, long k = 0) const
    {
        long i0 = i + nx * (j + ny * k), n = nx * ny;
        return k > 0 ? abs(k < nz - 1 ? (a[i0 + n] - a[i0 - n]) / mgl2 : a[i0] - a[i0 - n]) : abs(
            a[i0 + n] - a[i0]);
    }
}
static if(!SWIG)
{
	dual mglLinearC(const dual * a, long nx, long ny, long nz, mreal x, mreal y, mreal z);
	dual mglSpline3C(const dual * a, long nx, long ny, long nz, mreal x, mreal y, mreal z, dual * dx = 0, dual * dy = 0, dual * dz = 0);
	dual mglSpline3Cs(const dual * a, long nx, long ny, long nz, mreal x, mreal y, mreal z);
}

/// saves result of PDE solving (|u|^2) for "Hamiltonian" ham with initial conditions ini
MglDataC mglPDEc(mglBase * gr, const char * ham, in MglDataA* ini_re,
    in MglDataA* ini_im, mreal dz = 0.1, mreal k0 = 100, string opt= "")
{
    return MglDataC(true, mgl_pde_solve_c(gr, ham,  & ini_re,  & ini_im, dz, k0, opt.toStringz));
}
/// saves result of PDE solving for "Hamiltonian" ham with initial conditions ini along a curve ray (must have nx>=7 - x,y,z,px,py,pz,tau or nx=5 - x,y,px,py,tau)
MglDataC mglQO2dc(const char * ham, in MglDataA* ini_re, in MglDataA* ini_im, in MglDataA* ray, mreal r = 1,
	mreal k0 = 100)
{
    return MglDataC(true, mgl_qo2d_solve_c(ham,  & ini_re,  & ini_im,  & ray, r, k0, 0, 0));
}

MglDataC mglQO2dc(const char * ham, in MglDataA* ini_re,
    in MglDataA* ini_im, in MglDataA* ray, MglData* xx, MglData* yy,
    mreal r = 1, mreal k0 = 100)
{
    return MglDataC(true, mgl_qo2d_solve_c(ham,  & ini_re,  & ini_im,  & ray, r, k0,
         & xx,  & yy));
}

/// saves result of PDE solving for "Hamiltonian" ham with initial conditions ini along a curve ray (must have nx>=7 - x,y,z,px,py,pz,tau or nx=5 - x,y,px,py,tau)
MglDataC mglQO3dc(const char * ham, in MglDataA* ini_re,
    in MglDataA* ini_im, in MglDataA* ray, mreal r = 1, mreal k0 = 100)
{
    return MglDataC(true, mgl_qo3d_solve_c(ham,  & ini_re,  & ini_im,  & ray, r, k0,
        0, 0, 0));
}

MglDataC mglQO3dc(string ham, in MglDataA* ini_re, in MglDataA* ini_im, in MglDataA* ray, MglData* xx, MglData* yy,
    MglData* zz, mreal r = 1, mreal k0 = 100)
{
    return MglDataC(true, mgl_qo3d_solve_c(ham.toStringz,  & ini_re,  & ini_im,  & ray, r,
        k0,  & xx,  & yy,  & zz));
}
//-----------------------------------------------------------------------------
/// Prepare coefficients for global spline interpolation
MglDataC mglGSplineCInit(in MglDataA* xdat, in MglDataA* ydat)
{
    return MglDataC(true, mgl_gsplinec_init( & xdat,  & ydat));
}
/// Evaluate global spline (and its derivatives d1, d2 if not NULL) using prepared coefficients \a coef
dual mglGSplineC(in MglDataA* coef, mreal dx, dual * d1 = 0, dual * d2 = 0)
{
    return mgl_gsplinec( & coef, dx, d1, d2);
}
auto _DN_(T)(T a)
{
	return (cast(MglDataC * ) * (a));
}
auto _DC_()
{
	return (cast(MglDataC * ) * d);
}

static if(!SWIG)
{
	//Wrapper class for complex expression evaluating
	class mglExprC
	{
	    HAEX ex;
	    this(in mglExprC* inp)
	    {
	    } // copying is not allowed
	    
	    const mglExprC* opAssign(const mglExprC* t)
	    {
	        return t;
	    }

	    this(string expr)
	    {
	        ex = mgl_create_cexpr(expr.toStringz);
	    }
	     
	     ~ this()
	    {
	        mgl_delete_cexpr(ex);
	    }

	    // Return value of expression for given x,y,z variables
	    dual Eval(dual x, dual y = 0, dual z = 0)
	    {
	        return mgl_cexpr_eval(ex, x, y, z);
	    }

	    // Return value of expression for given x,y,z,u,v,w variables
	    dual Eval(dual x, dual y, dual z, dual u, dual v, dual w)
	    {
	        dual var[26];
	        var['x' - 'a'] = x;
	        var['y' - 'a'] = y;
	        var['z' - 'a'] = z;
	        var['u' - 'a'] = u;
	        var['v' - 'a'] = v;
	        var['w' - 'a'] = w;
	        return mgl_cexpr_eval_v(ex, var);
	    }
	    /// Return value of expression for given variables
	    dual Eval(dual var[26])
	    {
	        return mgl_cexpr_eval_v(ex, var);
	    }
	}
}
