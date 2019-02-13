Hello again :)

Like the title says, here's a FW *5.0.x* - *5.4.4.2* JailBreak!

The payload is based on yifanlu's jailbreak : http://yifan.lu/p/kindle-touch-jailbreak/, with a few tweaks to make it more Touch/PaperWhite centric,
and a fantastic new delivery method discovered by yossarian17 : http://www.mobileread.com/forums/showthread.php?t=227532. So, as always, thanks to everyone involved in Touch & PaperWhite hacking, particularly yifanlu, ixtab, geekmaster, eureka & yossarian17 ;).

In addition, this is also the home of the K5 (Touch/PaperWhite) port of the USBNetwork : http://www.mobileread.com/forums/showthread.php?t=88004 hack ;).

*What Does It Do?:*

The JailBreak, while fairly unintrusive itself, opens the door to pretty much everything you'll find on this forum ;).

As for USBNetwork, besides bundling a couple of useful tools, it will grant you remote shell access to your Kindle, be it over USB or WiFi.



*Latest Updates (08/19/2015):*

JailBreak v1.14.N (Rescued by a Wizard!), USBNetwork v0.21.N (Updated binaries, ship some more tools).




*IMPORTANT NOTICE REGARDING JAILBREAK UPDATES:*

What you should know about how best to proceed to update the JailBreak itself:

    * The bridge (the _Update_jailbreak_bridge_*_install.bin_ update package in the JailBreak archive, see the relevant section in #2 : http://www.mobileread.com/forums/showpost.php?p=2169820&postcount=2 for more historical details) exists solely as a means to deploy the jailbreak in circumstances where the current jailbreak method is unusable, but custom packages are still usable. That usually means previously jailbroken devices running a FW version unsupported by the current jailbreak method. As such, it can always be used to upgrade your currently installed jailbreak ;).
    * On the other hand, on FW versions the jailbreak method handles, simply reinstalling the JailBreak will do the trick just fine too, and in a faster manner, since you won't need to suffer through a reboot.
    * Additionally, be aware that a reset to factory defaults _will_ break certain key aspects of the JailBreak, so make sure to re-apply the JailBreak (by following the very instructions in this notice) if you've reset your device to factory defaults (if you're unsure of that fact: better be safe than sorry ;)). This can get a bit more complex on FW >= 5.6.1: take particular notice of the changes introduced in v1.14.N to get an idea of how to proceed in this particular case.


That could be summed up as such: if you're currently running FW *5.0.x* to *5.4.4.2*: reinstall the JB. Or if you're running FW >= *5.4.5*: install the bridge.




*IMPORTANT notice to FW >= 5.4.5 users:*

This will *NOT* work on FW >= 5.4.5! That of course implies that you currently *cannot* jailbreak a vanilla KT2/KV/PW3 using this method.

Currently, it does survive an *update* to >= 5.4.5 though, provided your JailBreak is up to date (see the update notice earlier in this post. Take particular notice of the comment about factory resets).

If you intend to update to FW >= 5.4.5, make sure your JailBreak is up to date first.

If your *PW2* shipped on a FW version >= 5.4.5 but < 5.5.0, all is not lost, you should be able to downgrade to 5.4.3.2 : http://www.mobileread.com/forums/showpost.php?p=2881362&postcount=12 with a bit of trickery.




*EVEN MORE IMPORTANT notice regarding FW >= 5.6.0:*

As with the previous notice, the JailBreak obviously won't work on these new versions.

That said, it _does_ survive an _update_ to >= 5.6.0, *provided* your JailBreak is up to date (see the update notice earlier in this post. Take particular notice of the comment about factory resets).

Do note that running FW >= 5.6.x implies a number of restrictions, though: you will *NOT* be able to (easily) downgrade your device once 5.6.x has been installed (even on devices where this was previously possible), and, more importantly, you will *NOT* be able to install custom update packages through usual means, no matter the state of your JailBreak. Fortunately, the MR Package Installer : http://www.mobileread.com/forums/showthread.php?t=251143 _will_ help with that last fact ;).
Moreover, this FW introduces some significant changes which _may_ break some custom code.

*TL;DR*: If you do intend to update, you absolutely *MUST* make sure your JailBreak is up to date *BEFORE* applying the official update! Given that the required changes in the JailBreak are very new, you generally *WILL* have to take action.

*NOTE*: If you had the misfortune of getting a silent OTA update to FW >= 5.6.1 while running an outdated JailBreak, all is not lost, you should be able to get everything back up : http://www.mobileread.com/forums/showpost.php?p=3004892&postcount=1597 without jumping through too many hoops :).

*IMPORTANT*: I have to insist on the fact that *on FW >= 5.5.x*, using MRPI is _REQUIRED_ to install custom packages!




*INSTALL:*

*Jailbreak:*


Download the attached kindle-jailbreak-1.14.N.zip file, and unpack it. In here, you'll find a few files.
Unzip the *contents* of the *kindle-5.4-jailbreak.zip* archive to the root directory of your Kindle.

Now, eject & unplug your Kindle, and go to *[HOME] -> [MENU] > Settings -> [MENU] > Update Your Kindle*. The updater won't actually ever run, this is *normal*. After a few seconds, the words ***** JAILBREAK ***** will appear at the bottom of your screen to confirm that the device is jailbroken ;). You won't see this message again, it's simply a confirmation message.

And that's it, your Kindle is now ready to install custom hacks!

*Since v1.11.N:* If you need to use something MKK : http://www.mobileread.com/forums/showthread.php?t=233932-powered _immediately_, be aware that MKK will only be active on the *next* boot. Installing another package through the Update mechanism will do the trick, or you can manually trigger a device restart (_[HOME] -> [MENU] > Settings -> [MENU] > Restart_).





