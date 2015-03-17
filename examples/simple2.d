import mgl;

int sample(HMGL gr, void *)
{
	mgl_rotate(gr,60,40,0);
	mgl_box(gr);
}

int main(string args[])
{
	HMGL gr;
	gr = mgl_create_graph_qt(sample,"MathGL examples",0,0);
	return mgl_qt_run();
	/* generally I should call mgl_delete_graph() here,
	* but I omit it in main() function. */
}
