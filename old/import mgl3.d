import mgl;

int main(string[] args)
{
	mglGraph gr;
	gr.Light(true);
	sample(&gr); // The same drawing function.
	gr.WriteEPS("test.eps"); // Don’t forget to save the result!
	return 0;
}