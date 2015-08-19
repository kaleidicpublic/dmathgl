/**
	Ported to dlang 2015 by Laeeth Isharc
*/
/***************************************************************************
 * data.h is part of Math Graphic Library
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


/// Class for working with data array
class MglData
{
    //public : using MglDataA :  : Momentum;
    long nx; ///< number of points in 1st dimensions ('x' dimension)
    long ny; ///< number of points in 2nd dimensions ('y' dimension)
    long nz; ///< number of points in 3d dimensions ('z' dimension)
    mreal* a; ///< data array
	string id; ///< column (or slice) names
    bool useLink; ///< use external data (i.e. don't free it)

    /// Initiate by other MglData variable
    this(const MglData* d)
    {
        a = 0;
        mgl_data_set(this,  & d);
    } // NOTE: must be constructor for MglData& to exclude copy one
    
    static if(HaveRval)
    {
    	this(MglData** d)
    	{
    		this.nx=d.nx;
    		this.ny=d.ny;
    		this.nz=d.nz;
    		thia.a=d.a;
    		this.id=d.id;
    		this.useLink=d.useLink;
	    	//this. s = d.s;
        	//this.temp = d.temp;
        	this.func = d.func;
        	this.o = d.o;
        	d.a = 0;
        	d.func = 0;
        }
    }

    this(const MglDataA* d)
    {
        a = 0;
        if (d)
            mgl_data_set(this, d);
        else
            mgl_data_create(this, 1, 1, 1);
    }

    this(MglData * d) // NOTE: Variable d will be deleted!!!
    {
        if (d is null)
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
            useLink = d.useLink;
            delete d;
        }
        else
        {
            a = 0;
            create(1);
        }
    }

    /// Initiate by flat array
    this(int size, const float * d)
    {
        a = 0;
        set(d, size);
    }
    this(int rows, int cols, const float * d)
    {
        a = 0;
        set(d, cols, rows);
    }
    this(int size, const double * d)
    {
        a = 0;
        set(d, size);
    }
    this(int rows, int cols, const double * d)
    {
        a = 0;
        set(d, cols, rows);
    }
    this(const double * d, int size)
    {
        a = 0;
        set(d, size);
    }
    this(const double * d, int rows, int cols)
    {
        a = 0;
        set(d, cols, rows);
    }
    this(const float * d, int size)
    {
        a = 0;
        set(d, size);
    }
    this(const float * d, int rows, int cols)
    {
        a = 0;
        set(d, cols, rows);
    }
    /// Read data from file
    this(string fname)
    {
        a = 0;
        Read(fname);
    }
    /// allocate the memory for data array and initialize it zero
    this(long xx = 1, long yy = 1, long zz = 1)
    {
        a = 0;
        create(xx, yy, zz);
    }
    
    /// Delete the array
    ~this()
    {
        //if (!useLink && a)
          //  delete[] a;
    }

    mreal getVal(long i, long j = 0, long k = 0) const
    {
        return mgl_data_get_value(this, i, j, k);
    }

    void setVal(mreal f, long i, long j = 0, long k = 0)
    {
        mgl_data_set_value(this, f, i, j, k);
    }

    /// Get sizes
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
    void link(mreal* A, long NX, long NY = 1, long NZ = 1)
    {
        mgl_data_link(this, A, NX, NY, NZ);
    }

    void link(MglData* d)
    {
        link(d.a, d.nx, d.ny, d.nz);
    }
    /// allocate memory and copy the data from the gsl_vector
    void set(gsl_vector* m)
    {
        mgl_data_set_vector(this, m);
    }

    /// allocate memory and copy the data from the gsl_matrix
    void set(gsl_matrix* m)
    {
        mgl_data_set_matrix(this, m);
    }

    /// allocate memory and copy the data from the (float *) array
    void set(in float* A, long NX, long NY = 1, long NZ = 1)
    {
        mgl_data_set_float(this, A, NX, NY, NZ);
    }

    /// allocate memory and copy the data from the (double *) array
    void set(const double* A, long NX, long NY = 1, long NZ = 1)
    {
        mgl_data_set_double(this, A, NX, NY, NZ);
    }

    /// allocate memory and copy the data from the (float **) array
    void set(in float** A, long N1, long N2)
    {
        mgl_data_set_float2(this, A, N1, N2);
    }
    /// allocate memory and copy the data from the (double **) array
    void set(in double** A, long N1, long N2)
    {
        mgl_data_set_double2(this, A, N1, N2);
    }
    /// allocate memory and copy the data from the (float ***) array
    void set(in float** A, long N1, long N2, long N3)
    {
        mgl_data_set_float3(this, A, N1, N2, N3);
    }
    /// allocate memory and copy the data from the (double ***) array
    void set(in double** A, long N1, long N2, long N3)
    {
        mgl_data_set_double3(this, A, N1, N2, N3);
    }
    /// allocate memory and scanf the data from the string
    void set(string str, long NX, long NY = 1, long NZ = 1)
    {
        mgl_data_set_values(this, str.toStringz, NX, NY, NZ);
    }

    /// Import data from abstract type
    void set(HCDT dat)
    {
        mgl_data_set(this, dat);
    }

    void set(const MglDataA* dat)
    {
        mgl_data_set(this,  & dat);
    }
    /// allocate memory and copy data from std::vector<T>
    void set(int[]  d)
    {
        if (d.length < 1)
            return;
        create(d.length);
        for (long i = 0; i < nx; i++)
            a[i] = d[i];
    }
    void set(float[] d)
    {
        if (d.length < 1)
            return;
        create(d.length);
        foreach(i;0..nx)
            a[i] = d[i];
    }
    void set(double[] d)
    {
        if (d.length < 1)
            return;
        create(d.length);
        foreach(i;0..nx)
            a[i] = d[i];
    }

    /// create or recreate the array with specified size and fill it by zero
    void create(long mx, long my = 1, long mz = 1)
    {
        mgl_data_create(this, mx, my, mz);
    }

    /// Rearange data dimensions
    void rearrange(long mx, long my = 0, long mz = 0)
    {
        mgl_data_rearrange(this, mx, my, mz);
    }

    /// Transpose dimensions of the data (generalization of Transpose)
    void transpose(string dim = "yx")
    {
        mgl_data_transpose(this, dim);
    }

    /// Extend data dimensions
    void extend(long n1, long n2 = 0)
    {
        mgl_data_extend(this, n1, n2);
    }

    /// Reduce size of the data
    void squeeze(long rx, long ry = 1, long rz = 1, bool smooth = false)
    {
        mgl_data_squeeze(this, rx, ry, rz, smooth);
    }

    /// Crop the data
    void crop(long n1, long n2, char dir = 'x')
    {
        mgl_data_crop(this, n1, n2, dir);
    }

    /// Insert data rows/columns/slices
    void insert(char dir, long at = 0, long num = 1)
    {
        mgl_data_insert(this, dir, at, num);
    }

    /// Delete data rows/columns/slices
    void deleteItems(char dir, long at = 0, long num = 1)
    {
        mgl_data_delete(this, dir, at, num);
    }

    /// Remove rows with duplicate values in column id
    void clean(long id)
    {
        mgl_data_clean(this, id);
    }

    /// Join with another data array
    void join(const MglDataA* d)
    {
        mgl_data_join(this, *d);
    }

    /// Modify the data by specified formula
    void modify(string eq, long dim = 0)
    {
        mgl_data_modify(this, eq.toStringz, dim);
    }

    /// Modify the data by specified formula
    void modify(string eq, in MglDataA* vdat, in MglDataA* wdat)
    {
        mgl_data_modify_vw(this, eq.to!stringz,  *vdat,  * wdat);
    }
    /// Modify the data by specified formula
    void modify(string eq, const MglDataA* vdat)
    {
        mgl_data_modify_vw(this, eq.toStringz,  *vdat, 0);
    }
    /// Modify the data by specified formula assuming x,y,z in range [r1,r2]
    void fill(HMGL gr, string eq, string opt = "")
    {
        mgl_data_fill_eq(gr, this, eq.toStringz, 0, 0, opt);
    }

    void fill(HMGL gr, string eq, const MglDataA* vdat, string opt = "")
    {
        mgl_data_fill_eq(gr, this, eq.toStringz,  *vdat, 0, opt.toStringz);
    }

    void fill(HMGL gr, string eq, const MglDataA* vdat, const MglDataA* wdat, string opt = "")
    {
        mgl_data_fill_eq(gr, this, eq.toStringz,  *vdat,  * wdat, opt.toStringz);
    }
    /// Equidistantly fill the data to range [x1,x2] in direction dir
    void fill(mreal x1, mreal x2 = mglNaN, char dir = 'x')
    {
        mgl_data_fill(this, x1, x2, dir);
    }

    /// fill the data by interpolated values of vdat parametrically depended on xdat,ydat,zdat for x,y,z in range [p1,p2] using global spline
    void refillGS(in MglDataA* xdat, const MglDataA*  vdat, mreal x1, mreal x2,
        long sl =  - 1)
    {
        mgl_data_refill_gs(this, *xdat,  & vdat, x1, x2, sl);
    }
    /// fill the data by interpolated values of vdat parametrically depended on xdat,ydat,zdat for x,y,z in range [p1,p2]
    void refill(in MglDataA* xdat, in MglDataA* vdat, mreal x1, mreal x2, long sl =  - 1)
    {
        mgl_data_refill_x(this, *xdat,  & vdat, x1, x2, sl);
    }
    void refill(in MglDataA* xdat, in MglDataA* vdat, MglPoint p1, MglPoint p2,
        long sl =  - 1)
    {
        mgl_data_refill_x(this, *xdat,  & vdat, p1.x, p2.x, sl);
    }
    void refill(in MglDataA* xdat, in MglDataA* ydat, in MglDataA* vdat,
        MglPoint p1, MglPoint p2, long sl =  - 1)
    {
        mgl_data_refill_xy(this, *xdat,  & ydat,  & vdat, p1.x, p2.x, p1.y, p2.y,
            sl);
    }
    void refill(in MglDataA* xdat, in MglDataA* ydat, in MglDataA* zdat,
        in MglDataA* vdat, MglPoint p1, MglPoint p2)
    {
        mgl_data_refill_xyz(this, *xdat,  & ydat,  & zdat,  & vdat, p1.x, p2.x,
            p1.y, p2.y, p1.z, p2.z);
    }
    /// fill the data by interpolated values of vdat parametrically depended on xdat,ydat,zdat for x,y,z in axis range of gr
    void refill(HMGL gr, in MglDataA* xdat, in MglDataA* vdat,
        long sl =  - 1, string opt = "")
    {
        mgl_data_refill_gr(gr, this, *xdat, 0, 0,  & vdat, sl, opt);
    }
    void refill(HMGL gr, in MglDataA* xdat, in MglDataA* ydat,
        in MglDataA* vdat, long sl =  - 1, string opt = "")
    {
        mgl_data_refill_gr(gr, this, *xdat,  & ydat, 0,  & vdat, sl, opt);
    }
    void refill(HMGL gr, in MglDataA* xdat, in MglDataA* ydat,
        in MglDataA* zdat, in MglDataA* vdat, string opt = "")
    {
        mgl_data_refill_gr(gr, this, *xdat,  & ydat,  & zdat,  & vdat,  - 1, opt);
    }
    /// set the data by triangulated surface values assuming x,y,z in axis range of gr
    void grid(HMGL gr, in MglDataA* x, in MglDataA* y, in MglDataA* z, string opt = "")
    {
        mgl_data_grid(gr, this,  *x,  *y,  *z, opt.toStringz);
    }
    /// set the data by triangulated surface values assuming x,y,z in range [p1, p2]
    void grid(in MglDataA* xdat, in MglDataA* ydat, in MglDataA* vdat,
        MglPoint p1, MglPoint p2)
    {
        mgl_data_grid_xy(this, *xdat,  & ydat,  & vdat, p1.x, p2.x, p1.y, p2.y);
    }
    /// Put value to data element(s)
    void put(mreal val, long i = -1, long j = -1, long k = -1)
    {
        mgl_data_put_val(this, val, i, j, k);
    }

    /// Put array to data element(s)
    void put(in MglDataA* dat, long i =  - 1, long j =  - 1, long k =  - 1)
    {
        mgl_data_put_dat(this,  & dat, i, j, k);
    }
    /// set names for columns (slices)
    void setColumnId(string ids)
    {
        mgl_data_set_id(this, ids);
    }

    /// Make new id
    void newId()
    {
        id.clear();
    }

    /// Read data from tab-separated text file with auto determining size
    bool read(string fname)
    {
        return mgl_data_read(this, fname);
    }

    /// Read data from text file with specifeid size
    bool read(string fname, long mx, long my = 1, long mz = 1)
    {
        return mgl_data_read_dim(this, fname.toStringz, mx, my, mz);
    }

    /// Import data array from PNG file according color scheme
    void importData(string fname, string scheme, mreal v1 = 0, mreal v2 = 1)
    {
        mgl_data_import(this, fname.toStringz, scheme.toStringz, v1, v2);
    }

    /// Read data from tab-separated text files with auto determining size which filenames are result of sprintf(fname,templ,t) where t=from:step:to
    bool readRange(string templ, double from, double to, double step = 1, bool as_slice = false)
    {
        return mgl_data_read_range(this, templ.toStringz, from, to, step, as_slice);
    }

    /// Read data from tab-separated text files with auto determining size which filenames are satisfied to template (like "t_*.dat")
    bool readall(string templ, bool as_slice = false)
    {
        return mgl_data_read_all(this, templ.toStringz, as_slice);
    }

    /// Read data from text file with size specified at beginning of the file
    bool readMat(string fname, long dim = 2)
    {
        return mgl_data_read_mat(this, fname.toStringz, dim);
    }

    /// Read data array from HDF file (parse HDF4 and HDF5 files)
    int readHDF(string fname, ubyte[] data)
    {
        return mgl_data_read_hdf(this, fname.toStringz, data.ptr);
    }

    /// Get column (or slice) of the data filled by formulas of named columns
    MglData Column(string eq) const
    {
        return MglData(true, mgl_data_column(this, eq.toStringz));
    }

    /// Get momentum (1D-array) of data along direction 'dir'. String looks like "x1" for median in x-direction, "x2" for width in x-dir and so on.
    MglData Momentum(char dir, string how) const
    {
        return MglData(true, mgl_data_momentum(this, dir, how.toStringz));
    }

    /// Get sub-array of the data with given fixed indexes
    MglData SubData(long xx, long yy = -1, long zz = -1) const
    {
        return MglData(true, mgl_data_subdata(this, xx, yy, zz));
    }

    MglData SubData(in MglDataA* xx, in MglDataA* yy, in MglDataA* zz) const
    {
        return MglData(true, mgl_data_subdata_ext(this,  & xx,  & yy,  & zz));
    }
    MglData SubData(in MglDataA* xx, in MglDataA* yy) const
    {
        return MglData(true, mgl_data_subdata_ext(this,  & xx,  & yy, 0));
    }
    MglData subData(in MglDataA* xx) const
    {
        return MglData(true, mgl_data_subdata_ext(this,  & xx, 0, 0));
    }
    /// Get trace of the data array
    MglData trace() const
    {
        return MglData(true, mgl_data_trace(this));
    }

    /// create n-th points distribution of this data values in range [v1, v2]
    MglData hist(long n, mreal v1 = 0, mreal v2 = 1, long nsub = 0) const
    {
        return MglData(true, mgl_data_hist(this, n, v1, v2, nsub));
    }

    /// create n-th points distribution of this data values in range [v1, v2] with weight w
    MglData hist(in MglDataA* w, long n, mreal v1 = 0, mreal v2 = 1, long nsub = 0) const
    {
        return MglData(true, mgl_data_hist_w(this,  & w, n, v1, v2, nsub));
    }
    /// Get array which is result of summation in given direction or directions
    MglData sum(string dir) const
    {
        return MglData(true, mgl_data_sum(this, dir));
    }

    /// Get array which is result of maximal values in given direction or directions
    MglData max(string dir) const
    {
        return MglData(true, mgl_data_max_dir(this, dir));
    }

    /// Get array which is result of minimal values in given direction or directions
    MglData min(string dir) const
    {
        return MglData(true, mgl_data_min_dir(this, dir));
    }

    /// Get the data which is direct multiplication (like, d[i,j] = this[i]*a[j] and so on)
    MglData combine(in MglDataA* dat) const
    {
        return MglData(true, mgl_data_combine(this,  & dat));
    }
    /// Resize the data to new size of box [x1,x2]*[y1,y2]*[z1,z2]
    MglData resize(long mx, long my = 0, long mz = 0, mreal x1 = 0, mreal x2 = 1,
        mreal y1 = 0, mreal y2 = 1, mreal z1 = 0, mreal z2 = 1) const
    {
        return MglData(true, mgl_data_resize_box(this, mx, my, mz, x1, x2, y1, y2,
            z1, z2));
    }

    /// Get array which values is result of interpolation this for coordinates from other arrays
    MglData evaluate(in MglData* idat, bool norm = true) const
    {
        return MglData(true, mgl_data_evaluate(this,  & idat, 0, 0, norm));
    }
    MglData evaluate(in MglData* idat, in MglData* jdat, bool norm = true) const
    {
        return MglData(true, mgl_data_evaluate(this,  & idat,  & jdat, 0, norm));
    }
    MglData evaluate(in MglData* idat, in MglData* jdat, in MglData* kdat,
        bool norm = true) const
    {
        return MglData(true, mgl_data_evaluate(this,  & idat,  & jdat,  & kdat, norm));
    }
    /// Find roots for set of nonlinear equations defined by textual formula
    MglData roots(string func, char var = 'x') const
    {
        return MglData(true, mgl_data_roots(func, this, var));
    }

    /// Find correlation with another data arrays
    MglData correl(in MglDataA* dat, string dir) const
    {
        return MglData(true, mgl_data_correl(this,  & dat, dir));
    }
    /// Find auto correlation function
    MglData autoCorrel(string dir) const
    {
        return MglData(true, mgl_data_correl(this, this, dir));
    }

    /// Cumulative summation the data in given direction or directions
    void cumSum(string dir)
    {
        mgl_data_cumsum(this, dir);
    }

    /// Integrate (cumulative summation) the data in given direction or directions
    void integral(string dir)
    {
        mgl_data_integral(this, dir);
    }

    /// Differentiate the data in given direction or directions
    void diff(string dir)
    {
        mgl_data_diff(this, dir);
    }

    /// Differentiate the parametrically specified data along direction v1 with v2=const
    void diff(ref MglDataA v1, ref MglDataA v2)
    {
        mgl_data_diff_par(this,  v1,  v2, 0);
    }
    /// Differentiate the parametrically specified data along direction v1 with v2,v3=const
    void diff(ref MglDataA v1,ref MglDataA v2, ref MglDataA v3)
    {
        mgl_data_diff_par(this,  v1,  v2,  v3);
    }
    /// Double-differentiate (like Laplace operator) the data in given direction
    void Diff2(string dir)
    {
        mgl_data_diff2(this, dir);
    }

    /// Swap left and right part of the data in given direction (useful for Fourier spectrum)
    void Swap(string dir)
    {
        mgl_data_swap(this, dir);
    }

    /// Roll data along direction dir by num slices
    void Roll(char dir, long num)
    {
        mgl_data_roll(this, dir, num);
    }

    /// Mirror the data in given direction (useful for Fourier spectrum)
    void Mirror(string dir)
    {
        mgl_data_mirror(this, dir);
    }

    /// Sort rows (or slices) by values of specified column
    void Sort(long idx, long idy = -1)
    {
        mgl_data_sort(this, idx, idy);
    }

    /// set as the data envelop
    void Envelop(char dir = 'x')
    {
        mgl_data_envelop(this, dir);
    }

    /// Remove phase jump
    void Sew(string dirs = "xyz", mreal da = 2 * mglPi)
    {
        mgl_data_sew(this, dirs, da);
    }

    /// Smooth the data on specified direction or directions
    void Smooth(string dirs = "xyz", mreal delta = 0)
    {
        mgl_data_smooth(this, dirs, delta);
    }

    /// Normalize the data to range [v1,v2]
    void Norm(mreal v1 = 0, mreal v2 = 1, bool sym = false, long dim = 0)
    {
        mgl_data_norm(this, v1, v2, sym, dim);
    }

    /// Normalize the data to range [v1,v2] slice by slice
    void NormSl(mreal v1 = 0, mreal v2 = 1, char dir = 'z', bool keep_en = true, bool sym = false)
    {
        mgl_data_norm_slice(this, v1, v2, dir, keep_en, sym);
    }

    /// Apply Hankel transform
    void Hankel(string dir)
    {
        mgl_data_hankel(this, dir);
    }

    /// Apply Sin-Fourier transform
    void SinFFT(string dir)
    {
        mgl_data_sinfft(this, dir);
    }

    /// Apply Cos-Fourier transform
    void CosFFT(string dir)
    {
        mgl_data_cosfft(this, dir);
    }

    /// fill data by 'x'/'k' samples for Hankel ('h') or Fourier ('f') transform
    void fillSample(string how)
    {
        mgl_data_fill_sample(this, how);
    }

    /// Return an approximated x-value (root) when dat(x) = val
    mreal Solve(mreal val, bool use_spline = true, long i0 = 0) const
    {
        return mgl_data_solve_1d(this, val, use_spline, i0);
    }

    /// Return an approximated value (root) when dat(x) = val
    MglData solve(mreal val, char dir, bool norm = true) const
    {
        return MglData(true, mgl_data_solve(this, val, dir, 0, norm));
    }

    MglData solve(mreal val, char dir, in MglData* i0, bool norm = true) const
    {
        return MglData(true, mgl_data_solve(this, val, dir,  & i0, norm));
    }

    /// Interpolate by cubic spline the data to given point x=[0...nx-1], y=[0...ny-1], z=[0...nz-1]
    mreal spline(mreal x, mreal y = 0, mreal z = 0) const
    {
        return mgl_data_spline(this, x, y, z);
    }

    /// Interpolate by cubic spline the data to given point x,\a y,\a z which normalized in range [0, 1]
    mreal spline1(mreal x, mreal y = 0, mreal z = 0) const
    {
        return mgl_data_spline(this, x * (nx - 1), y * (ny - 1), z * (nz - 1));
    }

    /// Interpolate by linear function the data to given point x=[0...nx-1], y=[0...ny-1], z=[0...nz-1]
    mreal linear(mreal x, mreal y = 0, mreal z = 0) const
    {
        return mgl_data_linear(this, x, y, z);
    }

    /// Interpolate by line the data to given point x,\a y,\a z which normalized in range [0, 1]
    mreal linear1(mreal x, mreal y = 0, mreal z = 0) const
    {
        return mgl_data_linear(this, x * (nx - 1), y * (ny - 1), z * (nz - 1));
    }

    /// Interpolate by cubic spline the data and return its derivatives at given point x=[0...nx-1], y=[0...ny-1], z=[0...nz-1]
    mreal spline(ref MglPoint dif, mreal x, mreal y = 0, mreal z = 0) const
    {
        return mgl_data_spline_ext(this, x, y, z,  & (dif.x),  & (dif.y),  & (dif.z));
    }
    /// Interpolate by cubic spline the data and return its derivatives at given point x,\a y,\a z which normalized in range [0, 1]
    mreal spline1(ref MglPoint dif, mreal x, mreal y = 0, mreal z = 0) const
    {
        mreal res = mgl_data_spline_ext(this, x * (nx - 1), y * (ny - 1),
            z * (nz - 1), &(dif.x), &(dif.y), &(dif.z));
        dif.x *= nx > 1 ? nx - 1 : 1;
        dif.y *= ny > 1 ? ny - 1 : 1;
        dif.z *= nz > 1 ? nz - 1 : 1;
        return res;
    }
    /// Interpolate by linear function the data and return its derivatives at given point x=[0...nx-1], y=[0...ny-1], z=[0...nz-1]
    mreal linear(ref MglPoint dif, mreal x, mreal y = 0, mreal z = 0) const
    {
        return mgl_data_linear_ext(this, x, y, z,  & (dif.x),  & (dif.y),  & (dif.z));
    }
    /// Interpolate by line the data and return its derivatives at given point x,\a y,\a z which normalized in range [0, 1]
    mreal linear1(ref MglPoint dif, mreal x, mreal y = 0, mreal z = 0) const
    {
        mreal res = mgl_data_linear_ext(this, x * (nx - 1), y * (ny - 1),
            z * (nz - 1), &(dif.x), &(dif.y), &(dif.z));
        dif.x *= nx > 1 ? nx - 1 : 1;
        dif.y *= ny > 1 ? ny - 1 : 1;
        dif.z *= nz > 1 ? nz - 1 : 1;
        return res;
    }
/**
    /// Copy data from other MglData variable
    in MglDataA* operator = (in MglDataA* d)
    {
        if (this !=  & d)
            mgl_data_set(this,  & d);
        return d;
    }
    in MglData* operator = (in MglData* d)
    {
        if (this !=  & d)
            mgl_data_set(this,  & d);
        return d;
    }
    mreal operator = (mreal val)
    {
        mgl_data_fill(this, val, val, 'x');
        return val;
    }
    /// Multiply the data by other one for each element
    void operator *= (in MglDataA* d)
    {
        mgl_data_mul_dat(this,  & d);
    }
    /// Divide the data by other one for each element
    void operator /= (in MglDataA* d)
    {
        mgl_data_div_dat(this,  & d);
    }
    /// Add the other data
    void operator += (in MglDataA* d)
    {
        mgl_data_add_dat(this,  & d);
    }
    /// Subtract the other data
    void operator -= (in MglDataA* d)
    {
        mgl_data_sub_dat(this,  & d);
    }
    /// Multiply each element by the number
    void operator *= (mreal d)
    {
        mgl_data_mul_num(this, d);
    }
    /// Divide each element by the number
    void operator /= (mreal d)
    {
        mgl_data_div_num(this, d);
    }
    /// Add the number
    void operator += (mreal d)
    {
        mgl_data_add_num(this, d);
    }
    /// Subtract the number
    void operator -= (mreal d)
    {
        mgl_data_sub_num(this, d);
    }
    #ifndef SWIG/// Direct access to the data cell
    mreal & operator[](long i)
    {
        return a[i];
    }
    // NOTE see 13.10 for operator(), operator[] -- m.b. I should add it ???
    #endif debug
    {
        /// Get the value in given cell of the data
        mreal v(long i, long j = 0, long k = 0) const
        {
            return a[i + nx * (j + ny * k)];
        }

        /// set the value in given cell of the data
        void set_v(mreal val, long i, long j = 0, long k = 0)
        {
            a[i + nx * (j + ny * k)] = val;
        }
    }
    else
    {
        /// Get the value in given cell of the data with border checking
        mreal v(long i, long j = 0, long k = 0) const
        {
            return mgl_data_get_value(this, i, j, k);
        }

        /// set the value in given cell of the data
        void set_v(mreal val, long i, long j = 0, long k = 0)
        {
            mgl_data_set_value(this, val, i, j, k);
        }
    }
   */
    mreal vthr(long i) const
    {
        return a[i];
    }

    // add for speeding up !!!
    mreal dvx(long i, long j = 0, long k = 0) const
    {
        long i0 = i + nx * (j + ny * k);
        return i > 0 ? (i < nx - 1 ? (a[i0 + 1] - a[i0 - 1]) / 2 : a[i0] - a[i0 - 1])
            : a[i0 + 1] - a[i0];
    }

    mreal dvy(long i, long j = 0, long k = 0) const
    {
        long i0 = i + nx * (j + ny * k);
        return j > 0 ? (j < ny - 1 ? (a[i0 + nx] - a[i0 - nx]) / 2 : a[i0] - a[i0 - nx])
            : a[i0 + nx] - a[i0];
    }

    mreal dvz(long i, long j = 0, long k = 0) const
    {
        long i0 = i + nx * (j + ny * k), n = nx * ny;
        return k > 0 ? (k < nz - 1 ? (a[i0 + n] - a[i0 - n]) / 2 : a[i0] - a[i0 - n])
            : a[i0 + n] - a[i0];
    }
};
//-----------------------------------------------------------------------------
static if (!SWIG)
{
	/*
	MglData operator * (in MglDataA* b, in MglDataA* d)
	{
	    MglData a( & b);
	    a *= d;
	    return a;
	}
	MglData operator * (mreal b, in MglDataA* d)
	{
	    MglData a( & d);
	    a *= b;
	    return a;
	}
	MglData operator * (in MglDataA* d, mreal b)
	{
	    MglData a( & d);
	    a *= b;
	    return a;
	}
	MglData operator - (in MglDataA* b, in MglDataA* d)
	{
	    MglData a( & b);
	    a -= d;
	    return a;
	}
	MglData operator - (mreal b, in MglDataA* d)
	{
	    MglData a( & d);
	    a -= b;
	    return a;
	}
	MglData operator - (in MglDataA* d, mreal b)
	{
	    MglData a( & d);
	    a -= b;
	    return a;
	}
	MglData operator + (in MglDataA* b, in MglDataA* d)
	{
	    MglData a( & b);
	    a += d;
	    return a;
	}
	MglData operator + (mreal b, in MglDataA* d)
	{
	    MglData a( & d);
	    a += b;
	    return a;
	}
	MglData operator + (in MglDataA* d, mreal b)
	{
	    MglData a( & d);
	    a += b;
	    return a;
	}
	MglData operator / (in MglDataA* b, in MglDataA* d)
	{
	    MglData a( & b);
	    a /= d;
	    return a;
	}
	MglData operator / (in MglDataA* d, mreal b)
	{
	    MglData a( & d);
	    a /= b;
	    return a;
	}
	bool operator == (in MglData* b, in MglData* d)
	{
	    if (b.nx != d.nx || b.ny != d.ny || b.nz != d.nz)
	        return false;
	    return !memcmp(b.a, d.a, b.nx * b.ny * b.nz * sizeof(mreal));
	}
	bool operator < (in MglDataA* b, in MglDataA* d)
	{
	    return b.maximal() < d.maximal();
	}
	bool operator > (in MglDataA* b, in MglDataA* d)
	{
	    return b.minimal() > d.minimal();
	}

	*/

	mreal mglLinear(const mreal * a, long nx, long ny, long nz, mreal x, mreal y, mreal z);
	mreal mglSpline3(const mreal * a, long nx, long ny, long nz, mreal x, mreal y, mreal z, mreal * dx = 0, mreal * dy = 0, mreal * dz = 0);
	mreal mglSpline3s(const mreal * a, long nx, long ny, long nz, mreal x, mreal y, mreal z);
}

