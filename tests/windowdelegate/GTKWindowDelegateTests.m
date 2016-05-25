#import "GTKKit.h"
#import "Delegate.h"

int main(int argc, char *argv[])
{
	gtk_init(&argc, &argv);

	GTKWindow *w = [GTKWindow new];
	w.size = of_dimension(300, 200);
	w.onDestroy = ^ () {
		gtk_main_quit();
	};
	[w show];
  
  Delegate *d = [[Delegate alloc] init];
  w.delegate = d;

	gtk_main();

	return 0;
}
