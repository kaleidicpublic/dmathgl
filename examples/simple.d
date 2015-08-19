import mgl;
import std.stdio;

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
	stdout.flush;
	mgl_write_frame(gr,"test.png","");
	writefln("frame written");
	stdout.flush;
	mgl_delete_graph(gr);
	writefln("graph deleted");
	stdout.flush;
	return 0;
}