/// Integral data transformation (like Fourier 'f' or 'i', Hankel 'h' or None 'n') for amplitude and phase
MglData mglTransformA(in MglDataA* am, in MglDataA* ph, string tr)
{
    return MglData(true, mgl_transform_a( & am,  & ph, tr));
}
/// Integral data transformation (like Fourier 'f' or 'i', Hankel 'h' or None 'n') for real and imaginary parts
MglData mglTransform(in MglDataA* re, in MglDataA* im, string tr)
{
    return MglData(true, mgl_transform( & re,  & im, tr));
}

/// Apply Fourier transform for the data and save result into it
void mglFourier(ref MglData re, ref MglData im, string dir)
{
    mgl_data_fourier(re,  im, dir);
}

/// Short time Fourier analysis for real and imaginary parts. Output is amplitude of partial Fourier (result will have size {dn, floor(nx/dn), ny} for dir='x'
MglData mglSTFA(ref MglDataA re, ref MglDataA im, long dn, char dir = 'x')
{
    return MglData(true, mgl_data_stfa(re,im, dn, dir));
}

//-----------------------------------------------------------------------------
/// Saves result of PDE solving (|u|^2) for "Hamiltonian" ham with initial conditions ini
MglData mglPDE(HMGL gr, string ham, ref MglDataA* ini_re,
    ref MglDataA* ini_im, mreal dz = 0.1, mreal k0 = 100, string opt = "")
{
    return MglData(true, mgl_pde_solve(gr, ham,  & ini_re,  &ini_im, dz, k0, opt));
}