*FAQs:*

*Q*. Hmm, I have a PW2 (or KT2/KV/PW3), and the *Update Your Kindle* link stays grayed out, how come?

*A*. If you can't find your specific model in the current list of Kindle models : http://wiki.mobileread.com/wiki/Kindle_Serial_Numbers, please reply to this thread with: the exact model of your device (WiFi/3G), the country it was bought in/shipped to, and finally, and most importantly, the first six characters of its serial number (*Settings -> Device Info*).
If you *do* find your model in that list, see the next answer ;).


*Q*. I can't figure out why the *Update Your Kindle* link stays grayed out (bis)?

*A*. First, read the instructions again, and make sure you followed them exactly. A common oversight is to upload the zip file itself, instead of what's *in* the zip file after it's been unpacked ;).
If you think you did that right, don't worry, there's a known (upstream) issue that might cause the OTA updater to crash and fail to pick up new update files. If you still have the jailbreak files on the root of your device, remove them, and make sure you don't have any other .bin files laying around in there.
Restart your device, and try the installation procedure again.
(If this happens for any other hack, and you have a shell access, a *restart otaupd* usually puts things to right).


*Q*. As soon as I eject my device, I get a popup saying _An invalid update file has been loaded on your device_, what's happening?

*A*. You're running FW >= 5.5.x, and, as mentioned in the relevant section of this very post, you will now have to use MRPI : http://www.mobileread.com/forums/showthread.php?t=251143 to install custom packages.
That said, if you were trying to install the JB hotfix, see the first answer ;).


*Q*. My hacks suddenly failed to work properly, how come? (aka. What happens if I get an OTA update?)

*A*. Since FW 5.3.x, official updates (OTA or not, actually) are complete updates, overwriting the complete main system. This has the side effect of breaking a lot of custom hacks. For instance, you'll have to reinstall most full hacks that touch the system, whereas simple KUAL extensions should survive the process ;).
On a sidenote, FW updates are usually a game of cat and mouse, so do make sure you check the forums to see if the hacks you care about will actually *work* on a new FW version before updating ;).


*Q*. What's this 'MKK' (Mobileread Kindlet Kit) thing? Do I need it?

*A*. Good news: it's now bundled with this very JailBreak, so you don't need to install it manually ;). Keep reading if you want to actually know what it's about.
Short answer: you'll need it to run custom Kindlets, like KUAL : http://www.mobileread.com/forums/showthread.php?t=203326 or Collections Manager : http://www.mobileread.com/forums/showthread.php?t=186305. See the MKK : http://www.mobileread.com/forums/showthread.php?t=233932 thread for details ;).


*Q*. What's this 'AcXE' thingy? Do I need it?

*A*. If you intend to run custom ACXs : http://wiki.mobileread.com/wiki/Kindle_Touch_ACX, then, yes, you need it.
Check the dedicated thread : http://www.mobileread.com/forums/showthread.php?t=235859 for more details ;).


*Q*. What's this 'Rescue Pack' thingy? Do I need it?

*A*. If you like having your back covered, and especially if you intend to do any sort of development on your device at all, yes, probably.
Check the dedicated thread : http://www.mobileread.com/forums/showthread.php?t=195670, and its companion : http://www.mobileread.com/forums/showthread.php?t=232507 for more details ;).
And see here : http://www.mobileread.com/forums/showpost.php?p=2882668&postcount=54 for an all-in-one package ;).
For my own spin on these (with minor quality-of-life changes), see my snapshots : http://www.mobileread.com/forums/showthread.php?t=225030 thread.





*ChangeLog:*


**Jailbreak*:

    * *v1.2.N*:
    
        * Works on firmware <= 5.1.2 :).
    
    * *v1.3.N*:
    
        * Minor tweaks for robustness.
    
    * *v1.4.N*:
    
        * Proper PaperWhite support.
    
    * *v1.5.N*:
    
        * A few minor model detection fixes.
    
    * *v1.6.N*:
    
        * Proper support for the UK 3G PW.
    
    * *v1.7.N*:
    
        * Implement a 'bridge' to carry the JailBreak over the 5.3.0 update (following a suggestion from eureka, thanks!). (See the Bridge section)
    
    * *v1.8.N*:
    
        * New delivery mechanism w/ PW2 support, thanks to yossarian17 :).
    
    * *v1.9.N*:
    
        * Smarter FW 5.4.x handling, fix the issues with FW 5.4.4 on the PW1.
    
    * *v1.10.N*:
    
        * Repack.
    
    * *v1.11.N*:
    
        * Bundle MKK with the JB.
        * The bridge will now carry MKK over >= 5.3 updates, in addition to the JB, saving you one package install ;).
    
    * *v1.12.N*:
    
        * Handle the 'new' PW2 variants.
    
    * *v1.13.N*:
    
        * KUAL will now be able to call on everyone's favorite Grey Wizard for assistance against the forces of evil led by FW 5.6.1
        * The bridge will now carry the Rescue Pack & Coward's Rescue Pack over >= 5.3 updates, *provided* you reinstall/update your JB *OR* Bridge *AFTER* installing the RP/CRP, or use my own snapshot copy of them : http://www.mobileread.com/forums/showthread.php?t=225030.
    
    * *v1.14.N*:
    
        * Allow semi-painless and semi-automatic recovery from a factory reset (cf. #1396 : http://www.mobileread.com/forums/showpost.php?p=2989256&postcount=1396 & #1401 : http://www.mobileread.com/forums/showpost.php?p=2989391&postcount=1401).
    

**Doc:* $Id: MR_THREAD 12250 2015-08-18 21:46:10Z NiLuJe $


