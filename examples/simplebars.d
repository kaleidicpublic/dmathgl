import mgl;
import std.stdio;
import std.string:toStringz;
int main()
{
	HMGL gr = mgl_create_graph(600,400);
	if (gr is null)
	{
		writefln("cannot create graph");
		return 0;
	}
	writefln("graph created");
	stdout.flush;
	mgl_fplot(gr,"sin(pi*x)","","");
	writefln("sin plotted");
	sample(gr);
	mgl_write_frame(gr,"test.png","");
	writefln("frame written");
	stdout.flush;
	mgl_delete_graph(gr);
	writefln("graph deleted");
	stdout.flush;
	return 0;
}


int sample(HMGL gr)
{
  auto o=mgl_create_data_size(10,1,1);
  auto h=mgl_create_data_size(10,1,1);
  auto l=mgl_create_data_size(10,1,1);
  auto c=mgl_create_data_size(10,1,1);
  mgl_data_fill_eq(gr,o,"0.5*sin(pi*x)".toStringz,null,null,null);
  mgl_data_fill_eq(gr,c,"0.5*sin(pi*(x+2/9))".toStringz,null,null,null);
  mgl_data_fill_eq(gr,l,"0.3*rnd-0.8".toStringz,null,null,null);
  mgl_data_fill_eq(gr,h,"0.3*rnd+0.5".toStringz,null,null,null);
  mgl_subplot(gr,1,1,0,"");
  mgl_title(gr,"OHLC plot".toStringz,"".toStringz,1.0);
  mgl_box(gr);
  mgl_ohlc(gr,o,h,l,c,"".toStringz,"".toStringz);
  mgl_puts(gr,0.5,0.5,1.0,"hello".toStringz,"rC".toStringz,10.0);
  return 0;
}