/// Saves result of PDE solving for "Hamiltonian" ham with initial conditions ini along a curve ray (must have nx>=7 - x,y,z,px,py,pz,tau or nx=5 - x,y,px,py,tau)
MglData mglQO2d(string ham, in MglDataA* ini_re, in MglDataA* ini_im,
    in MglDataA* ray, mreal r = 1, mreal k0 = 100)
{
    return MglData(true, mgl_qo2d_solve(ham,  & ini_re,  & ini_im,  & ray, r, k0, 0,
        0));
}

MglData mglQO2d(string ham, in MglDataA* ini_re, in MglDataA* ini_im,
    in MglDataA* ray, ref MglData xx, ref MglData yy, mreal r = 1, mreal k0 = 100)
{
    return MglData(true, mgl_qo2d_solve(ham,  & ini_re,  & ini_im,  & ray, r, k0,  & xx,
         & yy));
}
/// Saves result of PDE solving for "Hamiltonian" ham with initial conditions ini along a curve ray (must have nx>=7 - x,y,z,px,py,pz,tau or nx=5 - x,y,px,py,tau)

MglData mglQO3d(string ham, in MglDataA* ini_re, in MglDataA* ini_im,
    in MglDataA* ray, mreal r = 1, mreal k0 = 100)
{
    return MglData(true, mgl_qo3d_solve(ham,  & ini_re,  & ini_im,  & ray, r, k0, 0,
        0, 0));
}

