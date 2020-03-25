#include <dlfcn.h>

%ctor 
{
	NSDictionary *prefs = [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.rheard.RHRevealLoader.plist"];
    
	NSString *libraryPath = @"/Library/Frameworks/RevealServer.framework/RevealServer";
    if ([[prefs objectForKey:[NSString stringWithFormat:@"RHRevealEnabled-%@", [[NSBundle mainBundle] bundleIdentifier]]] boolValue]) 
	{
        if ([[NSFileManager defaultManager] fileExistsAtPath:libraryPath]) 
		{
            void *addr = dlopen([libraryPath UTF8String], RTLD_NOW);
            if (addr) 
			{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"IBARevealRequestStart" object:nil];
                NSLog(@"[RevealLoader]: loaded %@ successful, address %p", libraryPath, addr);
            }
            else 
			{
                NSLog(@"[RevealLoader]: loaded %@ failed, address %p", libraryPath,addr);
            }
        }
    }
}
 