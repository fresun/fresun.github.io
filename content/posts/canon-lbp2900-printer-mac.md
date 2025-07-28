+++
date = '2017-06-09'
title = 'Canon LBP2900 printer in Mac OS'
categories = ['Blog']
tags = ['Computing', 'MacOS']
+++
I had to do this after each big update of MacOS (latest being MacOS Sierra), 
so it is quite annoying. 
However I managed to get the printer working again (its a really good printer btw).

1. Delete the current Canon LBP2900 printer in Printers & Scanners settings
2. Restart your Mac (I didn't do this last time, still worked)
3. Download and install the latest Canon LBP2900 CAPT Printer Driver 
(version 3.90 as of 2017.06.09)
4. Restart your Mac
5. Download and install the Canon LBP2900 Patcher
6. Restart your Mac
7. Connect the printer with USB, add the LBP2900 printer and manually select 
the printer driver

Note: CAPT is Canon's proprietary Canon Advanced Printing Technology (CAPT) driver, 
supporting the Canon i-Sensys series of laser printers.

Note 2: The LBP2900 patcher is a small executable that adds 
printer definitions for the LBP2900 printer. If this is not done the system cannot 
find the suitable printer driver when adding the printer. The LBP2900 printer is not 
supported by the Canon CAPT driver (not sure why) but the very similar printer LBP3000 
is supported, so the patcher adds similar printer definitions as LBP3000 for the LBP2900.