MglData mglQO3d(string ham, ref  MglDataA ini_re, ref MglDataA ini_im,
    ref MglDataA ray, ref MglData xx, ref MglData yy, ref MglData zz, mreal r = 1, mreal k0 = 100)
{
    return MglData(true, mgl_qo3d_solve(ham,  & ini_re,  & ini_im,  & ray, r,
        k0,  & xx,  & yy,  & zz));
}
/// Finds ray with starting point r0, p0 (and prepares ray data for mglQO2d)
MglData mglRay(string ham, MglPoint r0, MglPoint p0, mreal dt = 0.1, mreal tmax = 10)
{
    return MglData(true, mgl_ray_trace(ham, r0.x, r0.y, r0.z, p0.x, p0.y, p0.z, dt,
        tmax));
}

/// Saves result of ODE solving (|u|^2) for "Hamiltonian" ham with initial conditions ini
MglData mglODE(string df, string var, in MglDataA* ini, mreal dt = 0.1,
    mreal tmax = 10)
{
    return MglData(true, mgl_ode_solve_str(df, var,  & ini, dt, tmax));
}
/// Calculate Jacobian determinant for D{x(u,v), y(u,v)} = dx/du*dy/dv-dx/dv*dy/du
MglData mglJacobian(in MglDataA* x, in MglDataA* y)
{
    return MglData(true, mgl_jacobian_2d( & x,  & y));
}
/// Calculate Jacobian determinant for D{x(u,v,w), y(u,v,w), z(u,v,w)}
MglData mglJacobian(in MglDataA* x, in MglDataA* y, in MglDataA* z)
{
    return MglData(true, mgl_jacobian_3d( & x,  & y,  & z));
}
/// Do something like Delone triangulation
MglData mglTriangulation(in MglDataA* x, in MglDataA* y, in MglDataA* z)
{
    return MglData(true, mgl_triangulation_3d( & x,  & y,  & z));
}
MglData mglTriangulation(in MglDataA* x, in MglDataA* y)
{
    return MglData(true, mgl_triangulation_2d( & x,  & y));
}
//-----------------------------------------------------------------------------
/// Get sub-array of the data with given fixed indexes
MglData mglSubData(in MglDataA* dat, long xx, long yy =  - 1, long zz =  - 1)
{
    return MglData(true, mgl_data_subdata( & dat, xx, yy, zz));
}
MglData mglSubData(in MglDataA* dat, in MglDataA* xx, in MglDataA* yy,
    in MglDataA* zz)
{
    return MglData(true, mgl_data_subdata_ext( & dat,  & xx,  & yy,  & zz));
}
MglData mglSubData(in MglDataA* dat, in MglDataA* xx, in MglDataA* yy)
{
    return MglData(true, mgl_data_subdata_ext( & dat,  & xx,  & yy, 0));
}
MglData mglSubData(in MglDataA* dat, in MglDataA* xx)
{
    return MglData(true, mgl_data_subdata_ext( & dat,  & xx, 0, 0));
}
//-----------------------------------------------------------------------------
/// Prepare coefficients for global spline interpolation
MglData mglGSplineInit(in MglDataA* xdat, in MglDataA* ydat)
{
    return MglData(true, mgl_gspline_init(*xdat,  & ydat));
}
/// Evaluate global spline (and its derivatives d1, d2 if not NULL) using prepared coefficients \a coef
mreal mglGSpline(in MglDataA* coef, mreal dx, mreal * d1 = 0, mreal * d2 = 0)
{
    return mgl_gspline( & coef, dx, d1, d2);
}
//-----------------------------------------------------------------------------
/// Wrapper class for expression evaluating
class MglExpr
{
    HMEX ex;

