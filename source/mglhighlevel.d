/***************************************************************************
 * mgl.h is part of Math Graphic Library
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
//import mathgl.data;
//import mathgl.datac;

enum OpenGL = 0;
/// Wrapper class for all graphics
class MglGraph
{
    private HMGL gr;
    this(in mglGraph t) // copying is not allowed
    {
    }

    this(HMGL graph)
    {
        gr = graph;
        mgl_use_graph(gr, 1);
    }

    ~this()
    {
        if (mgl_use_graph(gr, -1) < 1)
            mgl_delete_graph(gr);
    }

    this(int kind = 0, int width = 600, int height = 400)
    {
        if (kind ==  - 1)
            gr = null;

        version (OpenGL)
        {
            if (kind ==  - 1)
                gr = null;
            else if (kind == 1)
                gr = mgl_create_graph_gl();
        }
        else
        {
            if (kind ==  - 1)
                gr = null;
            else if (kind == 1)
            {
                gr = mgl_create_graph(width, height);
                SetGlobalWarn("OpenGL support was disabled. Please, enable it and rebuild MathGL.");
            }
    	    else
        	    gr = mgl_create_graph(width, height);
        }
    }

    /// Get pointer to internal HMGL object
    HMGL getHGML()
    {
        return gr;
    }

    /// Set default parameters for plotting
    void DefaultPlotParam()
    {
        mgl_set_def_param(gr);
    }

    /// Set name of plot for saving filename
    void SetPlotId(string id)
    {
        mgl_set_plotid(gr, id);
    }

    /// Get name of plot for saving filename
    const(char*) GetPlotId()
    {
        return mgl_get_plotid(gr);
    }

    /// Ask to stop drawing
    void Stop(bool stop = true)
    {
        mgl_ask_stop(gr, stop);
    }

    /// Check if plot termination is asked
    bool NeedStop()
    {
        return mgl_need_stop(gr);
    }

    /// Set callback function for event processing
    void SetEventFunc(void function(void*), void * par = null)
    {
        mgl_set_event_func(gr, func, par);
    }

    /// Set the transparency on/off.
    void Alpha(bool enable)
    {
        mgl_set_alpha(gr, enable);
    }

    /// Set default value of alpha-channel
    void SetAlphaDef(double alpha)
    {
        mgl_set_alpha_default(gr, alpha);
    }

    /// Set the transparency type (0 - usual, 1 - glass, 2 - lamp)
    void SetTranspType(int type)
    {
        mgl_set_transp_type(gr, type);
    }

    /// Set the using of light on/off.
    void Light(bool enable)
    {
        mgl_set_light(gr, enable);
    }

    /// Switch on/off the specified light source.
    void Light(int n, bool enable)
    {
        mgl_set_light_n(gr, n, enable);
    }

    /// Use diffusive light (only for local light sources) -- OBSOLETE
    void SetDifLight(bool dif)
    {
        mgl_set_light_dif(gr, dif);
    }

    /// Add a light source.
    void AddLight(int n, mglPoint p, char col = 'w', double bright = 0.5, double ap = 0)
    {
        mgl_add_light_ext(gr, n, p.x, p.y, p.z, col, bright, ap);
    }

    void AddLight(int n, mglPoint r, mglPoint p, char col = 'w', double bright = 0.5,
        double ap = 0)
    {
        mgl_add_light_loc(gr, n, r.x, r.y, r.z, p.x, p.y, p.z, col, bright, ap);
    }

    /// Set ambient light brightness
    void SetAmbient(double i)
    {
        mgl_set_ambbr(gr, i);
    }

    /// Set diffusive light brightness
    void SetDiffuse(double i)
    {
        mgl_set_difbr(gr, i);
    }

    /// Set the fog distance or switch it off (if d=0).
    void Fog(double d, double dz = 0.25)
    {
        mgl_set_fog(gr, d, dz);
    }

    /// Set relative width of rectangles in Bars, Barh, BoxPlot
    void SetBarWidth(double width)
    {
        mgl_set_bar_width(gr, width);
    }

    /// Set default size of marks (locally you can use "size" option)
    void SetMarkSize(double size)
    {
        mgl_set_mark_size(gr, size);
    }

    /// Set default size of arrows (locally you can use "size" option)
    void SetArrowSize(double size)
    {
        mgl_set_arrow_size(gr, size);
    }

    /// Set number of mesh lines (use 0 to draw all of them)
    void SetMeshNum(int num)
    {
        mgl_set_meshnum(gr, num);
    }

    /// Set number of visible faces (use 0 to draw all of them)
    void SetFaceNum(int num)
    {
        mgl_set_facenum(gr, num);
    }

    /// Set cutting for points outside of bounding box
    void SetCut(bool cut)
    {
        mgl_set_cut(gr, cut);
    }

    /// Set additional cutting box
    void SetCutBox(mglPoint p1, mglPoint p2)
    {
        mgl_set_cut_box(gr, p1.x, p1.y, p1.z, p2.x, p2.y, p2.z);
    }

    /// Set the cutting off condition (formula)
    void CutOff(string EqC)
    {
        mgl_set_cutoff(gr, EqC);
    }

    /// Set default font size
    void SetFontSize(double size)
    {
        mgl_set_font_size(gr, size);
    }

    /// Set default font style and color
    void SetFontDef(string fnt)
    {
        mgl_set_font_def(gr, fnt);
    }

    /// Set FontSize by size in pt and picture DPI (default is 16 pt for dpi=72)
     void SetFontSizePT(double pt, int dpi = 72)
    {
        SetFontSize(pt * 27.0 / dpi);
    }

    /// Set FontSize by size in centimeters and picture DPI (default is 0.56 cm = 16 pt)
    void SetFontSizeCM(double cm, int dpi = 72)
    {
        SetFontSizePT(cm * 28.45, dpi);
    }

    /// Set FontSize by size in inch and picture DPI (default is 0.22 in = 16 pt)
    void SetFontSizeIN(double inp, int dpi = 72)
    {
        SetFontSizePT(inp  * 72.27, dpi);
    }
    /// Load font from file
    void LoadFont(string name, string path = null)
    {
        mgl_load_font(gr, name, path);
    }

    /// Copy font from another mglGraph instance
    void CopyFont(const(mglGraph*) GR)
    {
        mgl_copy_font(gr, GR.gr);
    }

    /// Restore font (load default font for new HMGL objects)
    void RestoreFont()
    {
        mgl_restore_font(gr);
    }

    /// Set to use or not text rotation
    void SetRotatedText(bool rotated)
    {
        mgl_set_rotated_text(gr, rotated);
    }

    /// Set default font for all new HMGL and mglGraph objects
    static void SetDefFont(string name, string path = null)
    {
        mgl_def_font(name, path);
    }

    /// Set default palette
    void SetPalette(string colors)
    {
        mgl_set_palette(gr, colors);
    }

    /// Set default color scheme
    void SetDefScheme(string sch)
    {
        mgl_set_def_sch(gr, sch);
    }

    /// Sets RGB values for color with given id
    static void SetColor(char id, double r, double g, double b)
    {
        mgl_set_color(id, r, g, b);
    }

    /// Set mask for face coloring as array of type 'ubyte[8]'
    static void SetMask(char id, string mask)
    {
        mgl_set_mask(id, mask);
    }

    /// Set mask for face coloring as uint64_t number
    static void SetMask(char id, uint64_t mask)
    {
        mgl_set_mask_val(id, mask);
    }

    /// Set default mask rotation angle
    void SetMaskAngle(int angle)
    {
        mgl_set_mask_angle(gr, angle);
    }

    /// Get last warning code
    int GetWarn()
    {
        return mgl_get_warn(gr);
    }

    /// Set warning code ant fill message
    void SetWarn(int code, string info)
    {
        mgl_set_warn(gr, code, info);
    }

    /// Get text of warning message(s)
    const(char*) Message()
    {
        return mgl_get_mess(gr);
    }

    /// Set global warning message
    static void SetGlobalWarn(string text)
    {
        mgl_set_global_warn(text);
    }

    /// Get text of global warning message(s)
    static const(char*) GlobalWarn()
    {
        return mgl_get_global_warn();
    }

    /// Suppress printing warnings to stderr
    static void SuppressWarn(bool on)
    {
        mgl_suppress_warn(on);
    }

    /// Check if MathGL version is valid (return false) or not (return true)
    static bool CheckVersion(string ver)
    {
        return mgl_check_version(ver);
    }

    /// Set axis range scaling -- simplified way to shift/zoom axis range -- need to replot whole image!
    void ZoomAxis(mglPoint p1 = mglPoint(0, 0, 0, 0), mglPoint p2 = mglPoint(1, 1,
        1, 1))
    {
        mgl_zoom_axis(gr, p1.x, p1.y, p1.z, p1.c, p2.x, p2.y, p2.z, p2.c);
    }

    /// Add [v1, v2] to the current range in direction dir
    void AddRange(char dir, double v1, double v2)
    {
        mgl_add_range_val(gr, dir, v1, v2);
    }

    /// Set range in direction dir as [v1, v2]
    void SetRange(char dir, double v1, double v2)
    {
        mgl_set_range_val(gr, dir, v1, v2);
    }

    /// Set range in direction dir as minimal and maximal values of data a
    void SetRange(char dir, const(mglDataA*) dat, bool add = false)
    {
        mgl_set_range_dat(gr, dir, dat, add);
    }

    /// Set values of axis range as minimal and maximal values of datas
    void SetRanges(const(mglDataA*) xx, const(mglDataA*) yy,
        const(mglDataA*) zz, const(mglDataA*) cc)
    {
        mgl_set_range_dat(gr, 'x', xx, 0);
        mgl_set_range_dat(gr, 'y', yy, 0);
        mgl_set_range_dat(gr, 'z', zz, 0);
        mgl_set_range_dat(gr, 'c', cc, 0);
    }

    /// Set values of axis range as minimal and maximal values of datas
    void SetRanges(const(mglDataA*) xx, const(mglDataA*) yy, const(mglDataA*) zz)
    {
        mgl_set_range_dat(gr, 'x', xx, 0);
        mgl_set_range_dat(gr, 'y', yy, 0);
        mgl_set_range_dat(gr, 'z', zz, 0);
        mgl_set_range_dat(gr, 'c', zz, 0);
    }

    /// Set values of axis range as minimal and maximal values of datas
    void SetRanges(const(mglDataA*) xx, const(mglDataA*) yy)
    {
        mgl_set_range_dat(gr, 'x', xx, 0);
        mgl_set_range_dat(gr, 'y', yy, 0);
    }

    /// Set values of axis ranges
    void SetRanges(double x1, double x2, double y1, double y2, double z1 = 0, double z2 = 0)
    {
        mgl_set_ranges(gr, x1, x2, y1, y2, z1, z2);
    }

    /// Set values of axis ranges
    void SetRanges(mglPoint p1, mglPoint p2)
    {
        mgl_set_ranges(gr, p1.x, p2.x, p1.y, p2.y, p1.z, p2.z);
    }

    /// Set ranges for automatic variables
    void SetAutoRanges(double x1, double x2, double y1 = 0, double y2 = 0,
        double z1 = 0, double z2 = 0, double c1 = 0, double c2 = 0)
    {
        mgl_set_auto_ranges(gr, x1, x2, y1, y2, z1, z2, c1, c2);
    }

    /// Set ranges for automatic variables
    void SetAutoRanges(mglPoint p1, mglPoint p2)
    {
        mgl_set_auto_ranges(gr, p1.x, p2.x, p1.y, p2.y, p1.z, p2.z, p1.c, p2.c);
    }

    /// Set axis origin
    void SetOrigin(mglPoint p)
    {
        mgl_set_origin(gr, p.x, p.y, p.z);
    }

    void SetOrigin(double x0, double y0, double z0 = mglNaN)
    {
        mgl_set_origin(gr, x0, y0, z0);
    }

    /// Set the transformation formulas for coordinate
    void SetFunc(string EqX, string EqY, string EqZ = null, string EqA = null)
    {
        mgl_set_func(gr, EqX, EqY, EqZ, EqA);
    }

    /// Set one of predefined transformation rule
    void SetCoor(int how)
    {
        mgl_set_coor(gr, how);
    }

    /// Set to draw Ternary axis (triangle like axis, grid and so on)
    void Ternary(int val)
    {
        mgl_set_ternary(gr, val);
    }

    /// Set to use or not tick labels rotation
    void SetTickRotate(bool val)
    {
        mgl_set_tick_rotate(gr, val);
    }

    /// Set to use or not tick labels skipping
    void SetTickSkip(bool val)
    {
        mgl_set_tick_skip(gr, val);
    }

    /// Set tick length
    void SetTickLen(double len, double stt = 1)
    {
        mgl_set_tick_len(gr, len, stt);
    }

    /// Set axis and ticks style
    void SetAxisStl(string stl = "k", string tck = 0, string sub = 0)
    {
        mgl_set_axis_stl(gr, toStringz(stl), tck, sub);
    }

    /// Set time templates for ticks
    void SetTicksTime(char dir, double d = 0, string t = "")
    {
        mgl_set_ticks_time(gr, dir, d, t);
    }

    /// Set ticks text (\n separated). Use "" to disable this feature.
    void SetTicksVal(char dir, string lbl, bool add = false)
    {
        mgl_set_ticks_str(gr, dir, lbl, add);
    }

    void SetTicksVal(char dir, const wchar_t* lbl, bool add = false)
    {
        mgl_set_ticks_wcs(gr, dir, lbl, add);
    }

    /// Set ticks position and text (\n separated). Use "" to disable this feature.
    void SetTicksVal(char dir, const(mglDataA*) v, string lbl, bool add = false)
    {
        mgl_set_ticks_val(gr, dir, v, lbl, add);
    }

    void SetTicksVal(char dir, const(mglDataA*) v, const wchar_t* lbl, bool add = false)
    {
        mgl_set_ticks_valw(gr, dir, v, lbl, add);
    }

    /// Add manual tick at given position. Use "" to disable this feature.
    void AddTick(char dir, double val, string lbl)
    {
        mgl_add_tick(gr, dir, val, lbl);
    }

    void AddTick(char dir, double val, const wchar_t* lbl)
    {
        mgl_add_tickw(gr, dir, val, lbl);
    }

    /// Set the ticks parameters and string for its factor
    void SetTicks(char dir, double d = 0, int ns = 0, double org = mglNaN, string factor = "")
    {
        mgl_set_ticks_fact(gr, dir, d, ns, org, factor);
    }

    void SetTicks(char dir, double d, int ns, double org, const wchar_t* factor)
    {
        mgl_set_ticks_factw(gr, dir, d, ns, org, factor);
    }

    /// Auto adjust ticks
    void Adjust(string dir = "xyzc")
    {
        mgl_adjust_ticks(gr, dir);
    }

    /// Set templates for ticks
    void SetTickTempl(char dir, string t)
    {
        mgl_set_tick_templ(gr, dir, t);
    }

    void SetTickTempl(char dir, const wchar_t* t)
    {
        mgl_set_tick_templw(gr, dir, t);
    }

    /// Tune ticks
    void SetTuneTicks(int tune, double fact_pos = 1.15)
    {
        mgl_tune_ticks(gr, tune, fact_pos);
    }

    /// Set additional shift of tick labels
    void SetTickShift(mglPoint p)
    {
        mgl_set_tick_shift(gr, p.x, p.y, p.z, p.c);
    }

    /// Set to use UTC time instead of local time
    void SetTimeUTC(bool enable)
    {
        mgl_set_flag(gr, enable, MGL_USE_GMTIME);
    }

    /// Set to draw tick labels at axis origin
    void SetOriginTick(bool enable = true)
    {
        mgl_set_flag(gr, !enable, MGL_NO_ORIGIN);
    }

    /// Put further plotting in some region of whole frame.
    void SubPlot(int nx, int ny, int m, const(char*) style = "<>_^", double dx = 0,
        double dy = 0)
    {
        mgl_subplot_d(gr, nx, ny, m, style, dx, dy);
    }

    /// Like SubPlot() but "join" several cells
    void MultiPlot(int nx, int ny, int m, int dx, int dy, string style = "<>_^")
    {
        mgl_multiplot(gr, nx, ny, m, dx, dy, style);
    }

    /// Put further plotting in a region of whole frame.
    void InPlot(double x1, double x2, double y1, double y2, bool rel = true)
    {
        if (rel)
            mgl_relplot(gr, x1, x2, y1, y2);
        else
            mgl_inplot(gr, x1, x2, y1, y2);
    }

    /// Put further plotting in column cell of previous subplot
    void ColumnPlot(int num, int ind, double d = 0)
    {
        mgl_columnplot(gr, num, ind, d);
    }

    /// Put further plotting in matrix cell of previous subplot
    void GridPlot(int nx, int ny, int ind, double d = 0)
    {
        mgl_gridplot(gr, nx, ny, ind, d);
    }

    /// Put further plotting in cell of stick rotated on angles tet, phi
    void StickPlot(int num, int i, double tet, double phi)
    {
        mgl_stickplot(gr, num, i, tet, phi);
    }

    /// Set factor of plot size
    void SetPlotFactor(double val)
    {
        mgl_set_plotfactor(gr, val);
    }

    /// Push transformation matrix into stack
    void Push()
    {
        mgl_mat_push(gr);
    }

    /// Pop transformation matrix from stack
    void Pop()
    {
        mgl_mat_pop(gr);
    }

    /// Add title for current subplot/inplot
    void Title(string title, const(char*) stl = "", double size = -2)
    {
        mgl_title(gr, title, stl, size);
    }

    void Title(const wchar_t* title, const(char*) stl = "", double size = -2)
    {
        mgl_titlew(gr, title, stl, size);
    }

    /// Set aspect ratio for further plotting.
    void Aspect(double Ax, double Ay, double Az = 1)
    {
        mgl_aspect(gr, Ax, Ay, Az);
    }

    /// Rotate a further plotting.
    void Rotate(double TetX, double TetZ = 0, double TetY = 0)
    {
        mgl_rotate(gr, TetX, TetZ, TetY);
    }

    /// Rotate a further plotting around vector {x,y,z}.
    void RotateN(double Tet, double x, double y, double z)
    {
        mgl_rotate_vector(gr, Tet, x, y, z);
    }

    /// Set perspective (in range [0,1)) for plot. Set to zero for switching off.
    void Perspective(double val)
    {
        mgl_perspective(gr, val);
    }

    /// Set angle of view independently from Rotate().
    void View(double TetX, double TetZ = 0, double TetY = 0)
    {
        mgl_view(gr, TetX, TetZ, TetY);
    }

    /// Set angle of view independently from Rotate().
    void ViewAsRotate(double TetZ, double TetX, double TetY = 0)
    {
        mgl_view(gr, -TetX, -TetZ, -TetY);
    }

    /// Zoom in/out a part of picture (use Zoom(0, 0, 1, 1) for restore default)
    void Zoom(double x1, double y1, double x2, double y2)
    {
        mgl_zoom(gr, x1, y1, x2, y2);
    }

    /// Set size of frame in pixels. Normally this function is called internally.
    void SetSize(int width, int height)
    {
        mgl_set_size(gr, width, height);
    }

    /// Set plot quality
    void SetQuality(int qual = MGL_DRAW_NORM)
    {
        mgl_set_quality(gr, qual);
    }

    /// Get plot quality
    int GetQuality()
    {
        return mgl_get_quality(gr);
    }

    /// Set drawing region for Quality&4
    void SetDrawReg(long nx = 1, long ny = 1, long m = 0)
    {
        mgl_set_draw_reg(gr, nx, ny, m);
    }

    /// Start group of objects
    void StartGroup(string name)
    {
        mgl_start_group(gr, toStringz(name));
    }

    /// End group of objects
    void EndGroup()
    {
        mgl_end_group(gr);
    }

    /// Highlight objects with given id
    void Highlight(int id)
    {
        mgl_highlight(gr, id);
    }

    /// Show current image
    void ShowImage(string viewer, bool keep = 0)
    {
        mgl_show_image(gr, viewer, keep);
    }

    /// Write the frame in file (depending extension, write current frame if fname is empty)
    void WriteFrame(string fname = 0, const(char*) descr = "")
    {
        mgl_write_frame(gr, fname, descr);
    }

    /// Write the frame in file using JPEG format
    void WriteJPEG(string fname, const(char*) descr = "")
    {
        mgl_write_jpg(gr, fname, descr);
    }

    /// Write the frame in file using PNG format with transparency
    void WritePNG(string fname, const(char*) descr = "", bool alpha = true)
    {
        if (alpha)
            mgl_write_png(gr, fname, descr);
        else
            mgl_write_png_solid(gr, fname, descr);
    }

    /// Write the frame in file using BMP format
    void WriteBMP(string fname, const(char*) descr = "")
    {
        mgl_write_bmp(gr, fname, descr);
    }

    /// Write the frame in file using BMP format
    void WriteTGA(string fname, const(char*) descr = "")
    {
        mgl_write_tga(gr, fname, descr);
    }

    /// Write the frame in file using PostScript format
    void WriteEPS(string fname, const(char*) descr = "")
    {
        mgl_write_eps(gr, fname, descr);
    }

    /// Write the frame in file using LaTeX format
    void WriteTEX(string fname, const(char*) descr = "")
    {
        mgl_write_tex(gr, fname, descr);
    }

    /// Write the frame in file using PostScript format as bitmap
    void WriteBPS(string fname, const(char*) descr = "")
    {
        mgl_write_bps(gr, fname, descr);
    }

    /// Write the frame in file using SVG format
    void WriteSVG(string fname, const(char*) descr = "")
    {
        mgl_write_svg(gr, fname, descr);
    }

    /// Write the frame in file using GIF format (only for current frame!)
    void WriteGIF(string fname, const(char*) descr = "")
    {
        mgl_write_gif(gr, fname, descr);
    }

    /// Write the frame in file using OBJ format
    void WriteOBJ(string fname, const(char*) descr = "", bool use_png = true)
    {
        mgl_write_obj(gr, fname, descr, use_png);
    }

    /// Write the frame in file using OBJ format - Balakin way
    void WriteOBJold(string fname, const(char*) descr = "", bool use_png = true)
    {
        mgl_write_obj_old(gr, fname, descr, use_png);
    }

    /// Write the frame in file using XYZ format
    void WriteXYZ(string fname, const(char*) descr = "")
    {
        mgl_write_xyz(gr, fname, descr);
    }

    /// Write the frame in file using STL format (faces only)
    void WriteSTL(string fname, const(char*) descr = "")
    {
        mgl_write_stl(gr, fname, descr);
    }

    /// Write the frame in file using OFF format
    void WriteOFF(string fname, const(char*) descr = "", bool colored = false)
    {
        mgl_write_off(gr, fname, descr, colored);
    }

    //	/// Write the frame in file using X3D format
    //	void WriteX3D(string fname,const (char*) descr="")
    //	{	mgl_write_x3d(gr, fname, descr);	}
    /// Write the frame in file using PRC format
    void WritePRC(string fname, const(char*) descr = "", bool make_pdf = true)
    {
        mgl_write_prc(gr, fname, descr, make_pdf);
    }

    /// Export in JSON format suitable for later drawing by JavaScript
    void WriteJSON(string fname, const(char*) descr = "", bool force_z = false)
    {
        if (force_z)
            mgl_write_json_z(gr, fname, descr);
        else
            mgl_write_json(gr, fname, descr);
    }

    /// Return string of JSON data suitable for later drawing by JavaScript
    const(char*) GetJSON()
    {
        return mgl_get_json(gr);
    }

    /// Force preparing the image. It can be useful for OpenGL mode mostly.
    void Finish()
    {
        mgl_finish(gr);
    }

    /// Create new frame.
    void NewFrame()
    {
        mgl_new_frame(gr);
    }

    /// Finish frame drawing
    void EndFrame()
    {
        mgl_end_frame(gr);
    }

    /// Get the number of created frames
    int GetNumFrame()
    {
        return mgl_get_num_frame(gr);
    }

    /// Reset frames counter (start it from zero)
    void ResetFrames()
    {
        mgl_reset_frames(gr);
    }

    /// Delete primitives for i-th frame (work if MGL_VECT_FRAME is set on)
    void DelFrame(int i)
    {
        mgl_del_frame(gr, i);
    }

    /// Get drawing data for i-th frame (work if MGL_VECT_FRAME is set on)
    void GetFrame(int i)
    {
        mgl_get_frame(gr, i);
    }

    /// Set drawing data for i-th frame (work if MGL_VECT_FRAME is set on). Work as EndFrame() but don't add frame to GIF image.
    void SetFrame(int i)
    {
        mgl_set_frame(gr, i);
    }

    /// Append drawing data from i-th frame (work if MGL_VECT_FRAME is set on)
    void ShowFrame(int i)
    {
        mgl_show_frame(gr, i);
    }

    /// Clear list of primitives for current drawing
    void ClearFrame()
    {
        mgl_clear_frame(gr);
    }

    /// Start write frames to cinema using GIF format
    void StartGIF(string fname, int ms = 100)
    {
        mgl_start_gif(gr, fname, ms);
    }

    /// Stop writing cinema using GIF format
    void CloseGIF()
    {
        mgl_close_gif(gr);
    }

    /// Export points and primitives in file using MGLD format
    void ExportMGLD(string fname, string descr = 0)
    {
        mgl_export_mgld(gr, fname, descr);
    }

    /// Import points and primitives from file using MGLD format
    void ImportMGLD(string fname, bool add = false)
    {
        mgl_import_mgld(gr, fname, add);
    }

    /// Copy RGB values into array which is allocated by user
    bool GetRGB(char* imgdata, int imglen)
    {
        long w = mgl_get_width(gr), h = mgl_get_height(gr);
        if (imglen >= 3 * w * h)
            memcpy(imgdata, mgl_get_rgb(gr), 3 * w * h);
        return (imglen >= 3 * w * h);
    }

    const(ubyte*) GetRGB()
    {
        return mgl_get_rgb(gr);
    }

    /// Copy RGBA values into array which is allocated by user
    bool GetRGBA(char* imgdata, int imglen)
    {
        long w = mgl_get_width(gr), h = mgl_get_height(gr);
        if (imglen >= 4 * w * h)
            memcpy(imgdata, mgl_get_rgba(gr), 4 * w * h);
        return (imglen >= 4 * w * h);
    }

    const(ubyte*) GetRGBA()
    {
        return mgl_get_rgba(gr);
    }

    /// Copy BGRN values into array which is allocated by user
    bool GetBGRN(ubyte* imgdata, int imglen)
    {
        long w = mgl_get_width(gr), h = mgl_get_height(gr), i;
        const(ubyte*) buf = mgl_get_rgb(gr);
        if (imglen >= 4 * w * h)
            for (i = 0; i < w * h; i++)
            {
                imgdata[4 * i] = buf[3 * i + 2];
                imgdata[4 * i + 1] = buf[3 * i + 1];
                imgdata[4 * i + 2] = buf[3 * i];
                imgdata[4 * i + 3] = 255;
            }
        return (imglen >= 4 * w * h);
    }

    /// Copy RGBA values of background image into array which is allocated by user
    bool GetBackground(char* imgdata, int imglen)
    {
        long w = mgl_get_width(gr), h = mgl_get_height(gr);
        if (imglen >= 4 * w * h)
            memcpy(imgdata, mgl_get_background(gr), 4 * w * h);
        return imglen >= 4 * w * h;
    }

    const(ubyte*) GetBackground()
    {
        return mgl_get_background(gr);
    }

    /// Get width of the image
    int GetWidth()
    {
        return mgl_get_width(gr);
    }

    /// Get height of the image
    int GetHeight()
    {
        return mgl_get_height(gr);
    }

    /// Calculate 3D coordinate {x,y,z} for screen point {xs,ys}
    mglPoint CalcXYZ(int xs, int ys)
    {
        mreal x, y, z;
        mgl_calc_xyz(gr, xs, ys, x, y, z);
        return mglPoint(x, y, z);
    }

    /// Calculate screen point {xs,ys} for 3D coordinate {x,y,z}
    mglPoint CalcScr(mglPoint p)
    {
        int xs, ys;
        mgl_calc_scr(gr, p.x, p.y, p.z, xs, ys);
        return mglPoint(xs, ys);
    }

    /// Set object/subplot id
    void SetObjId(int id)
    {
        mgl_set_obj_id(gr, id);
    }

    /// Get object id
    int GetObjId(long x, long y)
    {
        return mgl_get_obj_id(gr, x, y);
    }

    /// Get subplot id
    int GetSplId(long x, long y)
    {
        return mgl_get_spl_id(gr, x, y);
    }

    /// Check if {\a xs,\a ys} is close to active point with accuracy d, and return its position or -1
    long IsActive(int xs, int ys, int d = 1)
    {
        return mgl_is_active(gr, xs, ys, d);
    }

    /// Combine plots from 2 canvases. Result will be saved into this
    void Combine(const(mglGraph*) g)
    {
        mgl_combine_gr(gr, g.gr);
    }

    /// Clear up the frame
    void Clf(double r, double g, double b)
    {
        mgl_clf_rgb(gr, r, g, b);
    }

    void Clf(string col)
    {
        mgl_clf_str(gr, col);
    }

    void Clf(char col)
    {
        mgl_clf_chr(gr, col);
    }

    void Clf()
    {
        mgl_clf(gr);
    }

    /// Clear unused points and primitives. Useful only in combination with SetFaceNum().
    void ClearUnused()
    {
        mgl_clear_unused(gr);
    }

    /// Load background image
    void LoadBackground(string fname, double alpha = 1)
    {
        mgl_load_background(gr, fname, alpha);
    }

    /// Force drawing the image and use it as background one
    void Rasterize()
    {
        mgl_rasterize(gr);
    }

    /// Draws the point (ball) at position {x,y,z} with color c
    void Ball(mglPoint p, char c = 'r')
    {
        char s[3] = {'.', c, 0};
        mgl_mark(gr, p.x, p.y, p.z, s);
    }

    /// Draws the mark at position p
    void Mark(mglPoint p, string mark)
    {
        mgl_mark(gr, p.x, p.y, p.z, mark);
    }

    /// Draws the line between points by specified pen
    void Line(mglPoint p1, mglPoint p2, string pen = "B", int n = 2)
    {
        mgl_line(gr, p1.x, p1.y, p1.z, p2.x, p2.y, p2.z, pen, n);
    }

    /// Draws the spline curve between points by specified pen
    void Curve(mglPoint p1, mglPoint d1, mglPoint p2, mglPoint d2, string pen = "B",
        int n = 100)
    {
        mgl_curve(gr, p1.x, p1.y, p1.z, d1.x, d1.y, d1.z, p2.x, p2.y, p2.z,
            d2.x, d2.y, d2.z, pen, n);
    }

    /// Draws the 3d error box e for point p
    void Error(mglPoint p, mglPoint e, string pen = "k")
    {
        mgl_error_box(gr, p.x, p.y, p.z, e.x, e.y, e.z, pen);
    }

    /// Draws the face between points with color stl (include interpolation up to 4 colors).
    void Face(mglPoint p1, mglPoint p2, mglPoint p3, mglPoint p4, string stl = "r")
    {
        mgl_face(gr, p1.x, p1.y, p1.z, p2.x, p2.y, p2.z, p3.x, p3.y, p3.z, p4.x, p4.y,
            p4.z, stl);
    }

    /// Draws the face in y-z plane at point p with color stl (include interpolation up to 4 colors).
    void FaceX(mglPoint p, double wy, double wz, string stl = "w", double dx = 0, double dy = 0)
    {
        mgl_facex(gr, p.x, p.y, p.z, wy, wz, toStringz(stl), dx, dy);
    }

    /// Draws the face in x-z plane at point p with color stl (include interpolation up to 4 colors).
    void FaceY(mglPoint p, double wx, double wz, string stl = "w", double dx = 0, double dy = 0)
    {
        mgl_facey(gr, p.x, p.y, p.z, wx, wz, toStringz(stl), dx, dy);
    }

    /// Draws the face in x-y plane at point p with color stl (include interpolation up to 4 colors).
    void FaceZ(mglPoint p, double wx, double wy, string stl = "w", double dx = 0, double dy = 0)
    {
        mgl_facez(gr, p.x, p.y, p.z, wx, wy, toStringz(stl), dx, dy);
    }

    /// Draws the drop at point p in direction d with color col and radius r
    void Drop(mglPoint p, mglPoint d, double r, string col = "r", double shift = 1,
        double ap = 1)
    {
        mgl_drop(gr, p.x, p.y, p.z, d.x, d.y, d.z, r, col, shift, ap);
    }

    /// Draws the sphere at point p with color col and radius r
    void Sphere(mglPoint p, double r, string col = "r")
    {
        mgl_sphere(gr, p.x, p.y, p.z, r, col);
    }

    /// Draws the cone between points p1,p2 with radius r1,r2 and with style stl
    void Cone(mglPoint p1, mglPoint p2, double r1, double r2 = -1, string stl = "r@")
    {
        mgl_cone(gr, p1.x, p1.y, p1.z, p2.x, p2.y, p2.z, r1, r2, stl);
    }

    /// Draws the ellipse between points p1,p2 with color stl and width r
    void Ellipse(mglPoint p1, mglPoint p2, double r, string stl = "r")
    {
        mgl_ellipse(gr, p1.x, p1.y, p1.z, p2.x, p2.y, p2.z, r, stl);
    }

    /// Draws the circle at point p with color stl and radius r
    void Circle(mglPoint p, double r, string stl = "r")
    {
        mgl_ellipse(gr, p.x, p.y, p.z, p.x, p.y, p.z, r, stl);
    }

    /// Draws the rhomb between points p1,p2 with color stl and width r
    void Rhomb(mglPoint p1, mglPoint p2, double r, string stl = "r")
    {
        mgl_rhomb(gr, p1.x, p1.y, p1.z, p2.x, p2.y, p2.z, r, stl);
    }

    /// Draws the polygon based on points p1,p2 with color stl
    void Polygon(mglPoint p1, mglPoint p2, int n, string stl = "r")
    {
        mgl_polygon(gr, p1.x, p1.y, p1.z, p2.x, p2.y, p2.z, n, stl);
    }

    /// Draws the arc around axis pr with center at p0 and starting from p1, by color stl and angle a (in degrees)
    void Arc(mglPoint p0, mglPoint pr, mglPoint p1, double a, string stl = "r")
    {
        mgl_arc_ext(gr, p0.x, p0.y, p0.z, pr.x, pr.y, pr.z, p1.x, p1.y, p1.z, a, stl);
    }

    /// Draws the arc around axis 'z' with center at p0 and starting from p1, by color stl and angle a (in degrees)
    void Arc(mglPoint p0, mglPoint p1, double a, string stl = "r")
    {
        mgl_arc_ext(gr, p0.x, p0.y, p0.z, 0, 0, 1, p1.x, p1.y, p0.z, a, stl);
    }

    /// Draws bitmap (logo) which is stretched along whole axis range
    void Logo(long w, long h, const(ubyte*) rgba, bool smooth = false, string opt = "")
    {
        mgl_logo(gr, w, h, rgba, smooth, toStringz(opt));
    }

    void Logo(string fname, bool smooth = false, string opt = "")
    {
        mgl_logo_file(gr, fname, smooth, toStringz(opt));
    }

    /// Print text in position p with specified font
    void Putsw(mglPoint p, const wchar_t* text, const(char*) font = ":C", double size = -1)
    {
        mgl_putsw(gr, p.x, p.y, p.z, text, font, size);
    }

    void Puts(mglPoint p, const(char*) text, const(char*) font = ":C", double size = -1)
    {
        mgl_puts(gr, p.x, p.y, p.z, text, font, size);
    }

    void Putsw(double x, double y, const wchar_t* text, const(char*) font = ":AC",
        double size = -1)
    {
        mgl_putsw(gr, x, y, 0, text, font, size);
    }

    void Puts(double x, double y, const(char*) text, const(char*) font = ":AC", double size = -1)
    {
        mgl_puts(gr, x, y, 0, text, font, size);
    }

    /// Print text in position p along direction d with specified font
    void Putsw(mglPoint p, mglPoint d, const wchar_t* text, string font = ":L", double size = -1)
    {
        mgl_putsw_dir(gr, p.x, p.y, p.z, d.x, d.y, d.z, text, font, size);
    }

    void Puts(mglPoint p, mglPoint d, string text, string font = ":L", double size = -1)
    {
        mgl_puts_dir(gr, p.x, p.y, p.z, d.x, d.y, d.z, text, font, size);
    }

    /// Print text along the curve
    void Text(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) z,
        string text, string font = "", string opt = "")
    {
        mgl_text_xyz(gr, x, y, z, text, font, toStringz(opt));
    }

    void Text(const(mglDataA*) x, const(mglDataA*) y, string text, string font = "",
        string opt = "")
    {
        mgl_text_xy(gr, x, y, text, font, toStringz(opt));
    }

    void Text(const(mglDataA*) y, string text, string font = "", string opt = "")
    {
        mgl_text_y(gr, y, text, font, toStringz(opt));
    }

    void Text(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) z,
        const wchar_t* text, string font = "", string opt = "")
    {
        mgl_textw_xyz(gr, x, y, z, text, font, toStringz(opt));
    }

    void Text(const(mglDataA*) x, const(mglDataA*) y, const wchar_t* text,
        string font = "", string opt = "")
    {
        mgl_textw_xy(gr, x, y, text, font, toStringz(opt));
    }

    void Text(const(mglDataA*) y, const wchar_t* text, string font = "", string opt = "")
    {
        mgl_textw_y(gr, y, text, font, toStringz(opt));
    }

    /// Draws bounding box outside the plotting volume with color c.
    void Box(string col = "", bool ticks = true)
    {
        mgl_box_str(gr, col, ticks);
    }

    /// Draw axises with ticks in direction(s) dir.
    void Axis(string dir = "xyzt", string stl = "", string opt = "")
    {
        mgl_axis(gr, dir, stl, opt);
    }

    /// Draw grid lines perpendicular to direction(s) dir.
    void Grid(string dir = "xyzt", const(char*) pen = "B", string opt = "")
    {
        mgl_axis_grid(gr, dir, pen, toStringz(opt));
    }

    /// Print the label text for axis dir.
    void Label(char dir, string text, double pos = +1, string opt = "")
    {
        mgl_label(gr, dir, text, pos, toStringz(opt));
    }

    void Label(char dir, const wchar_t* text, double pos = +1, string opt = "")
    {
        mgl_labelw(gr, dir, text, pos, toStringz(opt));
    }

    /// Draw colorbar at edge of axis
    void Colorbar(string sch = "")
    {
        mgl_colorbar(gr, sch);
    }

    void Colorbar(string sch, double x, double y, double w = 1, double h = 1)
    {
        mgl_colorbar_ext(gr, toStringz(sch), x, y, w, h);
    }

    /// Draw colorbar with manual colors at edge of axis
    void Colorbar(const(mglDataA*) val, string sch = "")
    {
        mgl_colorbar_val(gr, val, sch);
    }

    void Colorbar(const(mglDataA*) val, string sch, double x, double y, double w = 1,
        double h = 1)
    {
        mgl_colorbar_val_ext(gr, val, toStringz(sch), x, y, w, h);
    }

    /// Add string to legend
    void AddLegend(string text, const(char*) style)
    {
        mgl_add_legend(gr, text, style);
    }

    void AddLegend(const wchar_t* text, const(char*) style)
    {
        mgl_add_legendw(gr, text, style);
    }

    /// Clear saved legend string
    void ClearLegend()
    {
        mgl_clear_legend(gr);
    }

    /// Draw legend of accumulated strings at position {x,y}
    void Legend(double x, double y, string font = "#", string opt = "")
    {
        mgl_legend_pos(gr, x, y, font, toStringz(opt));
    }

    /// Draw legend of accumulated strings
    void Legend(int where = 3, string font = "#", string opt = "")
    {
        mgl_legend(gr, where, font, toStringz(opt));
    }

    /// Set number of marks in legend sample
    void SetLegendMarks(int num)
    {
        mgl_set_legend_marks(gr, num);
    }

    /// Draw usual curve {x,y,z}
    void Plot(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) z,
        string pen = "", string opt = "")
    {
        mgl_plot_xyz(gr, x, y, z, pen, toStringz(opt));
    }

    void Plot(const(mglDataA*) x, const(mglDataA*) y, string pen = "", string opt = "")
    {
        mgl_plot_xy(gr, x, y, pen, opt);
    }

    void Plot(const(mglDataA*) y, string pen = "", string opt = "")
    {
        mgl_plot(gr, y, pen, opt);
    }

    /// Draw tape(s) which rotates as (bi-)normales of curve {x,y,z}
    void Tape(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) z,
        string pen = "", string opt = "")
    {
        mgl_tape_xyz(gr, x, y, z, pen, toStringz(opt));
    }

    void Tape(const(mglDataA*) x, const(mglDataA*) y, string pen = "", string opt = "")
    {
        mgl_tape_xy(gr, x, y, pen, opt);
    }

    void Tape(const(mglDataA*) y, string pen = "", string opt = "")
    {
        mgl_tape(gr, y, pen, opt);
    }

    /// Draw radar chart (plot in curved coordinates)
    void Radar(const(mglDataA*) a, string pen = "", string opt = "")
    {
        mgl_radar(gr, a, pen, toStringz(opt));
    }

    /// Draw stairs for points in arrays {x,y,z}
    void Step(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) z,
        string pen = "", string opt = "")
    {
        mgl_step_xyz(gr, x, y, z, pen, toStringz(opt));
    }

    void Step(const(mglDataA*) x, const(mglDataA*) y, string pen = "", string opt = "")
    {
        mgl_step_xy(gr, x, y, pen, toStringz(opt));
    }

    void Step(const(mglDataA*) y, string pen = "", string opt = "")
    {
        mgl_step(gr, y, pen, toStringz(opt));
    }

    /// Draw curve {x,y,z} which is colored by c (like tension plot)
    void Tens(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) z,
        const(mglDataA*) c, string pen = "", string opt = "")
    {
        mgl_tens_xyz(gr, x, y, z, c, pen, toStringz(opt));
    }

    void Tens(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) c,
        string pen = "", string opt = "")
    {
        mgl_tens_xy(gr, x, y, c, pen, toStringz(opt));
    }

    void Tens(const(mglDataA*) y, const(mglDataA*) c, string pen = "", string opt = "")
    {
        mgl_tens(gr, y, c, pen, toStringz(opt));
    }

    /// Fill area between curve {x,y,z} and axis plane
    void Area(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) z,
        string pen = "", string opt = "")
    {
        mgl_area_xyz(gr, x, y, z, pen, toStringz(opt));
    }

    void Area(const(mglDataA*) x, const(mglDataA*) y, string pen = "", string opt = "")
    {
        mgl_area_xy(gr, x, y, pen, toStringz(opt));
    }

    void Area(const(mglDataA*) y, string pen = "", string opt = "")
    {
        mgl_area(gr, y, pen, toStringz(opt));
    }

    /// Fill area between curves y1 and y2 specified parametrically
    void Region(const(mglDataA*) y1, const(mglDataA*) y2, string pen = "", string opt = "")
    {
        mgl_region(gr, y1, y2, pen, toStringz(opt));
    }

    void Region(const(mglDataA*) x, const(mglDataA*) y1, const(mglDataA*) y2,
        string pen = "", string opt = "")
    {
        mgl_region_xy(gr, x, y1, y2, pen, toStringz(opt));
    }

    /// Fill area (draw ribbon) between curves {x1,y1,z1} and {x2,y2,z2}
    void Region(const(mglDataA*) x1, const(mglDataA*) y1, const(mglDataA*) z1,
        const(mglDataA*) x2, const(mglDataA*) y2, const(mglDataA*) z2,
        string pen = "", string opt = "")
    {
        mgl_region_3d(gr, x1, y1, z1, x2, y2, z2, pen, toStringz(opt));
    }

    void Region(const(mglDataA*) x1, const(mglDataA*) y1, const(mglDataA*) x2,
        const(mglDataA*) y2, string pen = "", string opt = "")
    {
        mgl_region_3d(gr, x1, y1, null, x2, y2, null, pen, toStringz(opt));
    }

    /// Draw vertical lines from points {x,y,z} to axis plane
    void Stem(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) z,
        string pen = "", string opt = "")
    {
        mgl_stem_xyz(gr, x, y, z, pen, toStringz(opt));
    }

    void Stem(const(mglDataA*) x, const(mglDataA*) y, string pen = "", string opt = "")
    {
        mgl_stem_xy(gr, x, y, pen, toStringz(opt));
    }

    void Stem(const(mglDataA*) y, string pen = "", string opt = "")
    {
        mgl_stem(gr, y, pen, toStringz(opt));
    }

    /// Draw vertical bars from points {x,y,z} to axis plane
    void Bars(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) z,
        string pen = "", string opt = "")
    {
        mgl_bars_xyz(gr, x, y, z, pen, toStringz(opt));
    }

    void Bars(const(mglDataA*) x, const(mglDataA*) y, string pen = "", string opt = "")
    {
        mgl_bars_xy(gr, x, y, pen, toStringz(opt));
    }

    void Bars(const(mglDataA*) y, string pen = "", string opt = "")
    {
        mgl_bars(gr, y, pen, toStringz(opt));
    }

    /// Draw horizontal bars from points {x,y} to axis plane
    void Barh(const(mglDataA*) y, const(mglDataA*) v, string pen = "", string opt = "")
    {
        mgl_barh_yx(gr, y, v, pen, toStringz(opt));
    }

    void Barh(const(mglDataA*) v, string pen = "", string opt = "")
    {
        mgl_barh(gr, v, pen, toStringz(opt));
    }

    /// Draw chart for data a
    void Chart(const(mglDataA*) a, string colors = "", string opt = "")
    {
        mgl_chart(gr, a, colors, opt);
    }

    /// Draw Open-High-Low-Close (OHLC) diagram
    void OHLC(const(mglDataA*) x, const(mglDataA*) open, const(mglDataA*) high,
        const(mglDataA*) low, const(mglDataA*) close, string pen = "", string opt = "")
    {
        mgl_ohlc_x(gr, x, open, high, low, close, pen, opt);
    }

    void OHLC(const(mglDataA*) open, const(mglDataA*) high,
        const(mglDataA*) low, const(mglDataA*) close, string pen = "", string opt = "")
    {
        mgl_ohlc(gr, open, high, low, close, pen, opt);
    }

    /// Draw box-plot (special 5-value plot used in statistic)
    void BoxPlot(const(mglDataA*) x, const(mglDataA*) y, string pen = "", string opt = "")
    {
        mgl_boxplot_xy(gr, x, y, pen, opt);
    }

    void BoxPlot(const(mglDataA*) y, string pen = "", string opt = "")
    {
        mgl_boxplot(gr, y, pen, opt);
    }

    /// Draw candle plot
    void Candle(const(mglDataA*) x, const(mglDataA*) v1, const(mglDataA*) v2,
        const(mglDataA*) y1, const(mglDataA*) y2, string pen = "", string opt = "")
    {
        mgl_candle_xyv(gr, xv1v2, y1, y2, pen, toStringz(opt));
    }

    void Candle(const(mglDataA*) v1, const(mglDataA*) v2, const(mglDataA*) y1,
        const(mglDataA*) y2, string pen = "", string opt = "")
    {
        mgl_candle_yv(grv1v2, y1, y2, pen, toStringz(opt));
    }

    void Candle(const(mglDataA*) v1, const(mglDataA*) v2, string pen = "", string opt = "")
    {
        mgl_candle_yv(grv1v2, null, null, pen, toStringz(opt));
    }

    void Candle(const(mglDataA*) y, const(mglDataA*) y1, const(mglDataA*) y2,
        string pen = "", string opt = "")
    {
        mgl_candle(gr, y, y1, y2, pen, toStringz(opt));
    }

    void Candle(const(mglDataA*) y, string pen = "", string opt = "")
    {
        mgl_candle(gr, y, null, null, pen, toStringz(opt));
    }

    /// Draw cones from points {x,y,z} to axis plane
    void Cones(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) z,
        string pen = "@", string opt = "")
    {
        mgl_cones_xyz(gr, x, y, z, pen, toStringz(opt));
    }

    void Cones(const(mglDataA*) x, const(mglDataA*) z, string pen = "@", string opt = "")
    {
        mgl_cones_xz(gr, x, z, pen, toStringz(opt));
    }

    void Cones(const(mglDataA*) z, string pen = "@", string opt = "")
    {
        mgl_cones(gr, z, pen, toStringz(opt));
    }

    /// Draw error boxes {ex,ey} at points {x,y}
    void Error(const(mglDataA*) y, const(mglDataA*) ey, string pen = "", string opt = "")
    {
        mgl_error(gr, y, ey, pen, toStringz(opt));
    }

    void Error(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) ey,
        string pen = "", string opt = "")
    {
        mgl_error_xy(gr, x, y, ey, pen, toStringz(opt));
    }

    void Error(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) ex,
        const(mglDataA*) ey, string pen = "", string opt = "")
    {
        mgl_error_exy(gr, x, y, ex, ey, pen, toStringz(opt));
    }

    /// Draw marks with size r at points {x,y,z}
    void Mark(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) z,
        const(mglDataA*) r, string pen, string opt = "")
    {
        mgl_mark_xyz(gr, x, y, z, r, pen, toStringz(opt));
    }

    void Mark(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) r,
        string pen, string opt = "")
    {
        mgl_mark_xy(gr, x, y, r, pen, toStringz(opt));
    }

    void Mark(const(mglDataA*) y, const(mglDataA*) r, string pen, string opt = "")
    {
        mgl_mark_y(gr, y, r, pen, toStringz(opt));
    }

    /// Draw textual marks with size r at points {x,y,z}
    void TextMark(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) z,
        const(mglDataA*) r, string text, string fnt = "", string opt = "")
    {
        mgl_textmark_xyzr(gr, x, y, z, r, text, fnt, toStringz(opt));
    }

    void TextMark(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) r,
        string text, string fnt = "", string opt = "")
    {
        mgl_textmark_xyr(gr, x, y, r, text, fnt, toStringz(opt));
    }

    void TextMark(const(mglDataA*) y, const(mglDataA*) r, string text,
        string fnt = "", string opt = "")
    {
        mgl_textmark_yr(gr, y, r, text, fnt, toStringz(opt));
    }

    void TextMark(const(mglDataA*) y, string text, string fnt = "", string opt = "")
    {
        mgl_textmark(gr, y, text, fnt, toStringz(opt));
    }

    void TextMark(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) z,
        const(mglDataA*) r, const wchar_t* text, string fnt = "", string opt = "")
    {
        mgl_textmarkw_xyzr(gr, x, y, z, r, text, fnt, toStringz(opt));
    }

    void TextMark(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) r,
        const wchar_t* text, string fnt = "", string opt = "")
    {
        mgl_textmarkw_xyr(gr, x, y, r, text, fnt, toStringz(opt));
    }

    void TextMark(const(mglDataA*) y, const(mglDataA*) r, const wchar_t* text,
        string fnt = "", string opt = "")
    {
        mgl_textmarkw_yr(gr, y, r, text, fnt, toStringz(opt));
    }

    void TextMark(const(mglDataA*) y, const wchar_t* text, string fnt = "", string opt = "")
    {
        mgl_textmarkw(gr, y, text, fnt, toStringz(opt));
    }

    /// Draw labels for points coordinate(s) at points {x,y,z}
    void Label(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) z,
        string text, string fnt = "", string opt = "")
    {
        mgl_label_xyz(gr, x, y, z, text, fnt, toStringz(opt));
    }

    void Label(const(mglDataA*) x, const(mglDataA*) y, string text, string fnt = "",
        string opt = "")
    {
        mgl_label_xy(gr, x, y, text, fnt, toStringz(opt));
    }

    void Label(const(mglDataA*) y, string text, string fnt = "", string opt = "")
    {
        mgl_label_y(gr, y, text, fnt, toStringz(opt));
    }

    void Label(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) z,
        const wchar_t* text, string fnt = "", string opt = "")
    {
        mgl_labelw_xyz(gr, x, y, z, text, fnt, toStringz(opt));
    }

    void Label(const(mglDataA*) x, const(mglDataA*) y, const wchar_t* text,
        string fnt = "", string opt = "")
    {
        mgl_labelw_xy(gr, x, y, text, fnt, toStringz(opt));
    }

    void Label(const(mglDataA*) y, const wchar_t* text, string fnt = "", string opt = "")
    {
        mgl_labelw_y(gr, y, text, fnt, toStringz(opt));
    }

    /// Draw table for values val along given direction with row labels text
    void Table(const(mglDataA*) val, string text, string fnt = "#|", string opt = "")
    {
        mgl_table(gr, 0, 0, val, text, fnt, toStringz(opt));
    }

    void Table(const(mglDataA*) val, const wchar_t* text, string fnt = "#|", string opt = "")
    {
        mgl_tablew(gr, 0, 0, val, text, fnt, toStringz(opt));
    }

    /// Draw table for values val along given direction with row labels text at given position
    void Table(double x, double y, const(mglDataA*) val, string text,
        string fnt = "#|", string opt = "")
    {
        mgl_table(gr, x, y, val, text, fnt, toStringz(opt));
    }

    void Table(double x, double y, const(mglDataA*) val, const wchar_t* text,
        string fnt = "#|", string opt = "")
    {
        mgl_tablew(gr, x, y, val, text, fnt, toStringz(opt));
    }

    /// Draw tube with radius r around curve {x,y,z}
    void Tube(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) z,
        const(mglDataA*) r, string pen = "", string opt = "")
    {
        mgl_tube_xyzr(gr, x, y, z, r, pen, toStringz(opt));
    }

    void Tube(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) z,
        double r, string pen = "", string opt = "")
    {
        mgl_tube_xyz(gr, x, y, z, r, pen, toStringz(opt));
    }

    void Tube(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) r,
        string pen = "", string opt = "")
    {
        mgl_tube_xyr(gr, x, y, r, pen, toStringz(opt));
    }

    void Tube(const(mglDataA*) x, const(mglDataA*) y, double r, string pen = "", string opt = "")
    {
        mgl_tube_xy(gr, x, y, r, pen, toStringz(opt));
    }

    void Tube(const(mglDataA*) y, const(mglDataA*) r, string pen = "", string opt = "")
    {
        mgl_tube_r(gr, y, r, pen, toStringz(opt));
    }

    void Tube(const(mglDataA*) y, double r, string pen = "", string opt = "")
    {
        mgl_tube(gr, y, r, pen, toStringz(opt));
    }

    /// Draw surface of curve {r,z} rotatation around axis
    void Torus(const(mglDataA*) r, const(mglDataA*) z, string pen = "", string opt = "")
    {
        mgl_torus(gr, r, z, pen, opt);
    }

    /// Draw mesh lines for 2d data specified parametrically
    void Mesh(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) z,
        string stl = "", string opt = "")
    {
        mgl_mesh_xy(gr, x, y, z, toStringz(stl), toStringz(opt));
    }

    void Mesh(const(mglDataA*) z, string stl = "", string opt = "")
    {
        mgl_mesh(gr, z, toStringz(stl), toStringz(opt));
    }

    /// Draw mesh lines for 2d data specified parametrically
    void Fall(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) z,
        string stl = "", string opt = "")
    {
        mgl_fall_xy(gr, x, y, z, toStringz(stl), toStringz(opt));
    }

    void Fall(const(mglDataA*) z, string stl = "", string opt = "")
    {
        mgl_fall(gr, z, toStringz(stl), toStringz(opt));
    }

    /// Draw belts for 2d data specified parametrically
    void Belt(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) z,
        string stl = "", string opt = "")
    {
        mgl_belt_xy(gr, x, y, z, toStringz(stl), toStringz(opt));
    }

    void Belt(const(mglDataA*) z, string stl = "", string opt = "")
    {
        mgl_belt(gr, z, toStringz(stl), toStringz(opt));
    }

    /// Draw surface for 2d data specified parametrically with color proportional to z
    void Surf(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) z,
        string stl = "", string opt = "")
    {
        mgl_surf_xy(gr, x, y, z, toStringz(stl), toStringz(opt));
    }

    void Surf(const(mglDataA*) z, string stl = "", string opt = "")
    {
        mgl_surf(gr, z, toStringz(stl), toStringz(opt));
    }

    /// Draw grid lines for density plot of 2d data specified parametrically
    void Grid(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) z,
        string stl = "", string opt = "")
    {
        mgl_grid_xy(gr, x, y, z, toStringz(stl), toStringz(opt));
    }

    void Grid(const(mglDataA*) z, string stl = "", string opt = "")
    {
        mgl_grid(gr, z, toStringz(stl), toStringz(opt));
    }

    /// Draw vertical tiles for 2d data specified parametrically
    void Tile(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) z,
        string stl = "", string opt = "")
    {
        mgl_tile_xy(gr, x, y, z, toStringz(stl), toStringz(opt));
    }

    void Tile(const(mglDataA*) z, string stl = "", string opt = "")
    {
        mgl_tile(gr, z, toStringz(stl), toStringz(opt));
    }

    /// Draw density plot for 2d data specified parametrically
    void Dens(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) z,
        string stl = "", string opt = "")
    {
        mgl_dens_xy(gr, x, y, z, toStringz(stl), toStringz(opt));
    }

    void Dens(const(mglDataA*) z, string stl = "", string opt = "")
    {
        mgl_dens(gr, z, toStringz(stl), toStringz(opt));
    }

    /// Draw vertical boxes for 2d data specified parametrically
    void Boxs(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) z,
        string stl = "", string opt = "")
    {
        mgl_boxs_xy(gr, x, y, z, toStringz(stl), toStringz(opt));
    }

    void Boxs(const(mglDataA*) z, string stl = "", string opt = "")
    {
        mgl_boxs(gr, z, toStringz(stl), toStringz(opt));
    }

    /// Draw contour lines for 2d data specified parametrically
    void Cont(const(mglDataA*) v, const(mglDataA*) x, const(mglDataA*) y,
        const(mglDataA*) z, string sch = "", string opt = "")
    {
        mgl_cont_xy_val(grv, x, y, z, toStringz(sch), toStringz(opt));
    }

    void Cont(const(mglDataA*) v, const(mglDataA*) z, string sch = "", string opt = "")
    {
        mgl_cont_val(gr, v, z, toStringz(sch), toStringz(opt));
    }

    void Cont(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) z,
        string sch = "", string opt = "")
    {
        mgl_cont_xy(gr, x, y, z, toStringz(sch), toStringz(opt));
    }

    void Cont(const(mglDataA*) z, string sch = "", string opt = "")
    {
        mgl_cont(gr, z, toStringz(sch), toStringz(opt));
    }

    /// Draw solid contours for 2d data specified parametrically
    void ContF(const(mglDataA*) v, const(mglDataA*) x, const(mglDataA*) y,
        const(mglDataA*) z, string sch = "", string opt = "")
    {
        mgl_contf_xy_val(grv, x, y, z, toStringz(sch), toStringz(opt));
    }

    void ContF(const(mglDataA*) v, const(mglDataA*) z, string sch = "", string opt = "")
    {
        mgl_contf_val(gr, v, z, toStringz(sch), toStringz(opt));
    }

    void ContF(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) z,
        string sch = "", string opt = "")
    {
        mgl_contf_xy(gr, x, y, z, toStringz(sch), toStringz(opt));
    }

    void ContF(const(mglDataA*) z, string sch = "", string opt = "")
    {
        mgl_contf(gr, z, toStringz(sch), toStringz(opt));
    }

    /// Draw solid contours for 2d data specified parametrically with manual colors
    void ContD(const(mglDataA*) v, const(mglDataA*) x, const(mglDataA*) y,
        const(mglDataA*) z, string sch = "", string opt = "")
    {
        mgl_contd_xy_val(grv, x, y, z, toStringz(sch), toStringz(opt));
    }

    void ContD(const(mglDataA*) v, const(mglDataA*) z, string sch = "", string opt = "")
    {
        mgl_contd_val(gr, v, z, toStringz(sch), toStringz(opt));
    }

    void ContD(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) z,
        string sch = "", string opt = "")
    {
        mgl_contd_xy(gr, x, y, z, toStringz(sch), toStringz(opt));
    }

    void ContD(const(mglDataA*) z, string sch = "", string opt = "")
    {
        mgl_contd(gr, z, toStringz(sch), toStringz(opt));
    }

    /// Draw contour tubes for 2d data specified parametrically
    void ContV(const(mglDataA*) v, const(mglDataA*) x, const(mglDataA*) y,
        const(mglDataA*) z, string sch = "", string opt = "")
    {
        mgl_contv_xy_val(grv, x, y, z, toStringz(sch), toStringz(opt));
    }

    void ContV(const(mglDataA*) v, const(mglDataA*) z, string sch = "", string opt = "")
    {
        mgl_contv_val(gr, v, z, toStringz(sch), toStringz(opt));
    }

    void ContV(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) z,
        string sch = "", string opt = "")
    {
        mgl_contv_xy(gr, x, y, z, toStringz(sch), toStringz(opt));
    }

    void ContV(const(mglDataA*) z, string sch = "", string opt = "")
    {
        mgl_contv(gr, z, toStringz(sch), toStringz(opt));
    }

    /// Draw axial-symmetric isosurfaces for 2d data specified parametrically
    void Axial(const(mglDataA*) v, const(mglDataA*) x, const(mglDataA*) y,
        const(mglDataA*) z, string sch = "", string opt = "")
    {
        mgl_axial_xy_val(grv, x, y, z, toStringz(sch), opt);
    }

    void Axial(const(mglDataA*) v, const(mglDataA*) z, string sch = "", string opt = "")
    {
        mgl_axial_val(gr, v, z, toStringz(sch), toStringz(opt));
    }

    void Axial(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) z,
        string sch = "", string opt = "")
    {
        mgl_axial_xy(gr, x, y, z, toStringz(sch), toStringz(opt));
    }

    void Axial(const(mglDataA*) z, string sch = "", string opt = "")
    {
        mgl_axial(gr, z, toStringz(sch), toStringz(opt));
    }

    /// Draw grid lines for density plot at slice for 3d data specified parametrically
    void Grid3(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) z,
        const(mglDataA*) a, string stl = "", double sVal = -1, string opt = "")
    {
        mgl_grid3_xyz(gr, x, y, z, a, toStringz(stl), sVal, toStringz(opt));
    }

    void Grid3(const(mglDataA*) a, string stl = "", double sVal = -1, string opt = "")
    {
        mgl_grid3(gr, a, toStringz(stl), sVal, toStringz(opt));
    }

    /// Draw density plot at slice for 3d data specified parametrically
    void Dens3(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) z,
        const(mglDataA*) a, string stl = "", double sVal = -1, string opt = "")
    {
        mgl_dens3_xyz(gr, x, y, z, a, toStringz(stl), sVal, toStringz(opt));
    }

    void Dens3(const(mglDataA*) a, string stl = "", double sVal = -1, string opt = "")
    {
        mgl_dens3(gr, a, toStringz(stl), sVal, toStringz(opt));
    }

    /// Draw isosurface(s) for 3d data specified parametrically
    void Surf3(double Val, const(mglDataA*) x, const(mglDataA*) y,
        const(mglDataA*) z, const(mglDataA*) a, string stl = "", string opt = "")
    {
        mgl_surf3_xyz_val(gr, Val, x, y, z, a, toStringz(stl), toStringz(opt));
    }

    void Surf3(double Val, const(mglDataA*) a, string stl = "", string opt = "")
    {
        mgl_surf3_val(gr, Val, a, toStringz(stl), toStringz(opt));
    }

    void Surf3(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) z,
        const(mglDataA*) a, string stl = "", string opt = "")
    {
        mgl_surf3_xyz(gr, x, y, z, a, toStringz(stl), toStringz(opt));
    }

    void Surf3(const(mglDataA*) a, string stl = "", string opt = "")
    {
        mgl_surf3(gr, a, toStringz(stl), toStringz(opt));
    }

    /// Draw a semi-transparent cloud for 3d data
    void Cloud(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) z,
        const(mglDataA*) a, string stl = "", string opt = "")
    {
        mgl_cloud_xyz(gr, x, y, z, a, toStringz(stl), toStringz(opt));
    }

    void Cloud(const(mglDataA*) a, string stl = "", string opt = "")
    {
        mgl_cloud(gr, a, toStringz(stl), toStringz(opt));
    }

    /// Draw contour lines at slice for 3d data specified parametrically
    void Cont3(const(mglDataA*) v, const(mglDataA*) x, const(mglDataA*) y,
        const(mglDataA*) z, const(mglDataA*) a, string sch = "", double sVal = -1,
        string opt = "")
    {
        mgl_cont3_xyz_val(grv, x, y, z, a, toStringz(sch), sVal, toStringz(opt));
    }

    void Cont3(const(mglDataA*) v, const(mglDataA*) a, string sch = "",
        double sVal = -1, string opt = "")
    {
        mgl_cont3_val(gr, v, a, toStringz(sch), sVal, toStringz(opt));
    }

    void Cont3(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) z,
        const(mglDataA*) a, string sch = "", double sVal = -1, string opt = "")
    {
        mgl_cont3_xyz(gr, x, y, z, a, toStringz(sch), sVal, toStringz(opt));
    }

    void Cont3(const(mglDataA*) a, string sch = "", double sVal = -1, string opt = "")
    {
        mgl_cont3(gr, a, toStringz(sch), sVal, toStringz(opt));
    }

    /// Draw solid contours at slice for 3d data specified parametrically
    void ContF3(const(mglDataA*) v, const(mglDataA*) x, const(mglDataA*) y,
        const(mglDataA*) z, const(mglDataA*) a, string sch = "", double sVal = -1,
        string opt = "")
    {
        mgl_contf3_xyz_val(grv, x, y, z, a, toStringz(sch), sVal, toStringz(opt));
    }

    void ContF3(const(mglDataA*) v, const(mglDataA*) a, string sch = "",
        double sVal = -1, string opt = "")
    {
        mgl_contf3_val(gr, v, a, toStringz(sch), sVal, toStringz(opt));
    }

    void ContF3(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) z,
        const(mglDataA*) a, string sch = "", double sVal = -1, string opt = "")
    {
        mgl_contf3_xyz(gr, x, y, z, a, toStringz(sch), sVal, toStringz(opt));
    }

    void ContF3(const(mglDataA*) a, string sch = "", double sVal = -1, string opt = "")
    {
        mgl_contf3(gr, a, toStringz(sch), sVal, toStringz(opt));
    }

    /// Draw several isosurfaces for 3d beam in curvilinear coordinates
    void Beam(const(mglDataA*) tr, const(mglDataA*) g1, const(mglDataA*) g2,
        const(mglDataA*) a, double r, string stl = 0, int flag = 0, int num = 3)
    {
        mgl_beam(gr, tr, g1, g2, a, r, stl, flag, num);
    }

    void Beam(double val, const(mglDataA*) tr, const(mglDataA*) g1,
        const(mglDataA*) g2, const(mglDataA*) a, double r, string stl = null, int flag = 0)
    {
        mgl_beam_val(gr, val, tr, g1, g2, a, r, stl, flag);
    }

    /// Draw vertical tiles with variable size r for 2d data specified parametrically
    void TileS(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) z,
        const(mglDataA*) r, string stl = "", string opt = "")
    {
        mgl_tiles_xy(gr, x, y, z, r, toStringz(stl), toStringz(opt));
    }

    void TileS(const(mglDataA*) z, const(mglDataA*) r, string stl = "", string opt = "")
    {
        mgl_tiles(gr, z, r, toStringz(stl), toStringz(opt));
    }

    /// Draw surface for 2d data specified parametrically with color proportional to c
    void SurfC(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) z,
        const(mglDataA*) c, string sch = "", string opt = "")
    {
        mgl_surfc_xy(gr, x, y, z, c, toStringz(sch), opt);
    }

    void SurfC(const(mglDataA*) z, const(mglDataA*) c, string sch = "", string opt = "")
    {
        mgl_surfc(gr, z, c, toStringz(sch), opt);
    }

    /// Draw surface for 2d data specified parametrically with alpha proportional to c
    void SurfA(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) z,
        const(mglDataA*) c, string sch = "", string opt = "")
    {
        mgl_surfa_xy(gr, x, y, z, c, toStringz(sch), opt);
    }

    void SurfA(const(mglDataA*) z, const(mglDataA*) c, string sch = "", string opt = "")
    {
        mgl_surfa(gr, z, c, toStringz(sch), opt);
    }

    /// Color map of matrix a to matrix b, both matrix can parametrically depend on coordinates
    void Map(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) a,
        const(mglDataA*) b, string sch = "", string opt = "")
    {
        mgl_map_xy(gr, x, y, a, b, toStringz(sch), toStringz(opt));
    }

    void Map(const(mglDataA*) a, const(mglDataA*) b, string sch = "", string opt = "")
    {
        mgl_map(gr, a, b, toStringz(sch), toStringz(opt));
    }

    /// Draw density plot for spectra-gramm specified parametrically
    void STFA(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) re,
        const(mglDataA*) im, int dn, string sch = "", string opt = "")
    {
        mgl_stfa_xy(gr, x, y, re, im, dn, toStringz(sch), toStringz(opt));
    }

    void STFA(const(mglDataA*) re, const(mglDataA*) im, int dn, string sch = "", string opt = "")
    {
        mgl_stfa(gr, re, im, dn, toStringz(sch), toStringz(opt));
    }

    /// Draw isosurface(s) for 3d data specified parametrically with alpha proportional to b
    void Surf3A(double Val, const(mglDataA*) x, const(mglDataA*) y,
        const(mglDataA*) z, const(mglDataA*) a, const(mglDataA*) b, string stl = "",
        string opt = "")
    {
        mgl_surf3a_xyz_val(gr, Val, x, y, z, a, b, toStringz(stl), toStringz(opt));
    }

    void Surf3A(double Val, const(mglDataA*) a, const(mglDataA*) b, string stl = "",
        string opt = "")
    {
        mgl_surf3a_val(gr, Val, a, b, toStringz(stl), toStringz(opt));
    }

    void Surf3A(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) z,
        const(mglDataA*) a, const(mglDataA*) b, string stl = "", string opt = "")
    {
        mgl_surf3a_xyz(gr, x, y, z, a, b, toStringz(stl), toStringz(opt));
    }

    void Surf3A(const(mglDataA*) a, const(mglDataA*) b, string stl = "", string opt = "")
    {
        mgl_surf3a(gr, a, b, toStringz(stl), toStringz(opt));
    }

    /// Draw isosurface(s) for 3d data specified parametrically with color proportional to b
    void Surf3C(double Val, const(mglDataA*) x, const(mglDataA*) y,
        const(mglDataA*) z, const(mglDataA*) a, const(mglDataA*) b, string stl = "",
        string opt = "")
    {
        mgl_surf3c_xyz_val(gr, Val, x, y, z, a, b, toStringz(stl), opt);
    }

    void Surf3C(double Val, const(mglDataA*) a, const(mglDataA*) b, string stl = "",
        string opt = "")
    {
        mgl_surf3c_val(gr, Val, a, b, toStringz(stl), toStringz(opt));
    }

    void Surf3C(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) z,
        const(mglDataA*) a, const(mglDataA*) b, string stl = "", string opt = "")
    {
        mgl_surf3c_xyz(gr, x, y, z, a, b, toStringz(stl), toStringz(opt));
    }

    void Surf3C(const(mglDataA*) a, const(mglDataA*) b, string stl = "", string opt = "")
    {
        mgl_surf3c(gr, a, b, toStringz(stl), toStringz(opt));
    }

    /// Plot dew drops for vector field {ax,ay} parametrically depended on coordinate {x,y}
    void Dew(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) ax,
        const(mglDataA*) ay, string sch = "", string opt = "")
    {
        mgl_dew_xy(gr, x, y, ax, ay, toStringz(sch), toStringz(opt));
    }

    void Dew(const(mglDataA*) ax, const(mglDataA*) ay, string sch = "", string opt = "")
    {
        mgl_dew_2d(gr, ax, ay, toStringz(sch), toStringz(opt));
    }

    /// Plot vectors at position {x,y,z} along {ax,ay,az} with length/color proportional to |a|
    void Traj(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) ax,
        const(mglDataA*) ay, string sch = "", string opt = "")
    {
        mgl_traj_xy(gr, x, y, ax, ay, toStringz(sch), toStringz(opt));
    }

    void Traj(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) z,
        const(mglDataA*) ax, const(mglDataA*) ay, const(mglDataA*) az,
        string sch = "", string opt = "")
    {
        mgl_traj_xyz(gr, x, y, z, ax, ay, az, toStringz(sch), toStringz(opt));
    }

    /// Plot vector field {ax,ay,az} parametrically depended on coordinate {x,y,z} with length/color proportional to |a|
    void Vect(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) ax,
        const(mglDataA*) ay, string sch = "", string opt = "")
    {
        mgl_vect_xy(gr, x, y, ax, ay, toStringz(sch), toStringz(opt));
    }

    void Vect(const(mglDataA*) ax, const(mglDataA*) ay, string sch = "", string opt = "")
    {
        mgl_vect_2d(gr, ax, ay, toStringz(sch), toStringz(opt));
    }

    void Vect(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) z,
        const(mglDataA*) ax, const(mglDataA*) ay, const(mglDataA*) az,
        string sch = "", string opt = "")
    {
        mgl_vect_xyz(gr, x, y, z, ax, ay, az, toStringz(sch), toStringz(opt));
    }

    void Vect(const(mglDataA*) ax, const(mglDataA*) ay, const(mglDataA*) az,
        string sch = "", string opt = "")
    {
        mgl_vect_3d(gr, ax, ay, az, toStringz(sch), toStringz(opt));
    }

    /// Draw vector plot at slice for 3d data specified parametrically
    void Vect3(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) z,
        const(mglDataA*) ax, const(mglDataA*) ay, const(mglDataA*) az,
        string stl = "", double sVal = -1, string opt = "")
    {
        mgl_vect3_xyz(gr, x, y, z, ax, ay, az, toStringz(stl), sVal, toStringz(opt));
    }

    void Vect3(const(mglDataA*) ax, const(mglDataA*) ay, const(mglDataA*) az,
        string stl = "", double sVal = -1, string opt = "")
    {
        mgl_vect3(gr, ax, ay, az, toStringz(stl), sVal, toStringz(opt));
    }

    /// Plot flows for vector field {ax,ay,az} parametrically depended on coordinate {x,y,z} with color proportional to |a|
    void Flow(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) ax,
        const(mglDataA*) ay, string sch = "", string opt = "")
    {
        mgl_flow_xy(gr, x, y, ax, ay, toStringz(sch), toStringz(opt));
    }

    void Flow(const(mglDataA*) ax, const(mglDataA*) ay, string sch = "", string opt = "")
    {
        mgl_flow_2d(gr, ax, ay, toStringz(sch), toStringz(opt));
    }

    void Flow(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) z,
        const(mglDataA*) ax, const(mglDataA*) ay, const(mglDataA*) az,
        string sch = "", string opt = "")
    {
        mgl_flow_xyz(gr, x, y, z, ax, ay, az, toStringz(sch), toStringz(opt));
    }

    void Flow(const(mglDataA*) ax, const(mglDataA*) ay, const(mglDataA*) az,
        string sch = "", string opt = "")
    {
        mgl_flow_3d(gr, ax, ay, az, toStringz(sch), toStringz(opt));
    }

    /// Plot flow from point p for vector field {ax,ay,az} parametrically depended on coordinate {x,y,z} with color proportional to |a|
    void FlowP(mglPoint p, const(mglDataA*) x, const(mglDataA*) y,
        const(mglDataA*) ax, const(mglDataA*) ay, string sch = "", string opt = "")
    {
        mgl_flowp_xy(gr, p.x, p.y, p.z, x, y, ax, ay, toStringz(sch), toStringz(opt));
    }

    void FlowP(mglPoint p, const(mglDataA*) ax, const(mglDataA*) ay, string sch = "",
        string opt = "")
    {
        mgl_flowp_2d(gr, p.x, p.y, p.z, ax, ay, toStringz(sch), toStringz(opt));
    }

    void FlowP(mglPoint p, const(mglDataA*) x, const(mglDataA*) y,
        const(mglDataA*) z, const(mglDataA*) ax, const(mglDataA*) ay,
        const(mglDataA*) az, string sch = "", string opt = "")
    {
        mgl_flowp_xyz(gr, p.x, p.y, p.z, x, y, z, ax, ay, az, toStringz(sch), toStringz(opt));
    }

    void FlowP(mglPoint p, const(mglDataA*) ax, const(mglDataA*) ay,
        const(mglDataA*) az, string sch = "", string opt = "")
    {
        mgl_flowp_3d(gr, p.x, p.y, p.z, ax, ay, az, toStringz(sch), toStringz(opt));
    }

    /// Plot flows for gradient of scalar field phi parametrically depended on coordinate {x,y,z}
    void Grad(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) z,
        const(mglDataA*) phi, string sch = "", string opt = "")
    {
        mgl_grad_xyz(gr, x, y, z, phi, sch, opt);
    }

    void Grad(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) phi,
        string sch = "", string opt = "")
    {
        mgl_grad_xy(gr, x, y, phi, sch, opt);
    }

    void Grad(const(mglDataA*) phi, string sch = "", string opt = "")
    {
        mgl_grad(gr, phi, sch, opt);
    }

    /// Plot flow pipes for vector field {ax,ay,az} parametrically depended on coordinate {x,y,z} with color and radius proportional to |a|
    void Pipe(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) ax,
        const(mglDataA*) ay, string sch = "", double r0 = 0.05, string opt = "")
    {
        mgl_pipe_xy(gr, x, y, ax, ay, toStringz(sch), r0, toStringz(opt));
    }

    void Pipe(const(mglDataA*) ax, const(mglDataA*) ay, string sch = "",
        double r0 = 0.05, string opt = "")
    {
        mgl_pipe_2d(gr, ax, ay, toStringz(sch), r0, toStringz(opt));
    }

    void Pipe(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) z,
        const(mglDataA*) ax, const(mglDataA*) ay, const(mglDataA*) az,
        string sch = "", double r0 = 0.05, string opt = "")
    {
        mgl_pipe_xyz(gr, x, y, z, ax, ay, az, toStringz(sch), r0, toStringz(opt));
    }

    void Pipe(const(mglDataA*) ax, const(mglDataA*) ay, const(mglDataA*) az,
        string sch = "", double r0 = 0.05, string opt = "")
    {
        mgl_pipe_3d(gr, ax, ay, az, toStringz(sch), r0, toStringz(opt));
    }

    /// Draw density plot for data at x = sVal
    void DensX(const(mglDataA*) a, string stl = "", double sVal = mglNaN, string opt = "")
    {
        mgl_dens_x(gr, a, toStringz(stl), sVal, toStringz(opt));
    }

    /// Draw density plot for data at y = sVal
    void DensY(const(mglDataA*) a, string stl = "", double sVal = mglNaN, string opt = "")
    {
        mgl_dens_y(gr, a, toStringz(stl), sVal, toStringz(opt));
    }

    /// Draw density plot for data at z = sVal
    void DensZ(const(mglDataA*) a, string stl = "", double sVal = mglNaN, string opt = "")
    {
        mgl_dens_z(gr, a, toStringz(stl), sVal, toStringz(opt));
    }

    /// Draw contour lines for data at x = sVal
    void ContX(const(mglDataA*) a, string stl = "", double sVal = mglNaN, string opt = "")
    {
        mgl_cont_x(gr, a, toStringz(stl), sVal, toStringz(opt));
    }

    void ContX(const(mglDataA*) v, const(mglDataA*) a, string stl = "",
        double sVal = mglNaN, string opt = "")
    {
        mgl_cont_x_val(gr, v, a, toStringz(stl), sVal, toStringz(opt));
    }

    /// Draw contour lines for data at y = sVal
    void ContY(const(mglDataA*) a, string stl = "", double sVal = mglNaN, string opt = "")
    {
        mgl_cont_y(gr, a, toStringz(stl), sVal, toStringz(opt));
    }

    void ContY(const(mglDataA*) v, const(mglDataA*) a, string stl = "",
        double sVal = mglNaN, string opt = "")
    {
        mgl_cont_y_val(gr, v, a, toStringz(stl), sVal, toStringz(opt));
    }

    /// Draw contour lines for data at z = sVal
    void ContZ(const(mglDataA*) a, string stl = "", double sVal = mglNaN, string opt = "")
    {
        mgl_cont_z(gr, a, toStringz(stl), sVal, toStringz(opt));
    }

    void ContZ(const(mglDataA*) v, const(mglDataA*) a, string stl = "",
        double sVal = mglNaN, string opt = "")
    {
        mgl_cont_z_val(gr, v, a, toStringz(stl), sVal, toStringz(opt));
    }

    /// Draw solid contours for data at x = sVal
    void ContFX(const(mglDataA*) a, string stl = "", double sVal = mglNaN, string opt = "")
    {
        mgl_contf_x(gr, a, toStringz(stl), sVal, toStringz(opt));
    }

    void ContFX(const(mglDataA*) v, const(mglDataA*) a, string stl = "",
        double sVal = mglNaN, string opt = "")
    {
        mgl_contf_x_val(gr, v, a, toStringz(stl), sVal, toStringz(opt));
    }

    /// Draw solid contours for data at y = sVal
    void ContFY(const(mglDataA*) a, string stl = "", double sVal = mglNaN, string opt = "")
    {
        mgl_contf_y(gr, a, toStringz(stl), sVal, toStringz(opt));
    }

    void ContFY(const(mglDataA*) v, const(mglDataA*) a, string stl = "",
        double sVal = mglNaN, string opt = "")
    {
        mgl_contf_y_val(gr, v, a, toStringz(stl), sVal, toStringz(opt));
    }

    /// Draw solid contours for data at z = sVal
    void ContFZ(const(mglDataA*) a, string stl = "", double sVal = mglNaN, string opt = "")
    {
        mgl_contf_z(gr, a, toStringz(stl), sVal, toStringz(opt));
    }

    void ContFZ(const(mglDataA*) v, const(mglDataA*) a, string stl = "",
        double sVal = mglNaN, string opt = "")
    {
        mgl_contf_z_val(gr, v, a, toStringz(stl), sVal, toStringz(opt));
    }

    /// Draw curve for formula with x in x-axis range
    void FPlot(string fy, string stl = "", string opt = "")
    {
        mgl_fplot(gr, toStringz(fy), toStringz(stl), toStringz(opt));
    }

    /// Draw curve for formulas parametrically depended on t in range [0,1]
    void FPlot(string fx, string fy, string fz, string stl, string opt = "")
    {
        mgl_fplot_xyz(gr, toStringz(fx), toStringz(fy), toStringz(fz),
            toStringz(stl), toStringz(opt));
    }

    /// Draw surface by formula with x,y in axis range
    void FSurf(string fz, string stl = "", string opt = "")
    {
        mgl_fsurf(gr, toStringz(fz), toStringz(stl), toStringz(opt));
    }

    /// Draw surface by formulas parametrically depended on u,v in range [0,1]
    void FSurf(string fx, string fy, string fz, string stl, string opt = "")
    {
        mgl_fsurf_xyz(gr, toStringz(fx), toStringz(fy), toStringz(fz),
            toStringz(stl), toStringz(opt));
    }

    /// Draw triangle mesh for points in arrays {x,y,z} with specified color c.
    void TriPlot(const(mglDataA*) nums, const(mglDataA*) x, const(mglDataA*) y,
        const(mglDataA*) z, const(mglDataA*) c, string sch = "", string opt = "")
    {
        mgl_triplot_xyzc(gr, nums, x, y, z, c, toStringz(sch), toStringz(opt));
    }

    void TriPlot(const(mglDataA*) nums, const(mglDataA*) x, const(mglDataA*) y,
        const(mglDataA*) z, string sch = "", string opt = "")
    {
        mgl_triplot_xyz(gr, nums, x, y, z, toStringz(sch), toStringz(opt));
    }

    void TriPlot(const(mglDataA*) nums, const(mglDataA*) x, const(mglDataA*) y,
        string sch = "", string opt = "")
    {
        mgl_triplot_xy(gr, nums, x, y, toStringz(sch), toStringz(opt));
    }

    /// Draw quad mesh for points in arrays {x,y,z} with specified color c.
    void QuadPlot(const(mglDataA*) nums, const(mglDataA*) x,
        const(mglDataA*) y, const(mglDataA*) z, const(mglDataA*) c, string sch = "",
        string opt = "")
    {
        mgl_quadplot_xyzc(gr, nums, x, y, z, c, toStringz(sch), toStringz(opt));
    }

    void QuadPlot(const(mglDataA*) nums, const(mglDataA*) x,
        const(mglDataA*) y, const(mglDataA*) z, string sch = "", string opt = "")
    {
        mgl_quadplot_xyz(gr, nums, x, y, z, toStringz(sch), toStringz(opt));
    }

    void QuadPlot(const(mglDataA*) nums, const(mglDataA*) x,
        const(mglDataA*) y, string sch = "", string opt = "")
    {
        mgl_quadplot_xy(gr, nums, x, y, toStringz(sch), toStringz(opt));
    }

    /// Draw contour lines for triangle mesh for points in arrays {x,y,z} with specified color c.
    void TriCont(const(mglDataA*) nums, const(mglDataA*) x, const(mglDataA*) y,
        const(mglDataA*) z, string sch = "", string opt = "")
    {
        mgl_tricont_xyc(gr, nums, x, y, z, toStringz(sch), toStringz(opt));
    }

    void TriContV(const(mglDataA*) v, const(mglDataA*) nums,
        const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) z, string sch = "",
        string opt = "")
    {
        mgl_tricont_xycv(gr, v, nums, x, y, z, toStringz(sch), toStringz(opt));
    }

    void TriCont(const(mglDataA*) nums, const(mglDataA*) x, const(mglDataA*) y,
        const(mglDataA*) z, const(mglDataA*) a, string sch = "", string opt = "")
    {
        mgl_tricont_xyzc(gr, nums, x, y, z, a, toStringz(sch), toStringz(opt));
    }

    void TriContV(const(mglDataA*) v, const(mglDataA*) nums,
        const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) z,
        const(mglDataA*) a, string sch = "", string opt = "")
    {
        mgl_tricont_xyzcv(gr, v, nums, x, y, z, a, toStringz(sch), toStringz(opt));
    }

    void TriCont(const(mglDataA*) v, const(mglDataA*) nums, const(mglDataA*) x,
        const(mglDataA*) y, const(mglDataA*) z, const(mglDataA*) a, string sch = "",
        string opt = "")
    {
        mgl_tricont_xyzcv(gr, v, nums, x, y, z, a, toStringz(sch), toStringz(opt));
    }

    /// Draw contour tubes for triangle mesh for points in arrays {x,y,z} with specified color c.
    void TriContVt(const(mglDataA*) nums, const(mglDataA*) x,
        const(mglDataA*) y, const(mglDataA*) z, string sch = "", string opt = "")
    {
        mgl_tricontv_xyc(gr, nums, x, y, z, toStringz(sch), toStringz(opt));
    }

    void TriContVt(const(mglDataA*) nums, const(mglDataA*) x,
        const(mglDataA*) y, const(mglDataA*) z, const(mglDataA*) a, string sch = "",
        string opt = "")
    {
        mgl_tricontv_xyzc(gr, nums, x, y, z, a, toStringz(sch), toStringz(opt));
    }

    void TriContVt(const(mglDataA*) v, const(mglDataA*) nums,
        const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) z,
        const(mglDataA*) a, string sch = "", string opt = "")
    {
        mgl_tricontv_xyzcv(gr, v, nums, x, y, z, a, toStringz(sch), toStringz(opt));
    }

    /// Draw dots in points {x,y,z}.
    void Dots(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) z,
        string sch = "", string opt = "")
    {
        mgl_dots(gr, x, y, z, toStringz(sch), toStringz(opt));
    }

    /// Draw semitransparent dots in points {x,y,z} with specified alpha a.
    void Dots(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) z,
        const(mglDataA*) a, string sch = "", string opt = "")
    {
        mgl_dots_a(gr, x, y, z, a, toStringz(sch), toStringz(opt));
    }

    /// Draw semitransparent dots in points {x,y,z} with specified color c and alpha a.
    void Dots(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) z,
        const(mglDataA*) c, const(mglDataA*) a, string sch = "", string opt = "")
    {
        mgl_dots_ca(gr, x, y, z, c, a, toStringz(sch), toStringz(opt));
    }

    /// Draw surface reconstructed for points in arrays {x,y,z}.
    void Crust(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) z,
        string sch = "", string opt = "")
    {
        mgl_crust(gr, x, y, z, toStringz(sch), toStringz(opt));
    }

    /// Fit data along x-direction for each data row. Return array with values for found formula.
    mglData Fit(const(mglDataA*) y, string eq, string vars, string opt = "")
    {
        return mglData(-1, mgl_fit_1(gr, y, eq, vars, 0, toStringz(opt)));
    }

    mglData Fit(const(mglDataA*) y, string eq, string vars, mglData* ini, string opt = "")
    {
        return mglData(-1, mgl_fit_1(gr, y, toStringz(eq), toStringz(vars), ini, toStringz(opt)));
    }

    /// Fit data along x-, y-directions for each data slice. Return array with values for found formula.
    mglData Fit2(const(mglDataA*) z, string eq, string vars, string opt = "")
    {
        return mglData(-1, mgl_fit_2(gr, z, toStringz(eq), vars, 0, toStringz(opt)));
    }

    mglData Fit2(const(mglDataA*) z, string eq, string vars, mglData* ini, string opt = "")
    {
        return mglData(-1, mgl_fit_2(gr, z, toStringz(eq), toStringz(vars), ini, toStringz(opt)));
    }

    /// Fit data along along all directions. Return array with values for found formula.
    mglData Fit3(const(mglDataA*) a, string eq, string vars, string opt = "")
    {
        return mglData(-1, mgl_fit_3(gr, a, toStringz(eq), vars, 0, toStringz(opt)));
    }

    mglData Fit3(const(mglDataA*) a, string eq, string vars, mglData* ini, string opt = "")
    {
        return mglData(-1, mgl_fit_3(gr, a, toStringz(eq), toStringz(vars), ini, toStringz(opt)));
    }

    /// Fit data along x-direction for each data row. Return array with values for found formula.
    mglData Fit(const(mglDataA*) x, const(mglDataA*) y, string eq, string vars, string opt = "")
    {
        return mglData(-1, mgl_fit_xy(gr, x, y, toStringz(eq), vars, 0, toStringz(opt)));
    }

    mglData Fit(const(mglDataA*) x, const(mglDataA*) y, string eq, string vars,
        mglData* ini, string opt = "")
    {
        return mglData(-1, mgl_fit_xy(gr, x, y, toStringz(eq),
            toStringz(vars), ini, toStringz(opt)));
    }

    /// Fit data along x-, y-directions for each data slice. Return array with values for found formula.
    mglData Fit(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) z,
        string eq, string vars, string opt = "")
    {
        return mglData(-1, mgl_fit_xyz(gr, x, y, z, toStringz(eq), vars, 0, toStringz(opt)));
    }

    mglData Fit(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) z,
        string eq, string vars, mglData* ini, string opt = "")
    {
        return mglData(-1, mgl_fit_xyz(gr, x, y, z, toStringz(eq),
            toStringz(vars), ini, toStringz(opt)));
    }

    /// Fit data along along all directions. Return array with values for found formula.
    mglData Fit(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) z,
        const(mglDataA*) a, string eq, string vars, string opt = "")
    {
        return mglData(-1, mgl_fit_xyza(gr, x, y, z, a, toStringz(eq), vars, 0, toStringz(opt)));
    }

    mglData Fit(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) z,
        const(mglDataA*) a, string eq, string vars, mglData* ini, string opt = "")
    {
        return mglData(-1, mgl_fit_xyza(gr, x, y, z, a, eq, vars, ini, toStringz(opt)));
    }

    /// Fit data with dispersion s along x-direction for each data row. Return array with values for found formula.
    mglData FitS(const(mglDataA*) y, const(mglDataA*) s, string eq, string vars, string opt = "")
    {
        return mglData(-1, mgl_fit_ys(gr, y, s, toStringz(eq), vars, 0, toStringz(opt)));
    }

    mglData FitS(const(mglDataA*) y, const(mglDataA*) s, string eq, string vars,
        mglData* ini, string opt = "")
    {
        return mglData(-1, mgl_fit_ys(gr, y, s, toStringz(eq),
            toStringz(vars), ini, toStringz(opt)));
    }

    mglData FitS(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) s,
        string eq, string vars, string opt = "")
    {
        return mglData(-1, mgl_fit_xys(gr, x, y, s, toStringz(eq), vars, 0, toStringz(opt)));
    }

    mglData FitS(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) s,
        string eq, string vars, mglData* ini, string opt = "")
    {
        return mglData(-1, mgl_fit_xys(gr, x, y, s, toStringz(eq),
            toStringz(vars), ini, toStringz(opt)));
    }

    /// Fit data with dispersion s along x-, y-directions for each data slice. Return array with values for found formula.
    mglData FitS(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) z,
        const(mglDataA*) s, string eq, string vars, string opt = "")
    {
        return mglData(-1, mgl_fit_xyzs(gr, x, y, z, s, toStringz(eq), vars, 0, toStringz(opt)));
    }

    mglData FitS(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) z,
        const(mglDataA*) s, string eq, string vars, mglData* ini, string opt = "")
    {
        return mglData(-1, mgl_fit_xyzs(gr, x, y, z, s, toStringz(eq),
            toStringz(vars), ini, toStringz(opt)));
    }

    /// Fit data with dispersion s along all directions. Return array with values for found formula.
    mglData FitS(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) z,
        const(mglDataA*) a, const(mglDataA*) s, string eq, string vars, string opt = "")
    {
        return mglData(-1, mgl_fit_xyzas(gr, x, y, z, a, s, toStringz(eq),
            vars, 0, toStringz(opt)));
    }

    mglData FitS(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) z,
        const(mglDataA*) a, const(mglDataA*) s, string eq, string vars,
        mglData* ini, string opt = "")
    {
        return mglData(-1, mgl_fit_xyzas(gr, x, y, z, a, s, toStringz(eq),
            toStringz(vars), ini, toStringz(opt)));
    }

    /// Print fitted last formula (with coefficients)
    void PutsFit(mglPoint p, string prefix = 0, string font = "", double size = -1)
    {
        mgl_puts_fit(gr, p.x, p.y, p.z, prefix, font, size);
    }

    /// Get last fitted formula
    const(char*) GetFit() const
    {
        return mgl_get_fit(gr);
    }

    /// Get chi for last fitted formula
    static mreal GetFitChi()
    {
        return mgl_get_fit_chi();
    }

    /// Solve PDE with x,y,z in range [Min, Max]
    mglData PDE(string ham, const(mglDataA*) ini_re, const(mglDataA*) ini_im,
        double dz = 0.1, double k0 = 100, string opt = "")
    {
        return mglData(-1, mgl_pde_solve(gr, ham, ini_re, ini_im, dz, k0, toStringz(opt)));
    }

    /// Fill data by formula with x,y,z in range [Min, Max]
    void Fill(mglData* u, string eq, string opt = "")
    {
        mgl_data_fill_eq(gr, u, toStringz(eq), 0, 0, toStringz(opt));
    }

    void Fill(mglData* u, string eq, const(mglDataA*) v, string opt = "")
    {
        mgl_data_fill_eq(gr, u, toStringz(eq), v, 0, toStringz(opt));
    }

    void Fill(mglData* u, string eq, const(mglDataA*) v, const(mglDataA*) w, string opt = "")
    {
        mgl_data_fill_eq(gr, u, toStringz(eq), v, w, toStringz(opt));
    }

    /// Fill data by formula with x,y,z in range [Min, Max]
    void Fill(mglDataC* u, string eq, string opt = "")
    {
        mgl_datac_fill_eq(gr, u, toStringz(eq), 0, 0, toStringz(opt));
    }

    void Fill(mglDataC* u, string eq, const(mglDataA*) v, string opt = "")
    {
        mgl_datac_fill_eq(gr, u, toStringz(eq), v, 0, toStringz(opt));
    }

    void Fill(mglDataC* u, string eq, const(mglDataA*) v, const(mglDataA*) w, string opt = "")
    {
        mgl_datac_fill_eq(gr, u, toStringz(eq), v, w, toStringz(opt));
    }

    /// Fill dat by interpolated values of vdat parametrically depended on xdat,ydat,zdat for x,y,z in axis range
    void Refill(mglData* dat, const(mglDataA*) xdat, const(mglDataA*) vdat,
        long sl = -1, string opt = "")
    {
        mgl_data_refill_gr(gr, dat, xdat, 0, 0, vdat, sl, opt);
    }

    void Refill(mglData* dat, const(mglDataA*) xdat, const(mglDataA*) ydat,
        const(mglDataA*) vdat, long sl = -1, string opt = "")
    {
        mgl_data_refill_gr(gr, dat, xdat, ydat, 0, vdat, sl, opt);
    }

    void Refill(mglData* dat, const(mglDataA*) xdat, const(mglDataA*) ydat,
        const(mglDataA*) zdat, const(mglDataA*) vdat, string opt = "")
    {
        mgl_data_refill_gr(gr, dat, xdat, ydat, zdat, vdat, -1, opt);
    }

    /// Set the data by triangulated surface values assuming x,y,z in range [Min, Max]
    void DataGrid(mglData* d, const(mglDataA*) x, const(mglDataA*) y,
        const(mglDataA*) z, string opt = "")
    {
        mgl_data_grid(gr, d, x, y, z, toStringz(opt));
    }

    /// Make histogram (distribution) of data. This function do not plot data.
    mglData Hist(const(mglDataA*) x, const(mglDataA*) a, string opt = "")
    {
        return mglData(-1, mgl_hist_x(gr, x, a, toStringz(opt)));
    }

    mglData Hist(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) a, string opt = "")
    {
        return mglData(-1, mgl_hist_xy(gr, x, y, a, toStringz(opt)));
    }

    mglData Hist(const(mglDataA*) x, const(mglDataA*) y, const(mglDataA*) z,
        const(mglDataA*) a, string opt = "")
    {
        return mglData(-1, mgl_hist_xyz(gr, x, y, z, a, toStringz(opt)));
    }

    void Compression(bool)
    {
    }
 // NOTE: Add later -- IDTF
    /// Set the preference for vertex color on/off (for formats that support it, now only PRC does).
    void VertexColor(bool enable)
    {
        mgl_set_flag(gr, enable ? -1 : 0, MGL_PREFERVC);
    }

    /// Render only front side of surfaces for dubugging purposes (for formats that support it, now only PRC does).
    void DoubleSided(bool enable)
    {
        mgl_set_flag(gr, (!enable) ? -1 : 0, MGL_ONESIDED);
    }
    //	void TextureColor(bool){}	// NOTE: Add later -- IDTF
};
//-----------------------------------------------------------------------------
/// Wrapper class for MGL parsing
class mglParse
{
    HMPR pr;
    this(HMPR p)
    {
        pr = p;
        mgl_use_parser(pr, 1);
    }
    this(mglParse* p)
    {
        pr = p.pr;
        mgl_use_parser(pr, 1);
    }
    this(bool setsize = false)
    {
        pr = mgl_create_parser();
        mgl_parser_allow_setsize(pr, setsize);
    }
    ~this()
    {
        //#pragma omp critical
        if (mgl_use_parser(pr,  - 1) < 1)
            mgl_delete_parser(pr);
    }
    /// Get pointer to internal mglParser object
    HMPR Self()
    {
        return pr;
    }

    /// Parse and draw single line of the MGL script
    int Parse(mglGraph* gr, string str, int pos)
    {
        return mgl_parse_line(gr.Self(), pr, toStringz(str), pos);
    }

    //int Parse(mglGraph *gr, const wchar_t *str, int pos)
    //{	return mgl_parse_linew(gr.Self(), pr, str, pos);	}
    /// Execute MGL script text with '\n' separated lines
    void Execute(mglGraph* gr, string str)
    {
        mgl_parse_text(gr.Self(), pr, toStringz(str));
    }

    //void Execute(mglGraph *gr, const wchar_t *str)
    //{	mgl_parse_textw(gr.Self(), pr, str);	}
    /// Execute and draw script from the file
    void Execute(mglGraph* gr, FILE* fp, bool print = false)
    {
        mgl_parse_file(gr.Self(), pr, fp, print ? -1 : 0);
    }

    /// Return type of command: 0 - not found, 1 - other data plot, 2 - func plot,
    ///		3 - setup, 4 - data handle, 5 - data create, 6 - subplot, 7 - program
    ///		8 - 1d plot, 9 - 2d plot, 10 - 3d plot, 11 - dd plot, 12 - vector plot
    ///		13 - axis, 14 - primitives, 15 - axis setup, 16 - text/legend, 17 - data transform
    int CmdType(string name)
    {
        return mgl_parser_cmd_type(pr, toStringz(name));
    }

    /// Return string of command format (command name and its argument[s])
    string CmdFormat(string name)
    {
        return ZtoString(mgl_parser_cmd_frmt(pr, toStringz(name)));
    }

    /// Return description of MGL command
    string CmdDesc(string name)
    {
        return ZtoString(mgl_parser_cmd_desc(pr, toStringz(name)));
    }

    /// Get name of command with nmber n
    string GetCmdName(long n)
    {
        return ZtoString(mgl_parser_cmd_name(pr, n));
    }

    /// Get number of defined commands
    long GetCmdNum()
    {
        return mgl_parser_cmd_num(pr);
    }

    /// Load new commands from external dynamic Library (must have "const mglCommand *mgl_cmd_extra" variable)
    void LoadDLL(string fname)
    {
        mgl_parser_load(pr, toStringz(fname));
    }

    /// Set value for parameter $N
    void AddParam(int id, string str)
    {
        mgl_parser_add_param(pr, id, toStringz(str));
    }

    //void AddParam(int id, const wchar_t *str)
    //{	mgl_parser_add_paramw(pr, id, str);	}
    /// Restore once flag
    void RestoreOnce()
    {
        mgl_parser_restore_once(pr);
    }

    /// Allow changing size of the picture
    void AllowSetSize(bool allow)
    {
        mgl_parser_allow_setsize(pr, allow ?  - 1 : 0);
    }

    /// Allow reading/saving files
    void AllowFileIO(bool allow)
    {
        mgl_parser_allow_file_io(pr, allow ? -1 : 0);
    }

    /// Allow loading commands from external libraries
    void AllowDllCall(bool allow)
    {
        mgl_parser_allow_dll_call(pr, allow);
    }

    /// Set flag to stop script parsing
    void Stop()
    {
        mgl_parser_stop(pr);
    }

    /// Return result of formula evaluation
    mglData Calc(string formula)
    {
        return mglData(-1, mgl_parser_calc(pr, toStringz(formula)));
    }

    //mglData Calc(const wchar_t *formula)
    //{	return mglData(-1,mgl_parser_calcw(pr,formula));	}

    /// Find variable with given name or add a new one
    /// NOTE !!! You must not delete obtained data arrays !!!
    mglData* AddVar(string name)
    {
        return mgl_parser_add_var(pr, toStringz(name));
    }

    //mglData *AddVar(const wchar_t *name)
    //{	return mgl_parser_add_varw(pr, toStringz(name));	}
    /// Find variable with given name or return null if no one
    /// NOTE !!! You must not delete obtained data arrays !!!
    mglDataA* FindVar(string name)
    {
        return mgl_parser_find_var(pr, toStringz(name));
    }

    //mglDataA *FindVar(const wchar_t *name)
    //{	return mgl_parser_find_varw(pr, toStringz(name));	}
    /// Get variable with given id. Can be null for temporary ones.
    /// NOTE !!! You must not delete obtained data arrays !!!
    mglDataA* GetVar(ulong id)
    {
        return mgl_parser_get_var(pr, id);
    }

    /// Get number of variables
    long GetNumVar()
    {
        return mgl_parser_num_var(pr);
    }

    /// Delete variable with name

    void DeleteVar(string name)
    {
        mgl_parser_del_var(pr, toStringz(name));
    }

    //void DeleteVar(const wchar_t *name)	{	mgl_parser_del_varw(pr, toStringz(name));		}

    /// Delete all data variables
    void DeleteAll()
    {
        mgl_parser_del_all(pr);

    }
};