	// copying is not allowed

    this(string expr)
    {
        ex = mgl_create_expr(expr.toStringz);
    }

    static if(HaveRval)
    {
    	this(MglExpr** d)
    	{
    		ex=d.ex;
	        d.ex = 0;
	    }
    }

    ~this()
    {
        mgl_delete_expr(ex);
    }

    /// Return value of expression for given x,y,z variables
    double eval(double x, double y = 0, double z = 0)
    {
        return mgl_expr_eval(ex, x, y, z);
    }

    /// Return value of expression differentiation over variable dir for given x,y,z variables
    double diff(char dir, double x, double y = 0, double z = 0)
    {
        return mgl_expr_diff(ex, dir, x, y, z);
    }

    static if(!SWIG)
    {
    	// Return value of expression for given variables
	    double Eval(mreal var[26])
	    {
	        return mgl_expr_eval_v(ex, var);
	    }

	    /// Return value of expression differentiation over variable dir for given variables
	    double Diff(char dir, mreal var[26])
	    {
	        return mgl_expr_diff_v(ex, dir, var);
	    }
	}
}

// Class which presents variable as data array
class MglDataV : MglDataA
{
    long nx; ///< number of points in 1st dimensions ('x' dimension)
    long ny; ///< number of points in 2nd dimensions ('y' dimension)
    long nz; ///< number of points in 3d dimensions ('z' dimension)
    mreal di, dj, dk, a0;

    this(long xx = 1, long yy = 1, long zz = 1, mreal x1 = 0, mreal x2 = mglNaN, char dir = 'x')
    {
    	this.nx=xx;
    	this.ny=ny;
    	this.nz=nz;
        fill(x1, x2, dir);
    }

    this(MglDataV d)
    {
    	this.nx=d.nx;
    	this.ny=d.ny;
    	this.nz=d.nz;
    	this.di=d.di;
    	this.dj=d.dj;
    	this.dk=d.dk;
    	this.a0=d.ao;
    }

    static if(HaveRval)
    {
    	this(MglDataV d)
    	{
    		this.nx=d.nx;
	    	this.ny=d.ny;
	    	this.nz=d.nz;
	    	this.di=d.di;
	    	this.dj=d.dj;
	    	this.dk=d.dk;
	    	this.a0=d.ao;
	        s = d.s;
    	    temp = d.temp;
        	func = d.func;
        	o = d.o;
        	d.func = 0;
    	}
    }

    /// Get sizes
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

    /// create or recreate the array with specified size and fill it by zero
    void create(long mx, long my = 1, long mz = 1)
    {
        di = mx > 1 ? di * (nx - 1) / (mx - 1) : 0;
        dj = my > 1 ? dj * (ny - 1) / (my - 1) : 0;
        dk = mz > 1 ? dk * (nz - 1) / (mz - 1) : 0;
        nx = mx;
        ny = my;
        nz = mz;
    }

    /// For going throw all elements
    void all()
    {
        di = dj = dk = 1;
        a0 = 0;
    }

    /// Equidistantly fill the data to range [x1,x2] in direction dir
    void fill(mreal x1, mreal x2 = mglNaN, char dir = 'x')
    {
        di = dj = dk = 0;
        a0 = x1;
        if (mgl_isnum(x2))
        {
            if (dir == 'x' && nx > 1)
                di = (x2 - x1) / (nx - 1);
            if (dir == 'y' && ny > 1)
                dj = (x2 - x1) / (ny - 1);
            if (dir == 'z' && nz > 1)
                dk = (x2 - x1) / (nz - 1);
        }
    }

    mreal maximal() const
    {
        return a0 + mgl_max(mgl_max(di * (nx - 1), dj * (ny - 1)), mgl_max(dk * (nz - 1),
            0));
    }

    mreal minimal() const
    {
        return a0 + mgl_min(mgl_min(di * (nx - 1), dj * (ny - 1)), mgl_min(dk * (nz - 1),
            0));
    }

    /*
    /// Copy data from other MglDataV variable
    const MglDataV & operator = (const MglDataV & d)
    {
        nx = d.nx;
        ny = d.ny;
        nz = d.nz;
        a0 = d.a0;
        di = d.di;
        dj = d.dj;
        dk = d.dk;
        return d;
    }
    mreal operator = (mreal val)
    {
        di = dj = dk = 0;
        a0 = val;
        return val;
    }
    */

    /// Get the value in given cell of the data without border checking
    mreal value(mreal x, mreal y, mreal z, mreal * dx = 0, mreal * dy = 0, mreal * dz = 0) const
    {
        if (dx)
             * dx = di;
        if (dy)
             * dy = dj;
        if (dz)
             * dz = dk;
        return a0 + di * x + dj * y + dk * z;
    }
    mreal v(long i, long j = 0, long k = 0) const
    {
        return a0 + di * i + dj * j + dk * k;
    }

    mreal vthr(long ii) const
    {
        long i = ii % nx, j = (ii / nx) % ny, k = ii / (nx * ny);
        return a0 + di * i + dj * j + dk * k;
    }

    // add for speeding up !!!
    mreal dvx(long, long = 0, long = 0) const
    {
        return di;
    }

    mreal dvy(long, long = 0, long = 0) const
    {
        return dj;
    }

    mreal dvz(long, long = 0, long = 0) const
    {
        return dk;
    }
};
//-----------------------------------------------------------------------------
/// Class which present FFT frequency as data array
class MglDataW : MglDataA
{
    long nx; ///< number of points in 1st dimensions ('x' dimension)
    long ny; ///< number of points in 2nd dimensions ('y' dimension)
    long nz; ///< number of points in 3d dimensions ('z' dimension)
    mreal di, dj, dk;

    this(long xx = 1, long yy = 1, long zz = 1, mreal dp = 0, char dir = 'x')
    {
    	this.nx=xx;
    	this.ny=yy;
    	this.nz=zz;
        freq(dp, dir);
    }

    this(const MglDataW d)
    {
		this.nx=d.nx;
		this.ny=d.ny;
		this.nz=d.nz;
		this.di=d.di;
		this.dj=d.dj;
		this.dk=d.dk;
	}

    static if (HaveRval)
    {
    	this(MglDataW* d)
    	{
			this.nx=d.nx;
			this.ny=d.ny;
			this.nz=d.nz;
			this.di=d.di;
			this.dj=d.dj;
			this.dk=d.dk;
	        s = d.s;
	        temp = d.temp;
	        func = d.func;
	        o = d.o;
	        d.func = 0;
	    }
    }

    /// Get sizes
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

    /// create or recreate the array with specified size and fill it by zero
    void create(long mx, long my = 1, long mz = 1)
    {
        nx = mx;
        ny = my;
        nz = mz;
    }

    /// For going throw all elements
    void all()
    {
        di = dj = dk = 1;
    }

    /// Equidistantly fill the data to range [x1,x2] in direction dir
    void Freq(mreal dp, char dir = 'x')
    {
        di = dj = dk = 0;
        if (dir == 'x')
            di = dp;
        if (dir == 'y')
            dj = dp;
        if (dir == 'z')
            dk = dp;
    }

    mreal maximal() const
    {
        return mgl_max(mgl_max(di * (nx - 1), dj * (ny - 1)), mgl_max(dk * (nz - 1),
            0));
    }

    mreal minimal() const
    {
        return mgl_min(mgl_min(di * (nx - 1), dj * (ny - 1)), mgl_min(dk * (nz - 1),
            0));
    }
/*
    /// Copy data from other MglDataV variable
    const MglDataW & operator = (const MglDataW & d)
    {
        nx = d.nx;
        ny = d.ny;
        nz = d.nz;
        di = d.di;
        dj = d.dj;
        dk = d.dk;
        return d;
    }
*/
    /// Get the value in given cell of the data without border checking
    mreal value(mreal x, mreal y, mreal z, mreal* dx = 0, mreal* dy = 0, mreal* dz = 0) const
    {
        if (dx)
            *dx = di;
        if (dy)
            *dy = dj;
        if (dz)
            *dz = dk;
        return di * (x < nx / 2 ? x : nx - x) + dj * (y < ny / 2 ? y : ny - y) + dk * (
            z < nz / 2 ? z : nz - z);
    }

    mreal v(long i, long j = 0, long k = 0) const
    {
        return di * (i < nx / 2 ? i : nx - i) + dj * (j < ny / 2 ? j : ny - j) + dk * (
            k < nz / 2 ? k : nz - k);
    }

    mreal vthr(long ii) const
    {
        long i = ii % nx, j = (ii / nx) % ny, k = ii / (nx * ny);
        return di * (i < nx / 2 ? i : nx - i) + dj * (j < ny / 2 ? j : ny - j) + dk * (
            k < nz / 2 ? k : nz - k);
    }

    // add for speeding up !!!
    mreal dvx(long, long = 0, long = 0) const
    {
        return di;
    }

    mreal dvy(long, long = 0, long = 0) const
    {
        return dj;
    }

    mreal dvz(long, long = 0, long = 0) const
    {
        return dk;
    }
}

// Class which presents variable as data array
class MglDataF : MglDataA
{
    long nx; ///< number of points in 1st dimensions ('x' dimension)
    long ny; ///< number of points in 2nd dimensions ('y' dimension)
    long nz; ///< number of points in 3d dimensions ('z' dimension)
	string str; ///< function as string
    MglPoint v1, v2; ///< ranges for coordinates
    HMEX ex; ///< parsed variant
    mreal dx, dy, dz;
    void setD()
    {
        dx = nx > 1 ? (v2.x - v1.x) / (nx - 1) : 0;
        dy = ny > 1 ? (v2.y - v1.y) / (ny - 1) : 0;
        dz = nz > 1 ? (v2.z - v1.z) / (nz - 1) : 0;
    }

    mreal function(mreal i, mreal j, mreal k, void * par) func;
    void* par;

    this(long xx = 1, long yy = 1, long zz = 1)
    {
    	this.nx=xx;
    	this.ny=yy;
    	this.nz=zz;
    	this.dfunc=0;
    	this.par=0;
        ex = 0;
        v2 = MglPoint(1, 1, 1);
        setD();
    }

    this(MglDataF d)
    {
    	this.nx=d.nx;
    	this.ny=d.ny;
    	this.nz=d.nz;
    	this.str=d.str;
        this.v1=d.v1;
        this.v2=d.v2;
        this.dx=d.dx;
        this.dy=d.dy;
        this.dz=d.dz;
        this.dfunc=d.dfunc;
        this.par=d.par;
        ex = mgl_create_expr(str.c_str());
    }

    static if(HaveRval)
    {
    	this(MglDataF d)
    	{
	    	this.nx=d.nx;
	    	this.ny=d.ny;
	    	this.nz=d.nz;
	    	this.str=d.str;
	        this.v1=d.v1;
	        this.v2=d.v2;
	        this.dx=d.dx;
	        this.dy=d.dy;
	        this.dz=d.dz;
	        this.dfunc=d.dfunc;
	        this.par=d.par;
	        s = d.s;
	        temp = d.temp;
	        func = d.func;
	        o = d.o;
	        d.ex = 0;
	        d.func = 0;
    	}
    }

    ~this()
    {
        mgl_delete_expr(ex);
    }

    /// Get sizes
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

    /// create or recreate the array with specified size and fill it by zero
    void create(long mx, long my = 1, long mz = 1)
    {
        nx = mx;
        ny = my;
        nz = mz;
        setD();
    }

    void setRanges(MglPoint p1, MglPoint p2)
    {
        v1 = p1;
        v2 = p2;
        setD();
    }

    /// set formula to be used as dfunction
    void setFormula(string eq)
    {
        mgl_delete_expr(ex);
        dfunc = 0;
        par = 0;
        if (eq && *eq)
        {
            ex = mgl_create_expr(eq);
            str = eq;
        }
        else
        {
            ex = 0;
            str = "";
        }
    }

    /// set dfunction and coordinates range [r1,r2]
    void setFunc(mreal function(mreal, mreal, mreal, void * ) f, void * p = NULL)
    {
        mgl_delete_expr(ex);
        ex = 0;
        dfunc = f;
        par = p;
    }

    mreal value(mreal i, mreal j = 0, mreal k = 0, mreal* di = 0, mreal* dj = 0, mreal* dk = 0) const
    {
        mreal res = 0, x = v1.x + dx * i, y = v1.y + dy * j, z = v1.z + dz * k;
        if (di)
            *di = 0;
        if (dj)
            *dj = 0;
        if (dk)
            *dk = 0;
        if (dfunc)
        {
            res = dfunc(x, y, z, par);
            if (di)
                *di = dfunc(x + dx, y, z, par) - res;
            if (dj)
                *dj = dfunc(x, y + dy, z, par) - res;
            if (dk)
                *dk = dfunc(x, y, z + dz, par) - res;
        }
        else if (ex)
        {
            if (di)
                *di = mgl_expr_diff(ex, 'x', x, y, z) * dx;
            if (dj)
                *dj = mgl_expr_diff(ex, 'y', x, y, z) * dy;
            if (dk)
                *dk = mgl_expr_diff(ex, 'z', x, y, z) * dz;
            res = mgl_expr_eval(ex, x, y, z);
        }
        return res;
    }
/*
    /// Copy data from other MglDataV variable
    const MglDataF & operator = (const MglDataF & d)
    {
        nx = d.nx;
        ny = d.ny;
        nz = d.nz;
        v1 = d.v1;
        v2 = d.v2;
        setD();
        str = d.str;
        ex = mgl_create_expr(str.c_str());
        dfunc = d.dfunc;
        par = d.par;
        return d;
    }
  */
    /// Get the value in given cell of the data without border checking
    mreal v(long i, long j = 0, long k = 0) const
    {
        mreal res = 0, x = v1.x + dx * i, y = v1.y + dy * j, z = v1.z + dz * k;
        if (dfunc)
            res = dfunc(x, y, z, par);
        else if (ex)
            res = mgl_expr_eval(ex, x, y, z);
        return res;
    }

    mreal vthr(long i) const
    {
        mreal res = 0, x = v1.x + dx * (i % nx), y = v1.y + dy * ((i / nx) % ny),
            z = v1.z + dz * (i / (nx * ny));
        if (dfunc)
            res = dfunc(x, y, z, par);
        else if (ex)
            res = mgl_expr_eval(ex, x, y, z);
        return res;
    }

    // add for speeding up !!!
    mreal dvx(long i, long j = 0, long k = 0) const
    {
        mreal res = 0, x = v1.x + dx * i, y = v1.y + dy * j, z = v1.z + dz * k;
        if (dfunc)
            res = dfunc(x + dx, y, z, par) - dfunc(x, y, z, par);
        else if (ex)
            res = mgl_expr_eval(ex, x + dx, y, z) - mgl_expr_eval(ex, x, y, z);
        return res;
    }

    mreal dvy(long i, long j = 0, long k = 0) const
    {
        mreal res = 0, x = v1.x + dx * i, y = v1.y + dy * j, z = v1.z + dz * k;
        if (dfunc)
            res = dfunc(x, y + dy, z, par) - dfunc(x, y, z, par);
        else if (ex)
            res = mgl_expr_eval(ex, x, y + dy, z) - mgl_expr_eval(ex, x, y, z);
        return res;
    }

    mreal dvz(long i, long j = 0, long k = 0) const
    {
        mreal res = 0, x = v1.x + dx * i, y = v1.y + dy * j, z = v1.z + dz * k;
        if (dfunc)
            res = dfunc(x, y, z + dz, par) - dfunc(x, y, z, par);
        else if (ex)
            res = mgl_expr_eval(ex, x, y, z + dz) - mgl_expr_eval(ex, x, y, z);
        return res;
    }
}

// Class which present variable as data array
class MglDataT : MglDataA
{
    MglDataA* dat;
    long ind;

    this(const MglDataT d)
    {
    	this.dat=d.dat;
    	this.ind=d.ind;
        s = d.s;
    }

    this(in MglDataA* d, long col = 0)
    {
    	this.dat=d;
    	this.ind=col;
    }

    static if(HaveRval)
    {
    	this(MglDataT* d)
    	{
    		this.dat=d.dat;
    		this.ind=d.ind;
	        s = d.s;
	        temp = d.temp;
	        func = d.func;
	        o = d.o;
	        d.func = 0;
	    }
    }

    ~this()
    {
    }

    /// Get sizes
    long getNx() const
    {
        return dat.getNy();
    }

    long getNy() const
    {
        return dat.getNz();
    }

    long getNz() const
    {
        return 1;
    }

    mreal maximal() const
    {
        return mglSubData(dat, ind).maximal();
    }

    mreal minimal() const
    {
        return mglSubData(dat, ind).minimal();
    }

    void setInd(long i, const wchar_t* name)
    {
        ind = i;
        s = name;
    }

    void setInd(long i, wchar_t name)
    {
        ind = i;
        s = name;
    }

    /// Get the value in given cell of the data without border checking
    mreal v(long i, long j = 0, long = 0) const
    {
        return dat.v(ind, i, j);
    }

    mreal vthr(long i) const
    {
        return dat.vthr(ind + dat.getNx() * i);
    }

    // add for speeding up !!!
    mreal dvx(long i, long j = 0, long = 0) const
    {
        return dat.dvy(ind, i, j);
    }

    mreal dvy(long i, long j = 0, long = 0) const
    {
        return dat.dvz(ind, i, j);
    }

    mreal dvz(long, long = 0, long = 0) const
    {
        return 0;
    }
}

class MglDataR : MglDataA
{
    MglDataA* dat;
    long ind;

    this(const MglDataR d)
    {
    	this.dat=d.dat;
    	this.ind=d.ind;
    	s=d.s;
    }

    this(in MglDataA d, long row = 0)
    {
    	this.dat=d;
    	this.ind=row;
    }

    static if(HaveRval)
    {
    	this(MglDataR* d)
    	{
    		this.dat=d.dat;
    		this.ind=d.ind;
	        s = d.s;
	        temp = d.temp;
	        func = d.func;
	        o = d.o;
	        d.func = 0;
	    }
	}
	~this()
	{

	}

    /// Get sizes
    long getNx() const
    {
        return dat.getNx();
    }

    long getNy() const
    {
        return 1;
    }

    long getNz() const
    {
        return 1;
    }

    mreal maximal() const
    {
        return mglSubData(dat, -1, ind).maximal();
    }

    mreal minimal() const
    {
        return mglSubData(dat, -1, ind).minimal();
    }

    void setInd(long i, const wchar_t* name)
    {
        ind = i;
        s = name;
    }

    void setInd(long i, wchar_t name)
    {
        ind = i;
        s = name;
    }

    /// Get the value in given cell of the data without border checking
    mreal v(long i, long j= 0, long k= 0) const
    {
        return dat.v(i, ind, 0);
    }

    mreal vthr(long i) const
    {
        return dat.vthr(i + dat.getNx() * ind);
    }

    // add for speeding up !!!
    mreal dvx(long i, long j = 0, long k= 0) const
    {
        return dat.dvx(i, ind, 0);
    }

    mreal dvy(long i, long j = 0, long k= 0) const
    {
        return 0;
    }

    mreal dvz(long i, long j= 0, long k = 0) const
    {
        return 0;
    }
}


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
    bool useLink; ///< use external data (i.e. don't free it)

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
    		this.useLink=d.useLink;
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
            useLink = d.useLink;
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
        set(d, size);
    }
    this(int rows, int cols, const dual * d)
    {
        a = 0;
        set(d, cols, rows);
    }
    this(int size, const double * d)
    {
        a = 0;
        set(d, size);
    }
    this(int rows, int cols, const double * d)
    {
        a = 0;
        set(d, cols, rows);
    }
    this(int size, const float * d)
    {
        a = 0;
        set(d, size);
    }
    this(int rows, int cols, const float * d)
    {
        a = 0;
        set(d, cols, rows);
    }
    this(in dual * d, int size)
    {
        a = 0;
        set(d, size);
    }
    this(in dual * d, int rows, int cols)
    {
        a = 0;
        set(d, cols, rows);
    }
    this(in double * d, int size)
    {
        a = 0;
        set(d, size);
    }
    this(in double * d, int rows, int cols)
    {
        a = 0;
        set(d, cols, rows);
    }
    this(in float * d, int size)
    {
        a = 0;
        set(d, size);
    }
    this(in float * d, int rows, int cols)
    {
        a = 0;
        set(d, cols, rows);
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
        //if (!useLink && a)
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
    void link(dual* A, long NX, long NY = 1, long NZ = 1)
    {
        mgl_datac_link(this, A, NX, NY, NZ);
    }

    void link(MglDataC* d)
    {
        Link(d.a, d.nx, d.ny, d.nz);
    }
    /// Allocate memory and copy the data from the gsl_vector
    void set(gsl_vector* m)
    {
        mgl_datac_set_vector(this, m);
    }

    /// Allocate memory and copy the data from the gsl_matrix
    void set(gsl_matrix* m)
    {
        mgl_datac_set_matrix(this, m);
    }

    /// Allocate memory and copy the data from the (float *) array
    void set(const float* A, long NX, long NY = 1, long NZ = 1)
    {
        mgl_datac_set_float(this, A, NX, NY, NZ);
    }

    /// Allocate memory and copy the data from the (double *) array
    void set(const double* A, long NX, long NY = 1, long NZ = 1)
    {
        mgl_datac_set_double(this, A, NX, NY, NZ);
    }

    /// Allocate memory and copy the data from the (complex *) array
    void set(const dual* A, long NX, long NY = 1, long NZ = 1)
    {
        mgl_datac_set_complex(this, A, NX, NY, NZ);
    }

    /// Allocate memory and scanf the data from the string
    void set(string str, long NX, long NY = 1, long NZ = 1)
    {
        mgl_datac_set_values(this, str.toStringz, NX, NY, NZ);
    }

    /// Import data from abstract type
    void set(HCDT dat)
    {
        mgl_datac_set(this, dat);
    }

    void set(in MglDataA* dat)
    {
        mgl_datac_set(this,  & dat);
    }
    void set(in MglDataA* re, in MglDataA* im)
    {
        mgl_datac_set_ri(this,  & re,  & im);
    }
    void set(HCDT re, HCDT im)
    {
        mgl_datac_set_ri(this, re, im);
    }

    void setAmpl(in MglDataA* ampl, in MglDataA* phase)
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

    /// set names for columns (slices)
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
    dual linear(MglPoint* dif, mreal x, mreal y = 0, mreal z = 0) const
    {
        dual val, dx, dy, dz;
        val = mgl_datac_linear_ext(this, x, y, z,  & dx,  & dy,  & dz);
        dif = MglPoint(dx.getReal, dy.getReal, dz.getReal);
        return val;
    }
    /// Interpolate by line the data and return its derivatives at given point x,\a y,\a z which normalized in range [0, 1]
    dual linear1(MglPoint* dif, mreal x, mreal y = 0, mreal z = 0) const
    {
        dual val, dx, dy, dz;
        val = mgl_datac_linear_ext(this, x, y, z,  & dx,  & dy,  & dz);
        dif = MglPoint(dx.getReal, dy.getReal, dz.getReal);
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
	    /// set the value in given cell of the data
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
	    /// set the value in given cell of the data
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
