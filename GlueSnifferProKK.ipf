#pragma TextEncoding = "UTF-8"
#pragma rtGlobals=3		// Use modern global access method and strict wave access.
#include "Sarfia"
#include "Advanced ROI tools"
#include "Linescan"
#include "matrix"
#include "EventDetectionnew"
#include "parseoutse"
#include "Ch2LineRes"
#include "expDiff"
#include "emGMM"
#include "testGMM_new"
#include "tempPrec"
#include "threshGUI"
#include "timingStuff"
#include "analCon"
#include "infoTheory"
#include "statTests"
#include "lifModel"
#include "gtaAnal"
#include "analFreq"
#include <Peak AutoFind>
#include "popavg2"


///////////////////////////////////////////////////// Glue Sniffer Pro2 Panel /////////////////////////////////////////////////////////

Window gluesnifferpro2() : Panel
	PauseUpdate; Silent 1		// building window...
	NewPanel /K=1 /W=(586,53,1119,725) as "Glue Sniffer Pro 2"
	ModifyPanel cbRGB=(39168,58624,52224)
	SetDrawLayer UserBack
	SetDrawEnv linethick= 0,fillfgc= (26112,45568,65280)
	DrawRRect 16,53,521,212
	SetDrawEnv linethick= 0,fillfgc= (26112,45568,65280)
	DrawRRect 17,221,523,369
	SetDrawEnv linethick= 0,fillfgc= (26112,45568,65280)
	DrawRRect 18,378,524,546
	SetDrawEnv linethick= 0,fillfgc= (26112,45568,65280)
	DrawRRect 20,562,524,659
	DrawRect 22,140,515,174
	DrawRect 22,101,515,135
	SetDrawEnv fsize= 16,fstyle= 1,textrgb= (52428,1,1)
	DrawText 25,35,"WARNING: Before starting, all variables must be toggled by user"
	Button button1b,pos={40.00,64.00},size={172.00,30.00},proc=loadMLDataButt,title="1. Load ML Data"
	Button button1b,font="Helvetica Neue Light",fSize=14,fStyle=1
	Button button1b,fColor=(65280,65280,52224)
	Button button2,pos={320.00,64.00},size={169.00,30.00},proc=splitChannelButt,title="2. Split channels"
	Button button2,font="Helvetica",fSize=14,fStyle=1,fColor=(65280,65280,52224)
	Button button3,pos={133.00,182.00},size={283.00,27.00},proc=MLLineScanButt,title="3. View resampled linescan"
	Button button3,font="Helvetica",fSize=14,fStyle=1,fColor=(65280,65280,52224)
	Button button7,pos={42.00,326.00},size={191.00,32.00},proc=splitInputsAndOutputsButt,title="4. Split Inputs and Outputs"
	Button button7,font="Helvetica",fSize=14,fStyle=1,fColor=(65280,65280,52224)
	Button button8,pos={315.00,326.00},size={188.00,31.00},proc=automaticAZButt,title="5. Define synapses"
	Button button8,font="Helvetica Neue Light",fSize=14,fStyle=1
	Button button8,fColor=(65280,65280,52224)
	Button button9,pos={42.00,465.00},size={187.00,31.00},proc=temporalProfileButt,title="6. Extract synapse activity"
	Button button9,font="Helvetica",fSize=14,fStyle=1,fColor=(65280,65280,52224)
	Button button10,pos={315.00,465.00},size={187.00,31.00},proc=avgSynapseButt,title="7. Average synapse activity"
	Button button10,font="Helvetica",fSize=14,fStyle=1,fColor=(65280,65280,52224)
	Button button11,pos={32.00,514.00},size={170.00,20.00},proc=threshButt,title="Threshold"
	Button button11,font="Helvetica Neue Light",fColor=(65280,65280,52224)
	Button button12,pos={339.00,514.00},size={170.00,20.00},proc=eventDetButt,title="Event Detection"
	Button button12,font="Helvetica Neue Light",fColor=(65280,65280,52224)
	Button button13,pos={339.00,575.00},size={170.00,20.00},proc=clusterButt,title="Cluster"
	Button button13,font="Helvetica Neue Light",fColor=(65280,65280,52224)
	Button button20,pos={32.00,575.00},size={170.00,20.00},proc=contrastAnalButt,title="Contrast"
	Button button20,font="Helvetica Neue Light",fColor=(65280,65280,52224)
	Button button21,pos={32.00,604.00},size={170.00,20.00},proc=LIFButt,title="LIF"
	Button button21,font="Helvetica Neue Light",fColor=(65280,65280,52224)
	Button button22,pos={339.00,604.00},size={170.00,20.00},proc=freqButt,title="Freq"
	Button button22,font="Helvetica Neue Light",fColor=(65280,65280,52224)
	Button button23,pos={339.00,632.00},size={170.00,20.00},proc=GTA,title="GTA"
	Button button23,font="Helvetica Neue Light",fColor=(65280,65280,52224)
	Button button24,pos={32.00,632.00},size={170.00,20.00},proc=IEI,title="IEI"
	Button button24,font="Helvetica Neue Light",fColor=(65280,65280,52224)
	SetVariable minPeakThresh,pos={33.00,229.00},size={220.00,20.00},proc=variableControl,title="Peak inclusion threshold"
	SetVariable minPeakThresh,help={"This value is the fraction of the largest peak.  Use it to reject small peaks or \"noise\"."}
	SetVariable minPeakThresh,fSize=14,limits={-inf,inf,0.01},value= _NUM:0.2
	SetVariable nPointsFit,pos={40.00,429.00},size={422.00,20.00},proc=variableControl,title="Number of points to fit to (more = better, but longer)"
	SetVariable nPointsFit,fSize=14,limits={-inf,inf,10},value= _NUM:250
	SetVariable tauDecay,pos={39.00,392.00},size={225.00,20.00},proc=variableControl,title="Decay time-constant (ms)"
	SetVariable tauDecay,fSize=14,limits={0,inf,5},value= _NUM:60
	SetVariable unitAmp,pos={294.00,392.00},size={216.00,20.00},proc=variableControl,title="Unitary event amplitude"
	SetVariable unitAmp,fSize=14,limits={0,inf,0.02},value= _NUM:0.2
	ValDisplay OriginalFrameRate,pos={30.00,108.00},size={270.00,19.00},title="Original sample frequency (Hz)"
	ValDisplay OriginalFrameRate,fSize=14,limits={0,0,0},barmisc={0,1000}
	ValDisplay OriginalFrameRate,value= #"OriginalFrameRate"
	SetVariable FrameRateDown,pos={312.00,107.00},size={200.00,20.00},proc=variableControl,title="Downsample to (Hz)"
	SetVariable FrameRateDown,fSize=14,limits={100,1000,50},value= _NUM:1000
	ValDisplay OriginalSamplesperFrame,pos={32.00,147.00},size={205.00,19.00},title="Original points per line"
	ValDisplay OriginalSamplesperFrame,fSize=14,limits={0,0,0},barmisc={0,1000}
	ValDisplay OriginalSamplesperFrame,value= #"OriginalSamplesperFrame"
	SetVariable SamplesperFrameDown,pos={250.00,146.00},size={257.00,20.00},proc=variableControl,title="Downsample to (pts per line)"
	SetVariable SamplesperFrameDown,fSize=14,limits={100,5000,50},value= _NUM:1250
	SetVariable tStart,pos={290.00,231.00},size={225.00,20.00},proc=variableControl,title="Start of activity window (s)"
	SetVariable tStart,fSize=14,value= _NUM:42
	SetVariable tEnd,pos={291.00,254.00},size={225.00,20.00},proc=variableControl,title="End of activity window (s)"
	SetVariable tEnd,fSize=14,value= _NUM:48
	SetVariable sepThresh,pos={292.00,277.00},size={224.00,20.00},proc=variableControl,title="Separation threshold (%)"
	SetVariable sepThresh,fSize=14,limits={0,100,1},value= _NUM:10
	CheckBox avgIntensityOrFano,pos={33.00,254.00},size={152.00,17.00},title="Tick for fano profile"
	CheckBox avgIntensityOrFano,fSize=14,variable= avgIntOrFano,side= 1
EndMacro



	

///////////////////////////////////////////////////// Load Movies /////////////////////////////////////////////////////////

Function loadMoviesButt(ba) : ButtonControl
	struct WMButtonAction &ba
	switch(ba.eventCode)
		case 2: 
			variable refNum
			string message = "Select One or More Files"
			string outputPaths
			string fileFilters = "Data Files (*.tif):.tif;"
			fileFilters +="All Files:.*;"
			open /D /R /Mult=1 /F=fileFilters /M=message refNum
			outputPaths = S_fileName
			
			string filenamestr, loadedFilenameStr, FluorFilenameStr, LSFilenameStr, DFFileNameStr
			variable filenameStart
			string pathstr
			variable nChannels=2, stimChannel=2
			if (strlen(outputPaths) == 0)
				print "Cancelled"
			else
				variable numFilesSelected = itemsinlist(outputPaths, "\r")
				variable i
				for(i=0; i<numFilesSelected; i+=1)
					string path = stringfromlist(i, outputPaths, "\r")
					filenameStart = strsearch(path, ":", strlen(path), 1)
					filenamestr=path[filenameStart+1, strlen(path)]
					pathstr=path[0,filenameStart-1]
					AutoLoadScanImage_L(pathstr, filenamestr)
					loadedFilenameStr=filenamestr[0, strlen(filenamestr)-5]   //remove the ".tif" at the end of the filename
				endfor
			endif	
			break
		case -1:
			break
		endswitch
	return 0
end



Function /wave AutoLoadScanImage_L(pathstr, filenamestr)	//Does not open a file dialogue, takes path and filename as input parameters
	string pathstr, filenamestr

	string ImgWaveName, FirstWave
	string header, s_info = "No header info available\r"
	variable PointPos
	
	newpath/o/q path, pathstr
	
	imageload /Q /O /C=-1/p=path filenamestr
	
	if (v_flag == 0)
		abort
	endif
	
		header = s_info
		PointPos = strsearch(S_Filename, ".tif", 0)
		ImgWaveName = S_FileName[0,PointPos-1]
		ImgWaveName = replacestring("-", ImgWaveName, "_")
		
		PointPos = strsearch(S_Wavenames, ";", 0)
		FirstWave =S_Wavenames[0,PointPos-1]
		
	if (waveexists($ImgWaveName))
		killwaves /z $ImgWaveName
	endif
	
	
	duplicate /o $FirstWave, $ImgWaveName
	killwaves /z $FirstWave
	
	redimension /d $ImgWaveName		//convert to double precision floating point
	
	note $ImgWaveName, header
	note $ImgWaveName, "file.path="+s_path
	note $ImgWaveName, "file.name="+s_filename
	
	wave ReturnWv =  $ImgWaveName
	return ReturnWv
end


///////////////////////////////////////////////////// Enter Params ////////////////////////////////////////////////////////
Function enterParamsButt(ba) : ButtonControl
	struct WMButtonAction &ba
	switch(ba.eventCode)
		case 2:
			variable tauRiseTemp, tauTemp, thresholdTemp
			tauRiseTemp = 0.001
			prompt tauRiseTemp, "Enter Tau Rise (s)"
			doprompt "Enter Tau Rise (s)", tauRiseTemp
			tauTemp = 0.06
			prompt tauTemp, "Enter Tau fall (s)"
			doprompt "Enter Tau fall (s)", tauTemp
			variable /G tauRise = tauRiseTemp
			variable /G tauDecay=tauTemp 
			if(V_flag==1)
					Abort
			endif
		case -1: // control being killed
			break
	endswitch
	return 0	
end


///////////////////////////////////////////////////// Split Channels //////////////////////////////////////////////////////
Function splitChannelButt(ba) : ButtonControl
	struct WMButtonAction &ba
	switch(ba.eventCode)
		case 2: 
			string list=wavelist("*_d",";","DIMS:3")
			string movieName
			variable nChannels, stimChannel
			
			prompt movieName, "Wave to split", popup,list
			doprompt "Pick your _data wave", MovieName
			if(V_flag==1)
					abort
			endif
			
			prompt nChannels, "How many channels?"
			doprompt "Choose the number of channels", nChannels
			if(V_flag==1)	
					abort
			endif
			
			prompt stimChannel, "Which channel contains stimulus (1, 2, 3 or 4)?"
			doprompt "Choose the number of channels", stimChannel
			if(V_flag==1)	
					abort
			endif
			
			splitchannels_L(movieName, nChannels, stimChannel)
			print "-----------------  Split Channels   -----------------"
			print "Split " + MovieName + " into " + num2str(nChannels) + " channels. Stimulus from channel " + num2str(stimChannel) + "."
			break
		
		case -1: // control being killed
			break
	endswitch
	return 0	
end

///////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////   SplitChannels_L(wavename, nChannels, stimChannel)   //////////////////////////
///  Produces 2D waves _chnumber and a 1D _stim wave that is the stimulus.  //////////////////////////
///  The chnumber waves are transposed so that the one that contains the F signal looks like the _L wave.
///////////////////////////////////////////////////////////////////////////////////////////////////
Function SplitChannels_L(wavename, nChannels, stimChannel)// split channels
		
	string wavename
	variable nChannels
	variable stimChannel
	variable PixelsperFrame	= dimsize($wavename,0)	//This is a global variable
	variable samplesperFrame = dimsize($wavename,1)
	variable nFrames = dimsize($wavename,2)
	Make/O/N=(pixelsperFrame, nFrames) temp
	Make/O/N=(nFrames) tempStim	
	variable ii

	duplicate/O $wavename PicWave
	string wvName
	
	for(ii=1;ii<=nChannels;ii+=1)
		if(ii!=(stimChannel))
			wvName=nameofwave($wavename)+"_ch" + num2str(ii)
			multithread temp[][]=PicWave[p][ii-1][q]
			MatrixTranspose temp
			duplicate /o temp $wvName
		else
			wvName=nameofwave($wavename)+"_stim"
			multithread tempStim[]=PicWave[PixelsperFrame/2][ii-1][p]
			duplicate /o tempStim $wvName
		endif			
	endfor
	
	killwaves/Z temp, tempStim
	return 0
End
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////// Linescan //////////////////////////////////////////////////////////
Function linescanButt(ba) : ButtonControl
	struct WMButtonAction &ba
	switch(ba.eventCode)
		case 2: 
			string list=wavelist("*_L",";","DIMS:3")
			string name
			prompt name, "wave to analyse", popup,list
			doprompt "pick your movie", name
			
			LSPlot($name)			
			if(V_flag==1)	
					Abort
			endif
		break
		case -1: // control being killed
			break
	endswitch
	return 0
end

/////////////////////////////////////////////// Load & Scale Matlab Data //////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////////////////////
Function loadMLDataButt(ba) : ButtonControl
	struct WMButtonAction &ba
	switch(ba.eventCode)
		case 2:
			print "-----------------  Load MATLAB data   -----------------"
			loadMatAndMetaData()
		break
		case -1: // control being killed
			break
	endswitch
	return 0
end
////////////////////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////////////////////
Function MLLineScanButt(ba) : ButtonControl
	struct WMButtonAction &ba
	switch(ba.eventCode)
		case 2:
			// Choose waves from list to be put throught scaling function 
			string list=wavelist("*_oL",";","DIMS:2")
			string wavename
			prompt wavename, "The original 2D data wave to scale *_oL.  Result in _L", popup,list
			doprompt "Pick your data wave", wavename
			
			// Scale the waves and output pmtData_F and pmtData_L
			LSPlot($wavename)
			print "-----------------  View Linescan   -----------------"			
			break
		case -1: // control being killed
			break
	endswitch
	return 0
end
////////////////////////////////////////////////////////////////////////////////////////////////



/////////////////////////////////////////////// loadAndChangeWaveScalingPMTData(wavename)  /////////////////////////////////////////////////
///  This function is activated by "Matlab LineSscan" button.  It takes the "_data" wave and extracts the Fluorescence time series then plots kymograph 
///  and scales things according to meta data info.  Especially important is creation of the distance_c wave that has the trajectory of the scan.
///  Intensity profiles need to be plotted against distance_c rather than pixel number because beam moves at varying speeds during scan.
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Function loadAndChangeWaveScalingPMTData(wavename)
	string wavename
	
	string/G out_L = (wavename[0, (strlen(wavename)-3)]) + "_oL"
	string/G OriginalDistName =(wavename[0, (strlen(wavename)-3)]) + "_oDist"

	variable/G posCalib = 13.94  //The number of microns per "position unit" of feedback signal measured with 20x objective
	string metadata
			
	//duplicate /O $wavename, $out_F
	//redimension /N=(-1,1,-1) $out_F
	
	//// Plot kymograph.  Also creates the *_L wave at downsampled to framerateDown 
	//LSPlot($out_F)
			
	//// SCALE WAVES
	variable i
	variable/G OriginalframeRate, frameRateDown, PixelsperFrame, fdbkSamplesperFrame  //pixlsperFrame is for position signal
	variable/G OriginalSamplesperFrame, SamplesperFrameDown, samplesPerFrame 			//samplesperFrame is for PMT signal
	//variable experimentDuration
	//variable/G samplesPerFrame
	variable/G nFrames = dimsize($waveName, 2)
	string/G SavedPosname
	
			
	/// EXTRACT FRAMERATE FROM METADATA FILE
	wave /T metadata0
	for (i=0;i<dimsize(metadata0,0);i+=1)
		string metastring = metadata0[i]
		if (stringmatch(metastring,"SI.hRoiManager.scanFrameRate*"))
			string/G OriginalframeRateString = metastring[30,35]
			OriginalframeRate = str2num(OriginalframeRateString)
		endif 
		
		// EXTRACT Pixelsperframe
		if (stringmatch(metastring,"SI.hScan2D.lineScanSamplesPerFrame*"))
			string PixelsperFrameString = metastring[37,40]
			PixelsperFrame = str2num(PixelsperFrameString)
			print "Scanned at " + num2str(OriginalframeRate) + " trajectories per sec with " + num2str(PixelsperFrame) +  " pixels per trajectory."
		endif 
		
		// EXTRACT Position feedback rate from metadata file
		if (stringmatch(metastring,"SI.hScan2D.lineScanFdbkSamplesPerFrame*"))
			string fdbkSamplesperFrameString = metastring[41,43]
			fdbkSamplesperFrame = str2num(fdbkSamplesperFrameString)
		endif 		
	endfor
	
	//wave PosData0
	Make/O/N=(fdbksamplesperFrame) wavex, wavey, dx, dy, distance
	Redimension/N=(2,fdbksamplesperFrame,nFrames) $SavedPosname
	Duplicate/O $SavedPosname PosData0
	
	///  Calculate the distance wave from the PosData0 wave
	wavex[] = PosData0[0][p][5]*posCalib
	wavey[] = PosData0[1][p][5]*posCalib
	
	dx[1,(fdbksamplesperFrame-1)]=wavex[p]-wavex[p-1]
	dx[0]=0
	dy[1,(fdbksamplesperFrame-1)]=wavey[p]-wavey[p-1]
	dy[0]=0
	distance[1, (fdbksamplesperFrame-1)] = distance[p-1] + sqrt(dx[p]^2 + dx[p]^2)
	distance[0]=0
	
	///   Create the "_L" wave that will be used by "Split Inputs and Outputs" button 
	//experimentDuration = dimsize($out_F,2)/originalframeRate
	
	Duplicate/O/R=[][0][] $waveName $out_L		
	SetScale/P y 0, (1/OriginalFramerate),"", $out_L;DelayUpdate
	//SetScale/I y 0,samplesPerFrame,"", $out_L
	Redimension/E=1/N=(-1,(dimsize($wavename, 2))) $out_L
	//Duplicate/O $out_L, $wavename						/// Remember samplesperFrame is a global variable
	
	Duplicate/O distance, $OriginalDistName, distance_c;DelayUpdate
	Interpolate2/T=1/N=(pixelsPerFrame)/Y=$OriginalDistName distance;DelayUpdate  ///  Crucial because the position feedback signal is sampled at lower rate than PMT
	
	variable/G ScanningDurn = nFrames/OriginalFrameRate
	//Interpolate2/T=1/N=(pixelsPerFrame)/Y=distance_c distance
	//Duplicate/O distance_c $WholeDistName
end
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////


//////////////////////////////////////////  loadMatAndMetaData()  //////////////////////////////////////////////////////
///  This function activated by "Load ML Data" button
////////////////////////////////////////////////////////////////////////////////////////////////

Function loadMatAndMetaData()
	
	String/G DataFilename
	String/G SavedDataName
	String/G MetaFilename
	string/G SavedMetaName 
	String/G PosFilename
	string/G SavedPosName 
	
	String cell = "cell"
	String meta = "meta"
	String pos = "pos"
	
	//These globals created here for subsequent use by other functions in workflow
	variable/G minpeak											
	variable/g OriginalsamplesperFrame
	
	mlloadwave/O/M=2/Y=4/S/A=cell		// load as double precision floating point
	Newpath/O DataPath, S_path
	DataFilename = S_fileName
	SavedDataName = DataFileName[0, (strsearch(DataFileName,"mat",0)-2)] + "_d"
	duplicate/O $cell, cellN
	variable maxvalue=wavemax(cellN)			//NB Here the wave is normalized to its maximum value. Having values in range 0->1 seems to help with fitting. 
	cellN/=maxvalue
	duplicate/O cellN, $SavedDataName
	OriginalsamplesperFrame = dimsize($SavedDataName, 0)
	
	MetaFilename = DataFileName[0, (strsearch(DataFileName,"mat",0)-2)] + ".meta.txt"
	SavedMetaName = "metaData"
	loadwave/O/J/K=2/P=DataPath/N=metadata MetaFilename
	SavedMetaName = DataFileName[0, (strsearch(DataFileName,"mat",0)-2)] + "_meta"
	MetaFilename = "metadata0"
	duplicate/O $MetaFilename, $SavedMetaName
	
	PosFilename = DataFileName[0, (strsearch(DataFileName,"mat",0)-2)] + ".scnnr.dat"
	SavedPosName = "posData"
	GBLoadWave/O/B/T={2,2}/P=DataPath/N=PosData/W=1 PosFilename
	SavedPosName = DataFileName[0, (strsearch(DataFileName,"mat",0)-2)] + "_pos"
	PosFilename = "PosData0"
	duplicate/O $PosFilename, $SavedPosName
	
	Killwaves cellN
	loadAndChangeWaveScalingPMTData(SavedDataName)
	duplicate/O $PosFilename, $SavedPosName
end




///////////////////////////////////////////////////// Automatic Define AZs ////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////////////////////
Function automaticAZButt(ba) : ButtonControl
	struct WMButtonAction &ba
	switch(ba.eventCode)
		case 2: 
			print ("*********** Automatic estimate of AZs *************")
			string list= wavelist("*_p",";","DIMS:1") + wavelist("*_p_i",";","DIMS:1") + wavelist("*_p_*_o",";","DIMS:1")
			string wavename
			prompt wavename, "Profile to analyse", popup,list
			doprompt "Pick your Profile", wavename
			
			string/G profileName = wavename
			automaticDefineAZ(profileName)	   	
		break	
		case -1: // control being killed
			break
	endswitch
	return 0
end
////////////////////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////////////////////

Function splitInputsAndOutputsButt(ba) : ButtonControl
	struct WMButtonAction &ba
	switch(ba.eventCode)
		case 2: 
			string list=wavelist("*_L",";","DIMS:2")
			string wavename
			prompt wavename, "Line scan to analyse", popup,list
			doprompt "Pick your Line scan", wavename
			print "-----------------  Split Inputs and Outputs   -----------------"
			splitInputsAndOutputs(wavename)	   	
		break
		case -1: // control being killed
			break
	endswitch
	return 0
end
////////////////////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////   splitInputsAndOutputs(wavename)  ////////////////////////////////////////////////////////
///  Input is 2D linescane wave ending in _L
////////////////////////////////////////////////////////////////////////////////////////////////

Function splitInputsAndOutputs(wavename)
	string wavename
	
	variable autoAbortSecs = 0
	variable/G tStart, tEnd
	
	String/G OriginalDistName //this is a global
	
	string/G wholeProfName=(wavename[0, (strlen(wavename)-3)])+"_p"
	string/G wholeDistName=(wavename[0, (strlen(wavename)-3)])+"_p_d"    
	string/G wholeLName = wholeProfName + "_L"                                                                             
	
	Duplicate/O $OriginalDistName $wholeDistName
	
	//Duplicate/O temp $wholeDistName
	//KillWaves/Z temp
	
	// Downsample distance wave in same way as linescan
	variable/G OriginalSamplesperFrame, SamplesperFrameDown
	//duplicate/O/R=[0,(dimsize($wavename,0))] $DistWaveName  $wholeDistName
	variable/G downfactor = (OriginalSamplesperFrame/SamplesperFrameDown)
	Resample/DOWN=(downfactor)/N=3 $wholeDistName;DelayUpdate
	

	print wavename
	// make the profile for the whole linescan	
	duplicate/O $wavename, $wholeProfName, $wholeLName
	duplicate/O $wavename, w1
	
	///  Use a time period over which there is a lot of activity
	variable/G tStart, tEnd
	variable/G avgIntOrFano
   duplicate/O/R=(tStart, tEnd) $wavename, w1     
   make/O/n=(dimsize(w1,1)) w2, w4
   matrixop/O w2= sumCols(w1)
   w2/=dimsize(w1,0)					//w2 is the mean value
   matrixop/O w4=varCols(w1)
   make/O/N=(dimsize(w2,1)) w3
   w3=w2[0][p]
   variable sm = mean(w3)
   variable sw = wavemin(w3)
   w3-=sw
   variable i
   for (i=0;i<dimsize(w3,0);i+=1)
   
    if (avgIntOrFano==1) // If checkbox for fano profile is ticked, do the fano profile
   		w3[i]=w4[i]/w2[i] //Here w3 is variance/mean (Fano).
   	 if (w3[i]<0)
   			w3[i] = 0
   	 endif
    else
   	 if (w3[i]<0) // If checkbox is not ticked, do the average intensity profile
   			w3[i] = 0
   	endif
    endif
   endfor
   
   
   //variable scaleFactor
   //scaleFactor =100/wavemax(w3)
   //w3*= scaleFactor
      
   duplicate/O w3, $wholeProfName
   
   //Display average profile
   display/K=1/N=Profile $wholeProfName 
   Label left "Intensity";DelayUpdate
	Label bottom "Pixel number" 
	   
   legend/C/N=text0/J/F=0/A=RT "\\f01\\Z14Place A&B cursors around the input \nand C,D,E,F,G,H around the \noutput compartments"
   String win=WinName(0,1)
   showinfo/CP={0,1,2}/W=$win
   AppendToGraph/R=right/T=top $wholeDistName; DelayUpdate
   SetAxis/A/E=1 right
   SetAxis/A/E=1 top
	ModifyGraph lstyle($wholeDistName)=1,rgb($wholeDistName)=(0,0,0)
	
   if (UserCursorAdjust(win,autoAbortSecs)!=0)
   	return -1
   endif
   
   
   ///////////////////
   
   
   string csrResult
   String CursorAJ = "ABCDEFGHIJ"	//Maximum of 10 cursors
   String letter
   variable csrA,csrB,csrC,csrD,csrE,csrF,csrG,csrH,csrI,csrJ
   
   for(i=0; i < 10; i+=1)
   	letter = CursorAJ[i]
   	csrResult=csrinfo($letter,win)
   	if (cmpstr(csrResult,"")!=0)
   		if (cmpstr(letter,"A") == 0)
   			csrA = pcsr(A)
   		endif
   		if (cmpstr(letter,"B") == 0)
   			csrB = pcsr(B)
   		endif
   		if (cmpstr(letter,"C") == 0)
   			csrC = pcsr(C)
   		endif
   		if (cmpstr(letter,"D") == 0)
   			csrD = pcsr(D)
   		endif
   		if (cmpstr(letter,"E") == 0)
   			csrE = pcsr(E)
   		endif
   		if (cmpstr(letter,"F") == 0)
   			csrF = pcsr(F)
   		endif
   		if (cmpstr(letter,"G") == 0)
   			csrG = pcsr(G)
   		endif
   		if (cmpstr(letter,"H") == 0)
   			csrH = pcsr(H)
   		endif
   		if (cmpstr(letter,"I") == 0)
   			csrI = pcsr(I)
   		endif
   		if (cmpstr(letter,"J") == 0)
   			csrJ = pcsr(J)
   		endif
   	endif
   endfor
   
   
   ///////////////////
   
   variable ipStart, ipEnd, op1Start, op1End, op2Start, op2End, op3Start, op3End, op4Start, op4End
   
   
   string/G op1ProfName = (wavename[0, (strlen(wavename)-3)])+"_p_c1_o"
	string/G op1DistName = (wavename[0, (strlen(wavename)-3)])+"_p_c1_o_d"
	string/G op1PointsName = (wavename[0, (strlen(wavename)-3)])+"_p_c1_o_pts"		//  name of wave with 2 elements: start and end points of op selection 
	string/G ipProfName = (wavename[0, (strlen(wavename)-3)])+"_p_i"
	string/G ipDistName = (wavename[0, (strlen(wavename)-3)])+"_p_i_d"
	string/G ipPointsName = (wavename[0, (strlen(wavename)-3)])+"_p_i_pts"		//  name of wave with 2 elements: start and end points of ip selection 
	string/G ipLName = ipProfName +"_L"
	string/G op1LName = op1ProfName +"_L"
	string/G ipLAVG = ipLName +"_avg"
	string/G op1LAVG = op1LName +"_avg"

   ipStart = csrA
   ipEnd = csrB
   op1Start = csrC
   op1End = csrD
  
  	Make/O/N=(2) ipPoints = {ipStart, ipEnd}
  	Duplicate/O ipPoints $ipPointsName
  	
  	Make/O/N=(2) op1Points = {op1Start, op1End}
  	Duplicate/O op1Points $op1PointsName
   
   // Making Input and Output Profiles
   duplicate/O/R=[op1Start,op1End] $wholeProfName $op1ProfName
   duplicate/O/R=[ipStart,ipEnd] $wholeProfName $ipProfName
   duplicate/O/R=[op1Start,op1End] $wholeDistName $op1DistName
   duplicate/O/R=[ipStart,ipEnd] $wholeDistName $ipDistName//, dist_ip
   //duplicate/O distance_c $wholeDistName
   
   // Making separate _L waves from input and output (for temporal profile)
   duplicate/O $wavename $op1LName
   duplicate/O $wavename $ipLName
   Duplicate/O/RMD=[][op1End, op1Start] $wavename $op1LName
   Duplicate/O/RMD=[][ipEnd, ipStart] $wavename $ipLName
   popavg2($op1LName)
   popavg2($ipLName)
   BaseCorrection(ipLAVG)
   DeltaFWindow(ipLAVG,1,2)
   newWiener(ipLAVG)
   BaseCorrection(op1LAVG)
   DeltaFWindow(op1LAVG,1,2)
   newWiener(op1LAVG)
   Duplicate/O $wavename $wholeLName
   
   
   ///// if there's more than 1 output compartments 
   
   if (csrE != 0 && csrF != 0)
   	string/G op2ProfName = (wavename[0, (strlen(wavename)-3)])+"_p_c2_o"
		string/G op2DistName = (wavename[0, (strlen(wavename)-3)])+"_p_c2_o_d"
		string/G op2PointsName = (wavename[0, (strlen(wavename)-3)])+"_p_c2_o_pts"
   	string/G op2LName = op2ProfName +"_L"
   	string/G op2LAVG = op2LName +"_avg"
   	op2Start = csrE
   	op2End = csrF
   	Make/O/N=(2) op2Points = {op2Start, op2End}
  		Duplicate/O op2Points $op2PointsName
  		duplicate/O/R=[op2Start,op2End] $wholeProfName $op2ProfName
  		duplicate/O/R=[op2Start,op2End] $wholeDistName $op2DistName
   	duplicate/O $wavename $op2LName
   	Duplicate/O/RMD=[][op2End, op2Start] $wavename $op2LName
   	popavg2($op2LName)
   	BaseCorrection(op2LAVG)
   	DeltaFWindow(op2LAVG,1,2)
   	newWiener(op2LAVG)
   endif
   
   if (csrG != 0 && csrH != 0)
   	string/G op3ProfName = (wavename[0, (strlen(wavename)-3)])+"_p_c3_o"
		string/G op3DistName = (wavename[0, (strlen(wavename)-3)])+"_p_c3_o_d"
		string/G op3PointsName = (wavename[0, (strlen(wavename)-3)])+"_p_c3_o_pts"
   	string/G op3LName = op3ProfName +"_L"
   	string/G op3LAVG = op3LName +"_avg"
   	op3Start = csrG
   	op3End = csrH
   	Make/O/N=(2) op3Points = {op3Start, op3End}
  		Duplicate/O op3Points $op3PointsName
  		duplicate/O/R=[op3Start,op3End] $wholeProfName $op3ProfName
  		duplicate/O/R=[op3Start,op3End] $wholeDistName $op3DistName
   	duplicate/O $wavename $op3LName
   	Duplicate/O/RMD=[][op3End, op3Start] $wavename $op3LName
   	popavg2($op3LName)
   	BaseCorrection(op3LAVG)
   	DeltaFWindow(op3LAVG,1,2)
   	newWiener(op3LAVG)
   endif
   
   if (csrI != 0 && csrJ != 0)
   	string/G op4ProfName = (wavename[0, (strlen(wavename)-3)])+"_p_c4_o"
		string/G op4DistName = (wavename[0, (strlen(wavename)-3)])+"_p_c4_o_d"
		string/G op4PointsName = (wavename[0, (strlen(wavename)-3)])+"_p_c4_o_pts"
   	string/G op4LName = op4ProfName +"_L"
   	string/G op4LAVG = op4LName +"_avg"
   	op4Start = csrI
   	op4End = csrJ
   	Make/O/N=(2) op4Points = {op4Start, op4End}
  		Duplicate/O op4Points $op4PointsName
  		duplicate/O/R=[op4Start,op4End] $wholeProfName $op4ProfName
  		duplicate/O/R=[op4Start,op4End] $wholeDistName $op4DistName
   	duplicate/O $wavename $op4LName
   	Duplicate/O/RMD=[][op4End, op4Start] $wavename $op4LName
   	popavg2($op4LName)
   	BaseCorrection(op4LAVG)
   	DeltaFWindow(op4LAVG,1,2)
   	newWiener(op4LAVG)
   endif 
   
   killwindow $win
   //killwaves w1, w2, w3
   
end
////////////////////////////////////////////////////////////////////////////////////////////////




/////////////////////////////////////////////  automaticDefineAZ(wavename)  ///////////////////////////////////////////////////
///   Input is name of wave that ends in _p, or _p_i, or _p_o 
///	Output of this function are chunks of the profile --> each chunk has waves: 
///   profile: _(numberOfChunk)
///	linescan:  _(numberOfChunk)_L 
///	distance wave: _(numberOfChunk)_d 
///	coefficient wave with initial guessed for gaissian fit: _(numberOfChunk)_coef

Function automaticDefineAZ(wavename)
	string wavename
	print wavename
	
	wave distance_c	
	variable/G minDistance = 0.2  //In microns: between peaks 
	variable/G minpeak //= minPeakThresh //0.2//as fraction of maximum in profile
	variable/G nPointsforfitting		//Not used here, but must be created before "temporalprofile" can run
	
	//Variable minPeakThresh
	variable/G maxDistanceShift = 0.7
	
	 //microns: for replacing third deriv zero crossings with nearby maxima
		
	variable i, j
	string/G out_Xvals = wavename+"_Xvals"
	string/G out_Yvals = wavename + "_avgAmp"
	string first_dif = wavename+"_dif1"
	string second_dif = wavename+"_dif2"	
	string third_dif = wavename+"_dif3"	
	string distWaveName = wavename + "_d"
	string/G FanoWaveName = wavename + "_Fano"
	string/G fitWaveName 
	
	//////////////////////////////////////////////////////////////
	// FIX FOR WONKY PROFILES
	CurveFit/q/l=(dimsize($distWaveName, 0)) line $distWaveName /D 
	
	redimension/s $("fit_"+distWaveName)
	Duplicate/O $("fit_"+distWaveName) distance_c
	// TO REMOVE, REMOVE ALL THIS AND UNCOMMENT THE NEXT LINE:
	///////////////////////////////////////////////////////////////
	//Duplicate/O $distWaveName distance_c
	
	variable autoAbortSecs = 0
	
	string wavein_smth=(wavename[0, (strlen(wavename)-9)])+"_p_smth"
	string out=(wavename[0, (strlen(wavename)-9)])+"_profile"
	string fitName =waveName+"_fit"
	
	// zero the profile
	duplicate/O $wavename, profile
	variable nPts = dimsize(profile,0)
	Smooth/S=2 21, profile
	//Make/N=50/O profile_Hist;DelayUpdate
	//Histogram/B=1 profile,profile_Hist;DelayUpdate
	//WaveStats/Q profile_Hist
	//profile -= V_maxLoc
	Duplicate/O profile, $FanoWaveName
		 
   // using first derivative to find peaks of profile ($out) 
   duplicate/O profile, $wavein_smth
	Smooth/S=2 17, $wavein_smth;DelayUpdate		//NB $out is now SMOOTHED
   differentiate $wavein_smth/X=distance_c/D=$first_dif;delayupdate
   
   //  Smooth first deriv before differentiating again
   duplicate/O $first_dif, out_dif2smth
	Smooth/S=2 19, out_dif2smth;DelayUpdate
   differentiate out_dif2smth/X=distance_c/D=$second_dif;delayupdate
   
   //   Smooth second deriv before differentiating again
   duplicate/O $second_dif, out_dif3smth
	Smooth/S=2 21, out_dif3smth;DelayUpdate
   differentiate out_dif3smth/X=distance_c/D=$third_dif;delayupdate  
   
	//   Find zero crossings for first, second and third derivatives
   FindLevels/Q/P/B=3/EDGE=2/M=(minDistance) /D=maxima/Q $first_dif, 0    			// Crossings going DOWN. NB using point numbers for levels, not x values
   FindLevels/Q/P/B=3/EDGE=0/M=(minDistance) /D=inflexions/P/Q $second_dif, 0		// Crossings going DOWN or UP.
   FindLevels/Q/P/B=3/EDGE=1/M=(minDistance) /D=thirdDifZeros/P/Q $third_dif, 0  //look for zero crossings going upward
  	
  	/// Now only keep zero crossing in third deriv if second deriv is <0
  	Make/O/N=(0) temp
  	j=0 	
  	Duplicate/O $second_dif, second_deriv
  	for(i=0; i< V_levelsFound; i+=1)
  		if( (thirdDifZeros[i] < numpnts(second_deriv)) && second_deriv[thirdDifZeros[i]] < 0) 
  			InsertPoints/V=(thirdDifZeros[i]) j, 1, temp
  			j+=1
  		endif
  	endfor
 
 	for(i=1; i< dimsize(temp,0); i+=1)
  	 	if(abs(distance_c[temp[i]]-distance_c[temp[i-1]]) < maxDistanceShift)
  			DeletePoints i, 1, temp
  			i-=1
  		elseif(abs(distance_c[temp[i-1]]-distance_c[temp[i]]) < maxDistanceShift)
  			DeletePoints i-1, 1, temp
  			i-=1
  		endif
  	endfor
	
	Concatenate/O/NP {maxima, temp}, thirdDifZeros
  	Sort thirdDifZeros, thirdDifZeros
  	
	///  Tidy up and order the Xvals wave containing the locations of the peaks
	Duplicate/O thirdDifZeros, Xvals
	Xvals[]=distance_c[thirdDifZeros[p]]

	// map peaks found in the second derivative onto the AZ profile
	make/O/I/N=0 Yvals
	variable tempYval
   for(j = 0; j < DimSize(Xvals, 0); j += 1)
   	FindLevel/Q/EDGE=1/P distance_c, (Xvals[j]) 
   	tempYval = profile[V_LevelX]
   	InsertPoints /V=(tempYval) j, 1, Yvals
   	Yvals[j]=tempYval
    endfor
    Duplicate/O Yvals, $out_Yvals
   
  //Remove peaks below level minpeak*wavemax(profile)   
   Make/O/N=(0) newXvals, newYvals
   variable count = 0
   for(i=0; i<dimsize(Xvals,0); i+=1)
   	FindLevel/Q/EDGE=1/P distance_c, (Xvals[i]) 
   	if(profile[V_LevelX]> (minpeak*wavemax(profile)))
   		InsertPoints /V=(Xvals[i]) i, 1, newXvals
   		InsertPoints /V=(profile[V_LevelX]) i, 1, newYvals
  			count+=1
  		endif
   endfor  
   
   // delete points too close together in newXval and newYvals
  	for(i=1; i< dimsize(newXvals,0); i+=1) 
  		print (num2str(newXvals[i]-newXvals[i-1]))
  	 	if( ((newXvals[i]-newXvals[i-1]) < maxDistanceShift) && (newYvals[i] >  newYvals[i-1]) )
  			DeletePoints (i-1), 1, newXvals, newYvals
  			i-=1
  		elseif( ((newXvals[i]-newXvals[i-1]) < maxDistanceShift) && (newYvals[i] <  newYvals[i-1]) )
  			DeletePoints (i), 1, newXvals, newYvals
  			i-=1
  		endif
  	endfor
  	
   Duplicate/O newYvals, $out_Yvals
   Duplicate/O newXvals, $out_Xvals
   
	// defining amplitudes and means of gaussians	
	variable nPeaks = dimsize(newXvals,0)	
	
	// Get rid of any existing window for finding AZs
	String list = WinList("findAZs*", ";", "WIN:1")
	if(StringMatch(list, "findAZs") ==1)
		KillWindow/Z findAZs
	endif
	
	// Display intensity profile along line	and the estimates of the locations where there are signals  
	display/I/W=(0,0,15,5)/k=1/N=findAZs $FanoWaveName vs $("fit_"+distWaveName); PauseUpdate
	SetAxis/A 
   appendtograph $out_Yvals vs newXvals
   modifygraph rgb($out_Yvals)=(0,0,65535), mode($out_Yvals)=3, marker($out_Yvals)=19
   label left "Intensity or Fano"
	Label bottom "Distance along scan (\\F'SymbolPi'm\\F'Helvetica'm)";delayupdate
   legend/C/N=text0/J/F=0/A=RT "\\f01\\Z14Remove \"peaks\" with cursors then click continue in other window"
   showinfo/CP={0,1,2, 3, 4}
   
   /////////// Remove peaks by eye ///////////
   if (UserCursorAdjust("findAZs",autoAbortSecs)!=0)
   	return -1
   endif
   
   string csrResult
   String CursorAJ = "ABCDEFGHIJ"	//Maximum of 10 cursors
   String letter
   
   for(i=0; i < 10; i+=1)
   	letter = CursorAJ[i]
   	csrResult=csrinfo($letter,"findAZs")
   	if (cmpstr(csrResult,"")!=0)
   		FindValue/V=(newYvals(pcsr($letter))) $out_Yvals
   		DeletePoints V_value, 1, $out_Yvals, $out_Xvals  //1, $out_Yvals, $out_Xvals
   		//DeletePoints pcsr($letter), 1, newYvals, newXvals, $out_Yvals, $out_Xvals
   	endif
   endfor
   Duplicate/O $distWaveName distance_c
	
   //Duplicate/O newYvals, $out_Yvals
   //Duplicate/O newXvals, $out_Xvals
   Duplicate/O $out_Yvals, newYvals
   Duplicate/O $out_Xvals, newXvals
   
   //variable nGauss = dimsize($out_Xvals,0)
   variable nGauss = dimsize(newXvals,0)
	print "Number of Gaussians to fit = " + num2str(nGauss) + ": only using peaks > " + num2str(minpeak*100) + "% of highest"
	
	
	//////////////////////////////////
	//fitGausses(wavename, out_Xvals, out_Yvals)
	fitGausses(FanoWaveName, out_Xvals, out_Yvals)
	//fitGauss(FanoWaveName, out_Xvals, out_Yvals)
	//////////////////////////////////
	
	/////////////// separating synapses which need demixing and which don't ///////////////////
	
	SVAR coefWaveName = root:coefWaveName
	WAVE CoefsTemp
	WAVE fanoFit = $wavename+"_Fano_fit"
	string/G fanoWave = wavename+"_Fano"
	string/G fanoFit_DIF = wavename+"_Fano_fit_DIF"
	string/G fanoWave_DIF = wavename+"_Fano_DIF"
	string/G distance = "fit_"+wavename+"_d"
	string/G linescan = wavename+"_L"
	string/G synapse_numOfAZ = wavename+"_numOfAZ"
	string/G potentialChoppingPointsWODup
	variable/G sepThresh
	variable/G wavestart, waveend, wavepts
	variable loopLength = dimsize($coefWaveName,0)/3
	variable loopLength2
	variable waveCounter = 0
	
	if (loopLength==1)

		string/G synapse = wavename+"_0"
		Duplicate/O $fanoWave $synapse
		waveCounter += 1
		
		//make coef wave
		string/G synapse_coef = synapse+"_coef"
		Duplicate/O CoefsTemp $synapse_coef
		
		//make distance wave
		killwaves/z $wavename+"_0_d"
		WAVE synapse_d = $wavename+"_0_d"
		Duplicate/O $distance synapse_d
		
		//make linescan
		string/G synapse_linescan = wavename+"_0_L"
		Duplicate/O $linescan $synapse_linescan
		
		make/o/n=1 numAZTemp = 1
		duplicate/o numAZTemp $synapse_numOfAZ
		
	
	else
	
		make/O/n=1 muHat
		for (i=0; i<loopLength; i+=1) 
			Make/O/n=1 mu
			mu=CoefsTemp[i*3+1]
			concatenate/NP=0 {mu}, muHat
		endfor
		DeletePoints/M=0 0,1,muHat
	
		Differentiate fanoFit/D=$fanoFit_DIF;DelayUpdate
		Differentiate $fanoWave/D=$fanoWave_DIF;DelayUpdate
		Smooth/S=2 21, $fanoWave_DIF;DelayUpdate

		// finding minima in 1st derivative of Fano fit
		FindLevel/EDGE=1/P/B=15 $fanoFit_DIF, 0
 		Make/O/N=1 potentialChoppingPoints
 		potentialChoppingPoints[0]=floor(V_LevelX)
	
		for (i=0; i<loopLength; i+=1)
			FindLevel/EDGE=1/P/B=21/R=[potentialChoppingPoints[i]+1] $fanoFit_DIF, 0 
			Make/O/n=1 newMin
			newMin=floor(V_levelX)
			concatenate/NP=0 {newMin}, potentialChoppingPoints
		endfor
	
		// getting rid of duplicated minima
		FindDuplicates/RN=maybeChop potentialChoppingPoints
	
	
		// looping through chopping points and checking whether amps around the minima exceed the separation threshold for chopping 
		Make/O/N=1 choppingPoints
		//Duplicate/O $potentialChoppingPointsWODup, maybeChop
		variable chopLength = dimsize(maybeChop,0)
		variable/G prevChopPt, chopPt, nextChopPt
		variable/G ampLeft, ampRight, biggestAmp, minimum, minAsBigPeakPercentage
		variable/G firstD, lastD, dPerPoint
	
		for (i=0; i<chopLength; i+=1)
			chopPt = maybeChop[i]
			
			if (i==0)
				prevChopPt = 0
			else
				prevChopPt = maybeChop[i-1]
			endif
			if (i==chopLength)
				nextChopPt = dimsize(fanoFit,0)
			else
				nextChopPt = maybeChop[i+1]
			endif
			
			ampLeft = wavemax(fanoFit,pnt2x(fanoFit,prevChopPt),pnt2x(fanoFit,chopPt))
			ampRight = wavemax(fanoFit,pnt2x(fanoFit,chopPt),pnt2x(fanoFit,nextChopPt))
			biggestAmp = max(ampLeft,ampRight)
			minimum = fanoFit[chopPt]
			minAsBigPeakPercentage = minimum/biggestAmp*100
			
			
			if (minAsBigPeakPercentage<sepThresh)
				make/O/n=1 chopPtt
				chopPtt = chopPt
				concatenate/NP=0 {chopPtt}, choppingPoints
			endif
			
		endfor
	
	
		make/O/n=1 lastPt
		lastPt = dimsize(fanoFit,0)
		concatenate/NP=0 {lastPt}, choppingPoints
	
		FindDuplicates/RN=finalChoppingPts choppingPoints
		DeletePoints/M=0 0,1,finalChoppingPts
	
		// using final points from choppingPoints wave to split the profile
		
		
		loopLength2 = dimsize(finalChoppingPts,0)
		make/o/n=1 numAZTemp // counting number of AZ in chunks
		
		for (i=0; i<loopLength2; i+=1)
			
			if (i==0)
				wavestart = 0
			else
				wavestart = finalChoppingPts[i-1]
			endif
		
			if (i==loopLength2)
				waveend = dimsize(fanoFit,0)
			else
				waveend = finalChoppingPts[i]
			endif
			
			wavepts = waveend-wavestart
			string/G synapse = wavename+"_"+num2str(waveCounter)
			Make/O/N=(wavepts) $synapse
			Duplicate/O/R=[wavestart,waveend] $fanoWave $synapse
			
			
			// chopping up distance wave at the same points as profile chop, for rescaling purposes
			killwaves/z $wavename+"_"+num2str(waveCounter)+"_d"
			WAVE synapse_d = $wavename+"_"+num2str(waveCounter)+"_d"
			string/G synapse_dist = wavename+"_"+num2str(waveCounter)+"_d"
			Make/O/N=(wavepts) synapse_d
			Duplicate/O/R=[wavestart,waveend] $distance synapse_d
			Duplicate synapse_d $synapse_dist

			
			
			// chopping up linescan at the same points as profile chop
			string/G synapse_linescan = wavename+"_"+num2str(waveCounter)+"_L"
			Make/O/N=(wavepts) $synapse_linescan
			Duplicate/O/R=[][wavestart,waveend] $linescan $synapse_linescan
			
			
			waveCounter += 1
			
			//////////////
			
			duplicate/o $synapse_dist dist
	
			variable distYStart = dist[0]
			variable distYEnd = dist[dimsize(dist,0)]
			variable distPtNum = dimsize(dist,0)
			variable calculatedDistDeltaT = (distYEnd-distYstart)/distPtNum
			
			
			///////////////
			
			// make coef wave
			string/G synapse_coef = synapse+"_coef"
			make/o/n=1 synapse_coefTemp
			firstD = synapse_d[0]
			lastD = synapse_d[dimsize(synapse_d,0)]
			
			
			for (j=0; j<dimsize(muHat,0);j+=1)
				if (muHat[j] > firstD && muHat[j] < lastD)
					
					make/O/n=1 amplitude
					amplitude = CoefsTemp[j*3]
					
					make/O/n=1 location
					//location = floor((CoefsTemp[j*3+1]-distYStart)/calculatedDistDeltaT)
					location = CoefsTemp[j*3+1]
					make/O/n=1 sigma
					sigma = CoefsTemp[j*3+2] 
					concatenate/NP=0 {amplitude, location, sigma}, synapse_coefTemp
				endif
			endfor // end j
			DeletePoints/M=0 0,1,synapse_coefTemp
			duplicate/o synapse_coefTemp $synapse_coef
			make/o/n=1 chunkTemp = dimSize($synapse_coef,0)/3
			concatenate/NP=0 {chunkTemp}, numAZTemp
			

		endfor // end i
		DeletePoints/M=0 0,1,numAZTemp
		duplicate/o numAZTemp $synapse_numOfAZ
	endif



	Legend/K/N=text0
	appendtograph $fitWaveName vs $("fit_"+ distWaveName) //distance_c
	SetAxis left 0,*
	modifygraph rgb($fitWaveName)=(1,16019,65535)
	legend/C/N=text1/A=RT
	hideInfo
	
	//Killwaves temp		
	//killwaves $first_dif, $second_dif, Xvals, newXvals, wavein, Yvals, profile

End
////////////////////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////////////////////
Function UserCursorAdjustNew(graphName,autoAbortSecs)
	string graphName
	variable autoAbortSecs	
	dowindow/F $graphName // Bring graph to front
	if (V_Flag == 0) // Verify that graph exists
		abort "UserCursorAdjust: No such graph."
		return -1
	endif
	newpanel /K=1 /W=(187,368,677,480) as "Pause for Cursor"
	dowindow/C tmp_PauseforCursor // Set to an unlikely name
	autopositionwindow/E/M=1/R=$graphName // Put panel near the graph
	drawtext 21,20,"Place cursors on unwanted peaks so that there's a maximum of 6 peaks left and then"
	drawtext 21,40,"Click Continue." 
	drawtext 21,60,"Disclaimer: Close Gaussian Mixture Fit Graph before defining new AZs"
	button button0,pos={190,78},size={102,20},title="Continue"
	button button0,proc=UserCursorAdjust_ContButtonProc
	variable didAbort= 0
	if( autoAbortSecs == 0 )
		pauseforuser tmp_PauseforCursor,$graphName
	else
		setdrawenv textyjust= 1
		drawtext 162,103,"sec"
		setvariable sv0,pos={48,97},size={107,15},title="Aborting in "
		setvariable sv0,limits={-inf,inf,0},value= _NUM:10
		variable td= 10,newTd
		variable t0= ticks
		Do
		newTd= autoAbortSecs - round((ticks-t0)/60)
		if( td != newTd )
			td= newTd
			setvariable sv0,value= _NUM:newTd,win=tmp_PauseforCursor
		if( td <= 10 )
			setvariable sv0,valueColor= (65535,0,0),win=tmp_PauseforCursor
		endif
		endif
		if( td <= 0 )
			dowindow/K tmp_PauseforCursor
			didAbort= 1
			break
		endif
		pauseforuser/C tmp_PauseforCursor,$graphName
		while(V_flag)
	endif
	return didAbort
end




Function UserCursorAdjust(graphName,autoAbortSecs)
	string graphName
	variable autoAbortSecs
	dowindow/F $graphName // Bring graph to front
	if (V_Flag == 0) // Verify that graph exists
		abort "UserCursorAdjust: No such graph."
		return -1
	endif
	newpanel /K=1 /W=(187,368,437,531) as "Pause for Cursor"
	dowindow/C tmp_PauseforCursor // Set to an unlikely name
	autopositionwindow/E/M=1/R=$graphName // Put panel near the graph
	drawtext 21,20,"Adjust the cursors and then"
	drawtext 21,40,"Click Continue."
	button button0,pos={80,58},size={92,20},title="Continue"
	button button0,proc=UserCursorAdjust_ContButtonProc
	variable didAbort= 0
	if( autoAbortSecs == 0 )
	pauseforuser tmp_PauseforCursor,$graphName
	else
	setdrawenv textyjust= 1
	drawtext 162,103,"sec"
	setvariable sv0,pos={48,97},size={107,15},title="Aborting in "
	setvariable sv0,limits={-inf,inf,0},value= _NUM:10
	variable td= 10,newTd
	variable t0= ticks
	do
	newTd= autoAbortSecs - round((ticks-t0)/60)
	if( td != newTd )
		td= newTd
		setvariable sv0,value= _NUM:newTd,win=tmp_PauseforCursor
		if( td <= 10 )
			setvariable sv0,valueColor= (65535,0,0),win=tmp_PauseforCursor
		endif
	endif
	if( td <= 0 )
		dowindow/K tmp_PauseforCursor
		didAbort= 1
		break
	endif
	pauseforuser/C tmp_PauseforCursor,$graphName
	while(V_flag)
		endif
	return didAbort
end




Function UserCursorAdjust_ContButtonProc(ctrlName) : ButtonControl
	string ctrlName
	dowindow/K tmp_PauseforCursor // Kill panel
	dowindow/K Linescan
end


///////////////////////////////////////////////////// Old Define AZs //////////////////////////////////////////////////////

Function azButtOld(ba) : ButtonControl
	Struct WMButtonAction &ba
	switch(ba.eventCode)
		case 2: 
			print ("You booped Detect AZs")
			string list=wavelist("*_L",";","DIMS:2")
			string waveName
			prompt waveName, "Line scan to analyse", popup,list
			doprompt "Pick your Line scan", waveName
			//DefineAZsOld(waveName)	 
			  newDefine(waveName)	
		break
				
		case -1: // control being killed
			break
	endswitch
	return 0
End




Function DefineAZsOld(waveName)
	String waveName
	
	Variable AZleftP_1, AZrightP_1, AZleftP_2, AZrightP_2, AZleftP_3, AZrightP_3
	//At this point, the base name has "_L" added to it.  We now remove this and add the suffix "_AZs"
	//The ".._AZs" wave will contain the left and right limits of each AZ 
	String AZname=(waveName[0, (strlen(waveName)-3)])+"_AZs"		
	string out=(waveName[0, (strlen(waveName)-3)])+"_profile"
	
	duplicate/o $waveName $out
	duplicate/o $waveName w1
         
   make/o/n=(dimsize(w1,1)) w2
   matrixop/o w2=sumCols(w1)
   make/o/n=(dimsize(w2,1)) w3
   w3=w2[0][p]
   duplicate/o w3 $out
         
   display/k=1/N=Profile $out
   Legend/C/N=text0/J/F=0/A=RT "\\f01\\Z14Define AZ's using cursor pair(s) and close window"
   ShowInfo/CP={0,1,2}/W=Profile
   MoveWindow/W=Profile 0, 400, 600, 600
   CursorInput(0, "Profile")
         
   AZleftP_1=pcsr(A)
   AZrightP_1=pcsr(B)
   
   string csrResult
   csrResult=CsrInfo(C,"Profile")
   
   if(cmpstr(csrResult, "")==0)
   	AZleftP_2=0
   	AZrightP_2=0
   	AZleftP_3=0
   	AZrightP_3=0
   else
   	AZleftP_2=pcsr(C)
   	AZrightP_2=pcsr(D)
   endif
   
   csrResult=CsrInfo(E,"Profile")
   if(cmpstr(csrResult, "")==0)
   	AZleftP_3=0
   	AZrightP_3=0
   else
   	AZleftP_3=pcsr(E)
   	AZrightP_3=pcsr(F)
   endif
 
        
   Make/O/N=6 $AZname, temp
   temp= {AZleftP_1,AZrightP_1,AZleftP_2,AZrightP_2, AZleftP_3,AZrightP_3}
   Duplicate/O temp $AZname 
   KillWindow Profile 
             
	KillWaves temp, w1, w2, w3, $out	 
    
End          




Function CursorInput(autoAbortSecs, graphName)
	Variable autoAbortSecs
	String graphName
	
	if (UserCursorAdjust_L(graphName,autoAbortSecs) != 0)
		return -1
	endif

	if (strlen(CsrWave(A))>0 && strlen(CsrWave(B))>0)	// Cursors are on trace?
	endif
End




Function UserCursorAdjust_ButtonProc(ctrlName) : ButtonControl
	String ctrlName

	DoWindow/K tmp_PauseforCursor				// Kill self
	DoWindow/K LineScan							//Kill Profile window too
End





Function UserCursorAdjust_L(graphName,autoAbortSecs)
	String graphName
	Variable autoAbortSecs

	DoWindow/F $graphName							// Bring graph to front
	if (V_Flag == 0)									// Verify that graph exists
		Abort "UserCursorAdjust: No such graph."
		return -1
	endif

	NewPanel /K=2 /W=(187,368,437,531) as "Pause for Cursor"
	DoWindow/C tmp_PauseforCursor					// Set to an unlikely name
	AutoPositionWindow/E/M=1/R=$graphName			// Put panel near the graph

	DrawText 21,20,"Adjust the cursors and then"
	DrawText 21,40,"Click Continue."
	Button button0,pos={80,58},size={92,20},title="Continue"
	Button button0,proc=UserCursorAdjust_ButtonProc
	Variable didAbort= 0
	if( autoAbortSecs == 0 )
		PauseForUser tmp_PauseforCursor,$graphName
	else
		SetDrawEnv textyjust= 1
		DrawText 162,103,"sec"
		SetVariable sv0,pos={48,97},size={107,15},title="Aborting in "
		SetVariable sv0,limits={-inf,inf,0},value= _NUM:10
		Variable td= 10,newTd
		Variable t0= ticks
		Do
			newTd= autoAbortSecs - round((ticks-t0)/60)
			if( td != newTd )
				td= newTd
				SetVariable sv0,value= _NUM:newTd,win=tmp_PauseforCursor
				if( td <= 10 )
					SetVariable sv0,valueColor= (65535,0,0),win=tmp_PauseforCursor
				endif
			endif
			if( td <= 0 )
				DoWindow/K tmp_PauseforCursor
				didAbort= 1
				break
			endif
				
			PauseForUser/C tmp_PauseforCursor,$graphName
		while(V_flag)
	endif
	
	return didAbort
End





///////////////////////////////////////////////////// New Temporal Button ///////////////////////////////////////////////////////
Function temporalProfileButt(ba): ButtonControl

Struct WMButtonAction &ba
	switch(ba.eventCode)
		case 2: 
			print ("-------------  Temporal Profile  -------------")
			string list= wavelist("*_p",";","DIMS:1") + wavelist("*_p_i",";","DIMS:1") + wavelist("*_p_*_o",";","DIMS:1")
			string wavename
			prompt wavename, "Profile to analyse", popup,list
			doprompt "Pick your Profile", wavename
			
			string regExp = wavename+"_L"
			string regExpCoef = "W_Coef"
			string/G AZnumsTemp = wavename+"_numOfAZ"
			duplicate/O $AZnumsTemp AZnums
			
			string profileList = wavelist(wavename+"_*",";","")
			string profileListGrep = greplist(profileList, regExp)
			string profileListGrepCoef = greplist(profileList, regExpCoef)
			variable i 
			variable FirstAZNum, AZCounter
			variable listLength = itemsInList(profileListGrep)
			for (i=0; i<listLength; i+=1)
				if (i==0)
					FirstAZNum=0
				else
					FirstAZNum=AZCounter
				endif
				string profileString = stringFromList(i,profileListGrep)
				string coefString = stringFromList(i,profileListGrepCoef)
				//OldTemporalProfileForNewData(profileString,i,FirstAZNum)
				newnewDefineAndTempProf(profileString,regExpCoef,FirstAZNum,i)
				AZCounter += AZnums[i]
			endfor
			
		break	
				
		case -1: // control being killed
			break
	endswitch

	return 0
End
//////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////

Function avgSynapseButt(ba): ButtonControl

Struct WMButtonAction &ba
	switch(ba.eventCode)
		case 2: 
			print ("-------------  Average Synapses  -------------")
			
			string list= wavelist("*_p",";","DIMS:1") + wavelist("*_p_i",";","DIMS:1") + wavelist("*_p_*_o",";","DIMS:1")
			string wavename
			prompt wavename, "AZs to average", popup,list
			doprompt "Pick your input or output", wavename
			
			string regExp = wavename+"_AZ\\d{1,2}$"
			string AZList = wavelist(wavename+"_*",";","")
			string AZListGrep = greplist(AZList, regExp)
			
			string avg_synapse = wavename+"_AZ_avg"
			string avg_synapse_sem = wavename+"_AZ_avg_SEM"

			
			make/O/N=0 pop_avg
		
			variable listLength = itemsInList(AZListGrep)
			variable i
			for (i=0; i<listLength; i+=1)
				string AZString = stringFromList(i,AZListGrep)
				concatenate/NP=1 {$AZString}, pop_avg
			endfor
			
			make/O/N=0 wave_avgs
			make/O/N=0 wave_stds
			for (i=0; i<(dimsize(pop_avg,0)); i+=1)
				duplicate/O/R=(i) pop_avg time_point_column
				wavestats/Q time_point_column
				make/o/n=1 avg=V_avg
				make/o/n=1 std=V_SEM
				concatenate /NP=0 {avg}, wave_avgs
				concatenate /NP=0 {std}, wave_stds
			endfor
			
			duplicate/O wave_avgs $avg_synapse
			duplicate/O wave_stds $avg_synapse_sem
			
			SetScale/P x 0,dimdelta($stringFromList(0,AZListGrep),0),"",$avg_synapse

			BaseCorrection(avg_synapse)
			newWiener(avg_synapse)
			
			killwaves/Z G, h, HF, HMAGSQR, kernel_smth, levelsWave, N, pop_avg, SF, SNR, SNR2, std, time_point_column, wave_avgs, wave_smth, wave_stds, W_sigma, XCONVG, xfiltered, XSIG, xsignal, avg, coefs
			killvariables/Z tauDecay, taurise, threshold, unitaryEvent
			killstrings/Z globalwave
			
			//display 
			
		break	
				
		case -1: // control being killed
			break
	endswitch

	return 0
End






///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////// Newest Temporal Profile Function ///////////////////////////////////////////////////////
///   Input is the 2D line scan to be analyzed.  name ends in _p (whole scan), or _p_i (input) or _p_o (output)
///   

Function TemporalProfile(WaveName)
string waveName

NVAR nPointsforfitting  //From the variable control in panel
NVAR TauDecay
NVAR unitAmp	
String/G fanowavename				
//Initial guesses for parameters of fit are all in the corresponding coefficients wave: wavename + " _coef" wich is held in string called CoefName 
String/G DistWaveName = wavename + "_d"
//String CoefWaveName = wavename + "_coefs"
String/G CoefWaveName = wavename + "_Fano_coefs"
//String/G CoefWaveName = wavename + "_coefs"
Duplicate/O $coefWaveName coefsTemp

String LSWaveName = wavename + "_L"
variable nGauss = dimsize(coefsTemp, 0)/3
variable nConstraints = 5
variable nParams = 3

print "Fitting line scan " + wavename + " which has corresponding distance wave " + DistWaveName + ", with initial coefficients from " + CoefWaveName
print "Downsampling intensity profile to " + num2str(nPointsforfitting) + " points."
print "Decay time-constant (s) = " + num2str(TauDecay) + ". Unitary event amplitude = " + num2str(unitAmp) +"."

variable i, j, k

////////////////// This section can extract the timeseries for each synapse
///  To allow analysis on reasonable time-scale, the intensity pofile must not have too many points.  
///  But you also need enough points to sample each peak adequately and have the fitting converge.  Rule of thumb: 25 points per peak.

variable/G decimationFactor = floor((dimsize($wavename, 0)/nPointsforfitting))  //For when scans are oversampled spatially (try to avoid!).  Saves time.  Fitting to about 100-200 points usually good.
String/G linePlotName = 	(waveName[0, (strlen(waveName)-3)])+ "_L"   	//Contains the name of the 2D kymograph plot

String HoldString = "011"
for(i=1; i<nGauss; i+=1)
	HoldString += "010"
endfor	
	
/////Resampling spatially by decimation factor
String distDecName = DistWaveName + "_dec"
Duplicate/O $DistWaveName distDec
Resample/DOWN=(decimationFactor) distDec //$distDecName
Duplicate/O distDec, $distDecName

String dataDecName = wavename + "_dec"
Duplicate/O $LSWaveName dataDec
Resample/DIM=1/DOWN=(decimationFactor) dataDec
Duplicate/O dataDec, $dataDecName	

variable ntimePoints = dimsize($dataDecName,0)
variable nSynapse = dimsize($coefWaveName, 0)/3
variable nProfilePoints = dimsize(dataDec, 1)

Make/O/N=(nSynapse, ntimePoints) Tseries = 0
Make/D/O/N=(dimsize(distDec,0)) prof_tpoint, fitted

///  Get ready to pull out the appropriate part of the linescan (i.e input or output)
string PointsWaveName = waveName + "_pts"
Duplicate/O $PointsWaveName, ptsTemp
ptsTemp/=decimationFactor
variable ptStart = ptsTemp[0]
variable ptEnd = ptsTemp[1]
Make/O/N=(nsynapse*nConstraints) W_FitConstraint
Make/O/N=((nsynapse*nConstraints), (nSynapse*nParams)) M_FitConstraint
		
////////////////////////////////////////////////////////////////////////
///////// Do curve fit for profile at each time point ///////// 
//Function DoMultipleGaussFitsMT(Guesses, LinePlotName, xdata, CMatrix, DVector);  Wave Guesses, xdata, CMatrix, DVector;  String LinePlotName
////////////////////////////////////////////////////////////////////////

String ResultName
ResultName = DoMultipleGaussFitsMT(CoefsTemp, dataDecName, distDec, M_FitConstraint, W_FitConstraint)

Duplicate/O $ResultName allCoefs
Make/N=200/O CumHistTemp;DelayUpdate
variable outlierThreshValue = 100  //, outlierThresh = 0.99  //wave values in last 1% of distribution of values reset to previous point value
 
//Make signal wave for each synapse
string SynapseName = wavename + "_S_"
Make/O/N=(nTimePoints) signalTemp
//NVAR framerate
variable nOutliers = 0
for(i=0; i < nSynapse; i+=1)
	SynapseName = waveName + "_S_" + num2str(i)
	signalTemp[] = allCoefs[i*3][p]
	//Histogram/CUM/B={-10,0.1,200} signalTemp, CumHistTemp;DelayUpdate
	//outlierThreshValue = 100//outlierThresh*wavemax(CumHistTemp)
	//outlierThreshValue = 5			//Here removing outliers above or below defined value.  Rememember wave has been normalized.
	for(j=0; j<ntimePoints; j+=1)
		if (signalTemp[j]   >  outlierThreshValue  ||  signalTemp[j]   <  (outlierThreshValue*-1))
			signalTemp[j] = signalTemp[j-1]
			nOutliers += 1
		endif
	endfor
	Duplicate/O signalTemp $SynapseName
	variable/G ScanningDurn 
	setscale/I x, 0, (ScanningDurn), $SynapseName			//Get timescales right after any downsampling
	//BaseCorrection(SynapseName)
   DeltaF(SynapseName)
   newWiener(SynapseName)
   string deconMat2 = SynapseName + "_D"
   duplicate/o $deconMat2, dec2
   concatenate/NP=1 {dec2}, decMat 	
endfor
 
print "Number of outliers beyond ± " + num2str(outlierThreshValue) + " = " + num2str(nOutliers)

//duplicate/o data, $spatFilt
//duplicate/o sigma2, $sigmaHatName
//killwaves W_Coef, dat, fit_dat, sumDat, tmpMu, tmpA, xS, sigma2, mu
//killwaves/z T_Constraints, data, A

End
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////	


Function OldTemporalProfileForNewData(wavename, chunkNumber, FirstAZNum) //add distance wave to be passed here
	string wavename
	variable FirstAZNum, chunkNumber   //The first peak in this profile might not be AZ 0!!!!!!
	string/G linescan = wavename+"_L"
	string/G fanoFitCoefs = wavename + "_coef" 
	string/G distWaveName = wavename + "_d"
	string/G tPntProfileName = wavename + "_t"
	string/G aHatName = wavename + "_aHat"
	string/G muHatName = wavename + "_muHat"
	string/G sigmaHatName = wavename + "_sigmaHat"
	string/G fitcoefsName = wavename+"_fitCoefs"
	string/G numOfAZTemp = (wavename[0,strlen(wavename)-3])+"_numOfAZ"
	variable i
	variable coefLength = dimsize($fanoFitCoefs,0)/3
	
	duplicate/O $numOfAZTemp numOfAZ 
	variable AZsInChunk = numOfAZ[chunkNumber]
	variable AZsInPrevChunk = numOfAZ[chunkNumber-1]
	
	
	//duplicate/o $wavename, lData
	//duplicate/o $linescan, lData
	duplicate/o $wavename, lData //profile
	duplicate/o $linescan, lData2 //linescan
	duplicate/o $fanoFitCoefs, coefs //initial guesses for gaussian fit 
	
	// rescale linescan/profile to even delta t from distance wave
	// lData --> profile
	// lData2 --> linescan
	// distWaveName --> distance
	
	duplicate/o $distWaveName dist
	
	variable distYStart = dist[0]
	variable distYEnd = dist[dimsize(dist,0)]
	variable distPtNum = dimsize(dist,0)
	variable calculatedDistDeltaT = (distYEnd-distYstart)/distPtNum

	
	//SetScale/P x distYStart,calculatedDistDeltaT,"", $wavename
	//SetScale/P y distYStart,calculatedDistDeltaT,"", $linescan
	
	//SetScale/P x distYStart,calculatedDistDeltaT,"", lData
	//SetScale/P y distYStart,calculatedDistDeltaT,"", lData2
	
	SetScale/P x 0,1,"", $wavename
	SetScale/P y 0,1,"", $linescan
	
	SetScale/P x 0,1,"", lData
	SetScale/P y 0,1,"", lData2
	
	
	
	make/o/n=1 aHat
	make/o/n=1 muHat
	make/o/n=1 sigmaHat
	for (i=0;i<coefLength;i+=1)
		make/o/n=1 a
		a = coefs[i*3]
		concatenate/NP=0 {a} ,aHat
		make/o/n=1 mu
		make/o/n=1 mu2
		mu = coefs[i*3+1]
		mu2 = floor((mu-distYStart)/calculatedDistDeltaT)
		concatenate/NP=0 {mu2} ,muHat
		make/o/n=1 sig
		sig = coefs[i*3+2]
		concatenate/NP=0 {sig} ,sigmaHat
	endfor
	deletepoints/M=0 0,1,aHat
	deletepoints/M=0 0,1,muHat
	deletepoints/M=0 0,1,sigmaHat
	
	
	duplicate/o aHat, $aHatName
	duplicate/o muHat, $muHatName
	duplicate/o sigmaHat, $sigmaHatName
	
	fitgauss(wavename, muHatName, aHatName)
	
	
	variable dt = dimdelta(lData2,0) // taken from linescan (delta between timepoints)
	variable nPoints = dimsize(lData2,0) // taken from linescan (number of timepoints)
	variable nX = dimsize(lData2,1) // taken from linescan 
	make/o/n=(nX) xS
	for (i=0;i<nX;i+=1)
		xS[i] = i
	endfor
	variable nROI = dimsize(aHat,0)
	
	
	/// AZs
	make/o/n=(nPoints) tempRoi
	killwaves/z deconMat
	//wave deconMat
	//wave roiDat
	//fitGauss(wavename, muHatName,aHatName, distWaveName)
	//Duplicate/O $fitcoefsName, fitResults
	variable j, k
	for (i=0;i<nRoi;i+=1)
	tempRoi =0
	Make/O/N=(nPoints) timeSeries
		for (j=0;j<nPoints;j+=1)
			//Curvefit here.
			//Duplicate/O/RMD=[j][] lData2, $tPntProfileName
			//Redimension/N=(dimsize($tPntProfileName,1)) $tPntProfileName
			//SetScale/P x 0,1,"", $tPntProfileName
			//fitGauss(tPntProfileName, muHatName, aHatName)
			//Duplicate/O $fitcoefsName, fitResults   
			for (k=0;k<nX;k+=1)
				tempRoi[j] += lData2[j][k] *aHat[i] * (2 * pi * sigmaHat[i])^-.5 * exp(-(xS[k]-muHat[i])^2/(2 * sigmaHat[i]))
			endfor
			//timeSeries[j]=fitResults[0]
			
			concatenate/np=1 {tempRoi}, roiDat
			duplicate/o/RMD=[][0] roiDat, timeseries
			setscale/P x,0,dt, timeseries
			BaseCorrection("timeseries")
			DeltaF("timeseries")
			newWiener("timeseries")
		endfor
	endfor
	make/o roiDat
	string azName1 = (waveName[0, (strlen(waveName)-3)])+"_AZ"+num2str(FirstAZNum)
	string decon1 = azName1 + "_D"
	duplicate/o/RMD=[][0] roiDat, $azName1
	setscale/P x,0,dt, $azName1
	BaseCorrection(azName1)
	DeltaF(azName1)
	newWiener(azName1)
	concatenate/np=1 {$decon1}, deconMat
	display/k=1 $decon1 as "Temporally Deconvolved AZ"+num2str(FirstAZNum)
	label left "Deconvolved Amplitude"
	label bottom "Time (s)"
	if (nRoi>=2)
		string azName2 = waveName[0, (strlen(waveName)-3)]+"_AZ"+num2str(FirstAZNum+1)
		duplicate/o/RMD=[][1] roiDat, $azName2
		setscale/P x,0,dt, $azName2
		BaseCorrection(azName2)
		DeltaF(azName2)
		newWiener(azName2)
		string decon2 = azName2 + "_D"
		concatenate/np=1 {$decon2}, deconMat
		print decon2
			display/k=1 $decon2 as "Temporally Deconvolved AZ"+num2str(FirstAZNum+1)
		label left "Deconvolved Amplitude"
		label bottom "Time (s)"
	endif
	if (nRoi>=3)
		string azName3 = waveName[0, (strlen(waveName)-3)]+"_AZ"+num2str(FirstAZNum+2)
		
		duplicate/o/RMD=[][2] roiDat, $azName3
		setscale/P x,0,dt, $azName3
		BaseCorrection(azName3)
		
	DeltaF(azName3)
	newWiener(azName3)
	
	string decon3 = azName3 + "_D"
		concatenate/np=2 {$decon3}, deconMat
		display/k=1 $decon3 as "Temporally Deconvolved AZ"+num2str(FirstAZNum+2)
	label left "Deconvolved Amplitude"
	label bottom "Time (s)"
	endif
	if (nRoi >=4)
		string azName4 = waveName[0, (strlen(waveName)-3)]+"_AZ"+num2str(FirstAZNum+3)
		
		duplicate/o/RMD=[][3] roiDat, $azName4
		setscale/P x,0,dt, $azName4
		BaseCorrection(azName4)
	DeltaF(azName4)
	newWiener(azName4)
	string decon4 = azName4 + "_D"
		concatenate/np=2 {$decon4}, deconMat

	display/k=1 $decon4 as "Temporally Deconvolved AZ"+num2str(FirstAZNum+3)
	label left "Deconvolved Amplitude"
	label bottom "Time (s)"
	endif
	if (nROI >=5)
		string azName5 = waveName[0, (strlen(waveName)-3)]+"_AZ"+num2str(FirstAZNum+4)
	
		duplicate/o/RMD=[][4] roiDat, $azName5
		setscale/P x,0,dt, $azName5
		BaseCorrection(azName5)
	DeltaF(azName5)
	newWiener(azName5)
	string decon5 = azName5 + "_D"
		concatenate/np=2 {$decon5}, deconMat
		display/k=1 $decon5 as "Temporally Deconvolved AZ"+num2str(FirstAZNum+4)
	label left "Deconvolved Amplitude"
	label bottom "Time (s)"
	endif
	
	if (nRoi>=6)
		string azName6 = waveName[0, (strlen(waveName)-3)]+"_AZ"+num2str(FirstAZNum+5)
		duplicate/o/RMD=[][5] roiDat, $azName6
		setscale/P x,0,dt, $azName6
		BaseCorrection(azName6)
	DeltaF(azName6)
	newWiener(azName6)
	string decon6 = azName6 + "_D"
		concatenate/np=2 {$decon6}, deconMat
		display/k=1 $decon6 as "Temporally Deconvolved AZ"+num2str(FirstAZNum+5)
	label left "Deconvolved Amplitude"
	label bottom "Time (s)"
	endif
	string roiMat = (waveName[0,strlen(waveName)-3]) + "_roiDatMat"
	duplicate/o roiDat, $roiMat
	string baseWaveName = (waveName[0,strlen(wavename)-3])
	//killwaves aHat,lData,muHat,sigmaHat,tempRoi,roiDat
	string deconMatName = (waveName[0,strlen(wavename)-3]) + "_deconMat"
	duplicate/o deconMat, $deconMatName
	//killwaves/z deconMat
	//killwaves/z xS

	
	
	end
	
	makedeconmat()
end



////////////////////// BaseCorrection only does a linear correction, ignoring any initial faster component ///////////////////////


Function BaseCorrection(waveName)
	String waveName
	
	Duplicate/O $waveName, w
	variable deltat=dimdelta($waveName,0)
	variable nPoints=dimsize($waveName,0)
	duplicate/o w, fit
	
	
	variable endX = pnt2x(w,nPoints)
			
//Choosing here 7 s and 45 s as being roughtly in middle of baselines before and after the stimulus period			
	variable position1=7
	variable position2=45
	Variable m 
	m = (mean($waveName, endX-3, endX-1)- mean($waveName, 2, 4)) / (endX-3-7)
	fit = m*x
	w-=fit
	
	
	
	string out=waveName
	duplicate /o w,$out
	KillWaves/z w, fit
	
End



////////////////////////////////////////////////////// Non Linear Baselines //////////////////////////////////////////////////////
Function nonLinearBase(wavename)
string wavename
duplicate/o $wavename, w, fit

variable stimStart = 5
variable recLen = pnt2x(w,numpnts(w))

variable mean1 = mean(w,stimStart-4,stiMStart-1)
variable mean2 = mean(w,recLen-4,recLen-1)


variable ratio = mean1/mean2
fit = 0
fit = (ratio-1)*(p) / numpnts(w)+1
w*=fit
string out = waveName
duplicate/o w, $out
killwaves/z w, fit
end






////////////////////////////////////////////////////////// Delta F //////////////////////////////////////////////////////////////
	Function/S DeltaF(waveName)
	String waveName

	Variable lengthWave=dimsize($waveName, 0) * dimdelta($waveName, 0)
	Variable x0=0.05*lengthWave, x1=0.95*lengthWave
	string AZname=waveName[(strlen(wavename)-4),strlen(wavename)] 
	string out=waveName[0, (strlen(wavename)-4)] +"DF" + AZname
			
	duplicate/o $waveName tempwave
			
	Make/N=1000/O Hist;DelayUpdate
	Histogram/B={0, 0.001, 1000} $waveName, Hist;DelayUpdate
	Duplicate/O Hist, Hist_smth;DelayUpdate
	Smooth 1, Hist_smth;
			
	FindPeak/Q Hist_smth
	//tempwave=(tempwave/wavemax(Hist_smth))-1
	tempwave=(tempwave/V_PeakLoc)-1        
	Duplicate/O tempwave $waveName
	//KillWaves/z Hist, Hist_smth, tempwave
	return out      
End

////////////////////////////////////////////////////////// Delta F //////////////////////////////////////////////////////////////
	Function/S DeltaFWindow(waveName, t1, t2)
	String waveName
	Variable t1, t2

	string AZname=waveName[(strlen(wavename)-4),strlen(wavename)] 
	string out=waveName[0, (strlen(wavename)-4)] +"DF" + AZname
			
	duplicate/o $waveName tempwave
			
	WaveStats/Q/R=(t1, t2) $waveName
	tempwave=(tempwave/V_Avg)-1        
	Duplicate/O tempwave $waveName
	//KillWaves/z Hist, Hist_smth, tempwave
	return out      
End

//////////////////////////////////////////////////// Old Temporal Profile ///////////////////////////////////////////////////////

Function temporalProfileButtOld(ba) : ButtonControl
	Struct WMButtonAction &ba
	switch(ba.eventCode)
		case 2: 
			print ("You booped Temporal Profile")
			string list=wavelist("*_L",";","DIMS:2")
			string waveName
			prompt waveName, "Line scan wave to analyse (ends in _L)", popup,list
			doprompt "Pick your wave", waveName
     		if(V_flag==1)
				Abort
			endif
			
//Get the wave containing the positions of the active zones, made by the DefineAZs function.
// NB As currently configured, you can only hav a maximum of three AZ's
			
			string list1=wavelist("*_AZs",";","DIMS:1")
			string AZName
			prompt AZName, "Corresponding AZ wave (ends in _AZs)", popup,list1
			doprompt "Pick your wave", AZName
     		if(V_flag==1)
				Abort
			endif
	
			variable deltat=dimdelta($waveName,0)
			variable nPoints=dimsize($waveName,0)
			Duplicate/o $AZName tempAZ
			
			
/////////////////////////////////////////
	TemporalProfileOld(waveName)             
//////////////////////////////////////////
		
		case -1: // control being killed
			break
	
	endswitch
	//KillWaves tempAZ, tempAZ1, tempAZ2, tempAZ3

	return 0
	
End

///////////////////////////////////////////////////// Old Temporal Profile ///////////////////////////////////////////////////////
Function TemporalProfileOld(waveName)

	string waveName
	
//Takes the line scan 2D wave, which will end with "_L".  
//Then opens the positions of the active zones, which will end with "_AZs".
//made by the DefineAZs function. Corresponding definitions of active zones will end with "_AZs" but without the "_L".

// NB As curently configured, you can only have a maximum of three AZ's
	
	String AZname=(waveName[0, (strlen(waveName)-3)])+"_AZs"	
	variable deltat=dimdelta($waveName,0)
	variable nPoints=dimsize($waveName,0)
	Duplicate/o $AZName tempAZ

//Get the response in AZ1			
	string outName1=waveName[0, (strlen(waveName)-3)]+"_AZ1"
	Variable leftPoint = tempAZ[0]
	Variable rightPoint = tempAZ[1]
	Variable nPointsAZ1 = tempAZ[1]-tempAZ[0]
	killwaves/z decMat
	Make/O/N=(nPoints) $outName1
	Duplicate/O/R=[][leftPoint,rightPoint]  $waveName tempAZ1
	matrixop/o $outName1=sumRows(tempAZ1)
	duplicate/O $outName1, tempAZ1
	tempAZ1/=nPointsAZ1
	Redimension/N=(nPoints) $outName1, tempAZ1
	Duplicate/O tempAZ1, $outName1
	setscale/P x, 0, deltat, $outName1, tempAZ1 
   BaseCorrection(outName1)
   
   DeltaF(outName1)
   //nonLinearBase(outName1)
   //EventD(outName1)
   newWiener(outName1)
   //setscale/P x, 0, deltat, $outName1 
   duplicate/o $outName1, tempAZ1
   string deconMat1 = outName1 + "_D"
   duplicate/o $deconMat1, dec1
   concatenate/NP=1 {dec1}, decMat

//Get the response in AZ2, if it exists			
	if(tempAZ[2]!=0)
		string outName2=waveName[0, (strlen(waveName)-3)]+"_AZ2"
		leftPoint = tempAZ[2]
		rightPoint = tempAZ[3]	
		Variable nPointsAZ2 = tempAZ[3]-tempAZ[2]
		
		Make/O/N=(nPoints) $outName2
		Duplicate/O/R=[][leftPoint,rightPoint]  $waveName tempAZ2
		matrixop/o $outName2=sumRows(tempAZ2)
		duplicate/O $outName2, tempAZ2
		tempAZ2/=nPointsAZ2
		Duplicate/O tempAZ2, $outName2
		Redimension/N=(nPoints) $outName2, tempAZ2
		setscale/P x, 0, deltat, $outName2 
      BaseCorrection(outName2)
   	DeltaF(outName2)
   	newWiener(outName2)
   
   	//EventD(outName2)
   	//setscale/P x, 0, deltat, $outName1 
   	duplicate/o $outName2, tempAZ2
   	 duplicate/o $outName1, tempAZ1
   string deconMat2 = outName2 + "_D"
   duplicate/o $deconMat2, dec2
   concatenate/NP=1 {dec2}, decMat
	endif
 
 //Get the response in AZ3, if it exists        
    if(tempAZ[4]!=0)
		string outName3=waveName[0, (strlen(waveName)-3)]+"_AZ3"
		leftPoint = tempAZ[4]
		rightPoint = tempAZ[5]
		Variable nPointsAZ3 = tempAZ[5]-tempAZ[4]
					
		Make/O/N=(nPoints) $outName3
		Duplicate/O/R=[][leftPoint,rightPoint]  $waveName tempAZ3
		matrixop/o $outName3=sumRows(tempAZ3)
		duplicate/O $outName3, tempAZ3
		tempAZ3/=nPointsAZ3
		Redimension/N=(nPoints) $outName3
		setscale/P x, 0, deltat, $outName3
		BaseCorrection(outName3)
   	DeltaF(outName3)
   	newWiener(outName3)
   	//EventD(outName3) 
   	//setscale/P x, 0, deltat, $outName1
   	duplicate/o $outName3, tempAZ3
   	 duplicate/o $outName1, tempAZ1
   string deconMat3 = outName3 + "_D"
   duplicate/o $deconMat3, dec3
   concatenate/NP=1 {dec3}, decMat

 
	endif                   

	KillWaves tempAZ, tempAZ1, tempAZ2, tempAZ3
	Execute "TileWindows/O=1/C"
	string deconMatName = (waveName[0,strlen(wavename)-3]) + "_deconMat"
	duplicate/o decMat, $deconMatName
		
	return 0
end



//////////////////////////////////////////////////////// Thresholding ///////////////////////////////////////////////////////////


Function threshButt(ba): ButtonControl
	struct WMButtonAction &ba
	switch(ba.eventCode)
		case 2: 
			print ("You booped Temporal Profile")
			string list=wavelist("*deconMat",";","DIMS:2")
			string waveName
			prompt waveName, "Select ROI Data Matrix Wave", popup,list
			doprompt "Pick your wave", waveName
     		if(V_flag==1)
				abort
			endif
			
			threshGui(waveName)
			
		endswitch
end


/////////////////////////////////////////////////////// Event Detection /////////////////////////////////////////////////////////

Function concatenateAmplitudeWaves(ba): ButtonControl
	struct WMButtonAction &ba
	switch(ba.eventCode)
		case 2:
			print ("Concatenating _A Waves")
			string list=wavelist("*_A",";","DIMS:2")
			string waveName
			prompt waveName, "Select Your ", popup,list
			doprompt "Pick your wave", waveName
     		if(V_flag==1)
				abort
			endif
			
			threshGui(waveName)
			
		endswitch
end






/////////////////////////////////////////////////////// Event Detection /////////////////////////////////////////////////////////


Function eventDetBUTT(ba): ButtonControl
Struct WMButtonAction &ba
	switch(ba.eventCode)
		case 2: 
			print ("You booped Temporal Profile")
			string list=wavelist("*deconMat",";","DIMS:2")
			string waveName
			prompt waveName, "Select ROI Data Matrix Wave", popup,list
			doprompt "Pick your wave", waveName
     		if(V_flag==1)
				Abort
			endif
			duplicate/o $waveName, deconMat
			variable nROIs = dimsize(deconMat,1)
			variable nPoints = dimsize(deconMat,0)
			string threshName = (wavename[0,strlen(wavename)-10]) + "_thresh"
			duplicate/o $threshName, thr
			string baseName = (wavename[0,strlen(wavename)-10]) + "_AZ"
			string e1 = basename + "1_E"
			string a1 = basename + "1_A"
			//wave ampMat,evMat
			variable roi,i
			variable nEvent = 0
			print nRois
			for (roi=0;roi<nROIs;roi+=1)
				duplicate/o/RMD=[][roi] deconMat, decWave, tempA,tempE
				tempE = 0
					tempA = 0
					nEvent = 0
				for (i=1;i<nPoints-1;i+=1)
					
					if (decWave[i] > decWave[i-1] && decWave[i]>decWave[i+1] && decWave[i] > thr[roi])
						tempA[nEvent] = decWave[i]
						tempE[nEvent] = pnt2x(decWave,i)
						nEvent+=1
					endif
				endfor
				if (roi==0)
					deletepoints nEvent,nPoints, tempA
					deletepoints nEvent,nPoints, tempE
					duplicate/o tempA, $a1
					duplicate/o tempE, $e1
				elseif (roi==1)
					string e2 = basename + "2_E"
					string a2 = basename + "2_A"
					deletepoints nEvent,nPoints, tempA
					deletepoints nEvent,nPoints, tempE
					duplicate/o tempA, $a2
					duplicate/o tempE, $e2
				elseif (roi==2)
					string e3 = basename + "3_E"
					string a3 = basename + "3_A"
					deletepoints nEvent,nPoints, tempA
					deletepoints nEvent,nPoints, tempE
					duplicate/o tempA, $a3
					duplicate/o tempE, $e3
				elseif (roi==3)
					string e4 = basename + "4_E"
					string a4 = basename + "4_A"
					deletepoints nEvent,nPoints, tempA
					deletepoints nEvent,nPoints, tempE
					duplicate/o tempA, $a4
					duplicate/o tempE, $e4
				elseif (roi ==4)
					string e5 = basename + "5_E"
					string a5 = basename + "5_A"
					deletepoints nEvent,nPoints, tempA
					deletepoints nEvent,nPoints, tempE
					duplicate/o tempA, $a5
					duplicate/o tempE, $e5
				elseif (roi==5)
					string e6 = basename + "6_E"
					string a6 = basename + "6_A"
					deletepoints nEvent,nPoints, tempA
					deletepoints nEvent,nPoints, tempE
					duplicate/o tempA, $a6
					duplicate/o tempE, $e6
				endif
			endfor	
		endswitch
		
		killwaves/z decWave,deconMat,data,aHat, decWave, tempE,tempA
end

//////////////////////////////////////////DeconMatMaker///////////////////////////////////

function makeDeconMat()
        
        // finding all of the waves
        string list = wavelist("*_D", ";", "")
        variable nWaves = itemsinlist(list), i
        
        make/o/n=0 deconMat
        for (i=0; i<nWaves; i+=1)
        
        
                  
                string name = stringfromlist(i, list)
                redimension/n=(dimsize($name,0)) $name
                if (faverage ($name) && dimsize($name,0) == 26500)
                        concatenate {$name}, deconMat
                endif
        endfor
        
end

///////////////////////////////////////////////////////// Clustering ////////////////////////////////////////////////////////////


Function clusterButt(ba): ButtonControl
Struct WMButtonAction &ba
	switch(ba.eventCode)
		case 2: 
			print ("You booped Temporal Profile")
			string list=wavelist("*_A",";","DIMS:2")
			string waveName
			prompt waveName, "Select Amplitude Wave", popup,list
			doprompt "Pick your wave", waveName
     		if(V_flag==1)
				Abort
			endif
			
			emGMM(waveName)
		
		endswitch
	end
	


////////////////////////////////////////////////////////////// IEI //////////////////////////////////////////////////////////////

function IEI(ba): ButtonControl
Struct WMButtonAction &ba
	switch(ba.eventCode)
		case 2: 
				// Select Events Wave
			string eList = wavelist("*E",";","")
			string eventName
			prompt eventName, "Select Event Wave", popup, eList
			doprompt "Pick Event Wave", eventName
			if (V_flag==1)
				Abort
			Endif
			
			// Use events string to grab amps string
			string ampName = eventName[0,strlen(eventName)-2] + "AQ"
				
				
			VARIABLE stimStart = 10
			variable stimStop = 40
			prompt stimStart, "Enter stim Start"
			doprompt "Enter stimStart", stimStart
			
			
			if(V_flag==1)
			abort
			endif
			prompt stimStop, "Enter stim Stop"
			doprompt "Enter stimstop", stimStop
			if(V_flag==1)
			abort
			endif
			ieiAnal(eventname, ampname,stimStart, stimStop)
		endswitch
end



//////////////////////////////////////////////////////////// IEI Anal ////////////////////////////////////////////////////////////

function ieiAnal(eventname, ampname,stimStart, stimStop)

	string eventName, ampName
	variable stiMStart, StimStop
	duplicate/o $eventname,events
	duplicate/o $ampName, amps
	
	
	variable nEv = dimsize(events,0)
	make/o/n=(15,nEv) ieiN = NaN
	MAKE/O/N=15 NNQ=0
	variable i,j
	
	for (i=1;i<16;i+=1)
		duplicate/o events, nnEvents

		VARIABLE ONwHICH = 0
		for (j=0;j<nEv;j+=1)
			if (AMPS[J]==I && events[j] > stimStart && events[j] < stimStop)
				NNeVENTS[ONwHICH]= EVENTS[J]
				ONwHICH+=1
			ENDIF
		endfor
		variable nnEv = dimsize(nnEvents,0)
		for (j=1;j<ONwHICH;j+=1)
			ieiN[i-1][j-1] = nnEvents[j]-nnEvents[j-1]
		endfor
	endfor
	KILLWAVES/Z NNeVENTS, AMPS, EVENTS, NNQ
	
	string ieiName = eventName + "_IEI"
	duplicate/o ieiN, $ieiName
	killwaves/z ieiN
end


	
////////////////////////////////////////////////////////////// GTA //////////////////////////////////////////////////////////////

Function GTA(ba) : ButtonControl
	Struct WMButtonAction &ba
	switch(ba.eventcode)
		case 2:
			string executeGTA = "analGTA()"
			execute executeGTA
		break
		case -1:
		break
	endswitch
	return 0
end



////////////////////////////////////////////////////////////// LIF //////////////////////////////////////////////////////////////

Function LIFButt(ba) : ButtonControl
	Struct WMButtonAction &ba
	switch(ba.eventcode)
		case 2:
				// Select Events Wave
			string eList = wavelist("*E",";","")
			string eventName
			prompt eventName, "Select Event Wave", popup, eList
			doprompt "Pick Event Wave", eventName
			if (V_flag==1)
				Abort
			Endif
			
			// Use events string to grab amps string
			string ampName = eventName[0,strlen(eventName)-2] + "AQ"
			lifModel(eventName,ampName)
				case -1:
			break
		endswitch
	return 0
end
			
//////////////////////////////////////////////////// Frequency Analysis Button /////////////////////////////////////////////////

Function freqButt(ba) : ButtonControl
	Struct WMButtonAction &ba
	switch(ba.eventcode)
		case 2:
			string executeFreqAnal = "analFreqWin()"
			execute executeFreqAnal
			break
		case -1:
			break
	endswitch
	return 0
	
End


/////////////////////////////////////////////////// Contrast Analysis Button ////////////////////////////////////////////////////

Function contrastAnalButt(ba) : ButtonControl
	Struct WMButtonAction &ba
	switch(ba.eventcode)
		case 2:
			string executeConAnal = "analConWin()"
			execute executeConAnal
			break
		case -1:
			break
	endswitch
	return 0
	
End
////////////////////////////////////////////////////////////////////////////////////////



//////////////////////////Variable Control////////////////////////

Function variableControl (ctrlName,varNum,varStr,varName) : SetVariableControl
	String ctrlName
	Variable varNum	// value of variable as number
	String varStr		// value of variable as string
	String varName	// name of variable
	variable/G minpeak
	variable/G nPointsforfitting
	variable/G tauDecay
	variable/G unitamp
	variable/G Originalframerate
	variable/G framerateDown
	variable/G SamplesperFrameDown
	variable/G tStart
	variable/G tEnd
	variable/G sepThresh
	
	//string profileName = wavename
	
	strswitch(ctrlname)
	
	case "minPeakThresh":
		minpeak = varnum  	
	break
	
	case "nPointsFit":
		nPointsforfitting = varnum   	
	break
	
	case "tauDecay":
		tauDecay = varnum/1000  	
	break
	
	case "unitAmp":
		unitAmp = varnum 	
	break
	
	case "Originalframerate":
		Originalframerate = varnum 	
	break
	
	case "framerateDown":
		framerateDown = varnum 	
	break
	
	case "SamplesperFrameDown":
		SamplesperFrameDown = varnum 	
	break
	
	case "tStart":
		tStart = varnum 	
	break
	
	case "tEnd":
		tEnd = varnum 	
	break
	
	case "sepThresh":
		sepThresh = varnum
	break
	
	Endswitch
	
End



////////////////////////////////////////////////////////////////////////////////////////
///////////////////////   Function LSPlot(w)    ///////////////////////
//// this code will take a linescan file from scanimage and replot it so that you can see the whole record with time on the x axis and position on the y. 
//// BUT it can also downsample the linescan file as per inputs in panel.
	
	Function LSPlot(w)
	wave w		// input of the ORIGINAL line scan image ending in _oL
	
	String/G OriginalDistName
	String/G out_L 
	String/G DownLinePlotName = out_L + "_L"
	String/G WholeDistName = out_L + "_d"				//This wave is distance (microns) vs time
	//String/G DownLinePlotName = out_L[0,strlen(out_L)-4] + "_L"
	//String/G WholeDistName = out_L[0,strlen(out_L)-4] + "_d"
	
	NVAR FrameRateDown
	NVAR OriginalFrameRate
	variable framerate
	Variable/G SamplesperFrame
	NVAR OriginalSamplesperFrame
	NVAR SamplesperFrameDown
	
	variable i, lx=dimsize(w,0),ly=dimsize(w,1)//,lz=dimsize(w,2)  // counter and length of x, y and z
	
	duplicate/o/FREE w, temp		// duplicate it
	redimension/N=(lx*ly) temp
	redimension/N=(lx,ly) temp
	
	matrixtranspose temp 		// flip the data so that time is on the x axis
	
	///  NB In future we need to deal with issues from two different versions of ScanImage saving data in different ways!!!!!!
	///  Block below pertains to linescans made with free version of Scanimage 
	string notes=note(w)		// get the info from the header to scale the image properly
	variable msPline = str2num(notes[(strsearch(notes,"state.acq.msPerLine=",0)+20),(strsearch(notes,"state.acq.fillFraction=",0)-2) ])
	variable zoom = str2num(notes[(strsearch(notes,"state.acq.zoomFactor=",0)+21),(strsearch(notes,"state.acq.scanAngleMultiplierFast=",0)-2) ])	
	//setscale/I y,0,(610/zoom), temp			// scale the data in space for old linescan method
		
	//setscale/P x,0,(1/framerate), temp		
	
	//string name=nameofwave(w)		//new name for wave
	//string/G DownLinePlotName=(name[0, (strlen(name)-4)])+"_L"
	duplicate/o temp, $DownLinePlotName
	
	//Downsample framerate and samplesperframe if specified in panel
	variable/G downfactor = (OriginalFramerate/FramerateDown)
	Duplicate/O $DownLinePlotName,linePlotTemp;DelayUpdate
	Resample/DOWN=(downfactor) /N=3 linePlotTemp;DelayUpdate
	
	//variable/G ExptDurn
	//ExptDurn=downfactor*(1/frameratedown)*dimsize(linePlotTemp, 0) 
	
	//SetScale /I x, 0, ExptDurn, linePlotTemp  //There is bug in Igor!!!!!!
	
	downfactor = (OriginalSamplesperFrame/SamplesperFrameDown)
	Resample/DIM=1/DOWN=(downfactor)/N=3 linePlotTemp;DelayUpdate
	
	// The distance wave must be similarly downsampled to be used in defining AZs
	Duplicate/O $originalDistName, $WholeDistName
	Interpolate2/T=1/N=(SamplesperFrameDown)/Y=$WholeDistName $originalDistName;DelayUpdate 	
	
	frameRate = FrameRateDown
	SamplesperFrame = SamplesperFrameDown

	Duplicate/O LinePlotTemp, $DownLinePlotName;DelayUpdate
	SetScale /P y, 0, 1,  $DownLinePlotName  //There is bug in Igor!!!!!!
	
	// code below is for making a plot of the data	
	display/K=1/N=Linescan
	appendimage $DownLinePlotName
	Label bottom "Time (s)"
	Label left "Pixel number"
	imagestats temp
	ModifyImage $DownLinePlotName ctab= {*,(V_max*0.7),YellowHot256,0}
	ModifyGraph mirror(left)=0,standoff(left)=0
	ModifyGraph mirror(bottom)=0,standoff(bottom)=0	
	
	//KillWaves/z linePlotTemp, Temp
	
END
////////////////////////////////////////////////////////////////////////////////////////////////////////////


Function newDefineAndTempProf(wavename,coefss,FirstAZNum,chunkNum)
	string wavename,coefss
	variable FirstAZNum
	variable chunkNum
	variable autoAbortSecs = 0
	string profile = (waveName[0, (strlen(waveName)-3)])
	variable i
	string dist = profile+"_d"

	print dist
	
	duplicate/o $wavename, lData
	duplicate/o $coefss, coefs
	duplicate/o $dist, distance
	
	make/o/n=1 aHat
	make/o/n=1 muHat
	make/o/n=1 sigmaHat
	
	for (i=0;i<dimsize(coefs,0)/3;i+=1)
		make/o/n=1 a
		a = coefs[i*3]
		concatenate/NP=0 {a} ,aHat
		make/o/n=1 mu
		mu = coefs[i*3+1]
		concatenate/NP=0 {mu} ,muHat
		make/o/n=1 sig
		sig = coefs[i*3+2]
		//sig = 150
		concatenate/NP=0 {sig} ,sigmaHat
	endfor
	deletepoints/M=0 0,1,aHat
	deletepoints/M=0 0,1,muHat
	deletepoints/M=0 0,1,sigmaHat

	variable yscale = (distance[dimsize(distance, 0)-1]-distance[0])/dimsize(distance, 0)
	variable dt = dimdelta(lData,0)
	variable nPoints = dimsize(lData,0) //time
	variable nX = dimsize(lData,1) //space
	make/o/n=(nX) xS
	for (i=0;i<nX;i+=1)
		xS[i] = i
	endfor
	xS *= yscale
	xS += distance[0]
	variable nROI = dimsize(aHat,0)
	
	
	/// AZs
	make/o/n=(nPoints) tempRoi
	killwaves/z deconMat
	//wave deconMat
	//make/o/n=(nRoi*nPoints) roiDat
	variable j, k
	make/o/n=(nX) gaussExtract=0
	setscale/p x, distance[0], yscale, gaussExtract
	duplicate/o gaussExtract, singleGauss
	for (i=0;i<nRoi;i+=1)
		tempRoi =0
		singleGauss=0
		for (j=0;j<nPoints;j+=1) //time
			for (k=0;k<nX;k+=1) //space
				//tempRoi[j] += lData[j][k] *aHat[i] * (2 * pi * sigmaHat[i])^-.5 * exp(-(xS[k]-muHat[i])^2/(2 * sigmaHat[i]))
				tempRoi[j] += lData[j][k] *aHat[i] / (sigmaHat[i]*(2*pi)^0.5) * exp(-0.5*((xs[k]-muHat[i])/sigmaHat[i])^2)
				gaussExtract[k] += aHat[i] / (sigmaHat[i]*(2*pi)^0.5) * exp(-0.5*((xs[k]-muHat[i])/sigmaHat[i])^2)
				singlegauss[k] += aHat[i] / (sigmaHat[i]*(2*pi)^0.5) * exp(-0.5*((xs[k]-muHat[i])/sigmaHat[i])^2)
			endfor
		endfor
		concatenate/np=1 {tempRoi}, roiDat
		duplicate/o singleGauss, $("gaussExtract_"+num2str(chunkNum)+"_"+num2str(i))
	endfor
	
	string gaussName = "gaussExtract_"  + num2str(chunkNum)
	duplicate/o gaussExtract, $gaussName	
	
	
	string azName1 = (waveName[0, (strlen(waveName)-5)])+"_AZ"+num2str(FirstAZNum)
	string decon1 = azName1 + "_D"
	
	duplicate/o/RMD=[][0] roiDat, $azName1
	setscale/P x,0,dt, $azName1
	BaseCorrection(azName1)
	//DeltaF(azName1)
	DeltaFWindow(azName1, 1, 2)
	newWiener(azName1)
	concatenate/o/np=1 {$decon1}, deconMat
	
	display/k=1 $decon1 as "Temporally Deconvolved AZ"+num2str(FirstAZNum)
	label left "Deconvolved Amplitude"
	label bottom "Time (s)"
	
	if (nRoi>=2)
		string azName2 = waveName[0, (strlen(waveName)-5)]+"_AZ"+num2str(FirstAZNum+1)
		duplicate/o/RMD=[][1] roiDat, $azName2
		setscale/P x,0,dt, $azName2
		
		BaseCorrection(azName2)
		//DeltaF(azName2)
		DeltaFWindow(azName2, 1, 2)
		newWiener(azName2)
		string decon2 = azName2 + "_D"
		concatenate/np=1 {$decon2}, deconMat
		//print decon2
		display/k=1 $decon1 as "Temporally Deconvolved AZ"+num2str(FirstAZNum+1)
		label left "Deconvolved Amplitude"
		label bottom "Time (s)"
	endif
	
	if (nRoi>=3)
		string azName3 = waveName[0, (strlen(waveName)-5)]+"_AZ"+num2str(FirstAZNum+2)
		duplicate/o/RMD=[][2] roiDat, $azName3
		setscale/P x,0,dt, $azName3
		BaseCorrection(azName3)	
		//DeltaF(azName3)
		DeltaFWindow(azName3, 1, 2)
		newWiener(azName3)
		string decon3 = azName3 + "_D"
		concatenate/np=1 {$decon3}, deconMat
		display/k=1 $decon1 as "Temporally Deconvolved AZ"+num2str(FirstAZNum+2)
		label left "Deconvolved Amplitude"
		label bottom "Time (s)"
	endif
	
	if (nRoi >=4)
		string azName4 = waveName[0, (strlen(waveName)-5)]+"_AZ"+num2str(FirstAZNum+3)
		
		duplicate/o/RMD=[][3] roiDat, $azName4
		setscale/P x,0,dt, $azName4
		
		BaseCorrection(azName4)
		//DeltaF(azName4)
		DeltaFWindow(azName4, 1, 2)
		newWiener(azName4)
		string decon4 = azName4 + "_D"
		concatenate/np=1 {$decon4}, deconMat
		display/k=1 $decon1 as "Temporally Deconvolved AZ"+num2str(FirstAZNum+3)
		label left "Deconvolved Amplitude"
		label bottom "Time (s)"
	endif
	
	if (nROI >=5)
		string azName5 = waveName[0, (strlen(waveName)-5)]+"_AZ"+num2str(FirstAZNum+4)
	
		duplicate/o/RMD=[][4] roiDat, $azName5
		setscale/P x,0,dt, $azName5
		BaseCorrection(azName5)
		//DeltaF(azName5)
		DeltaFWindow(azName5, 1, 2)
		newWiener(azName5)
		string decon5 = azName5 + "_D"
		concatenate/np=1 {$decon5}, deconMat
		display/k=1 $decon1 as "Temporally Deconvolved AZ"+num2str(FirstAZNum+4)
		label left "Deconvolved Amplitude"
		label bottom "Time (s)"
	endif
	
	if (nRoi>=6)
		string azName6 = waveName[0, (strlen(waveName)-5)]+"_AZ"+num2str(FirstAZNum+5)
		duplicate/o/RMD=[][5] roiDat, $azName6
		setscale/P x,0,dt, $azName6
		BaseCorrection(azName6)
		//DeltaF(azName6)
		DeltaFWindow(azName6, 1, 2)
		newWiener(azName6)
		string decon6 = azName6 + "_D"
		concatenate/np=1 {$decon6}, deconMat
		display/k=1 $decon1 as "Temporally Deconvolved AZ"+num2str(FirstAZNum+5)
	label left "Deconvolved Amplitude"
	label bottom "Time (s)"
	endif
	
	
	
	string roiMat = (waveName[0,strlen(waveName)-3]) + "_roiDatMat"
	duplicate/o roiDat, $roiMat
	string baseWaveName = (waveName[0,strlen(wavename)-3])
	killwaves aHat,lData,muHat,sigmaHat,tempRoi,roiDat
	string deconMatName = (waveName[0,strlen(wavename)-3]) + "_deconMat"
	duplicate/o deconMat, $deconMatName
	killwaves/z deconMat
	killwaves/z xS
	
	end
	
	
	
	
////////////////////////////////////////

Function newDefine(wavename)
	string wavename
	variable autoAbortSecs = 0
	variable mu1,mu2,mu3,mu4,mu5,mu6
	variable A1,A2,A3,A4,A5,A6
	string muName = (waveName[0, (strlen(waveName)-3)])+"_muHat"
	string AName = (waveName[0, (strlen(waveName)-3)])+"_AHat"
	string out=(waveName[0, (strlen(waveName)-3)])+"_profile"
	string coefName = (waveName[0,strlen(waveName)-3])+"_Coef"
	string fitName =(waveName[0,strlen(waveName)-3])+"_fit"
	string spatFilt = (waveName[0,strlen(waveName)-3])+"_SF"
	string sigmaHatName = (waveName[0,strlen(waveName)-3])+"_sigmaHat"
	
	///////////////////
	variable/G background				//This is a global variable that will be used in Temporal Profile to correct for background
	///////////////////
	
	duplicate/o $waveName $out
	duplicate/o $waveName w1
         
   make/o/n=(dimsize(w1,1)) w2
   matrixop/o w2=sumCols(w1)
   w2 = w2/(dimsize(w2, 1))
   make/o/n=(dimsize(w2,1)) w3
   w3=w2[0][p]
   variable sm = mean(w3)
   background = wavemin(w3) 
 
   w3-=background
   variable sw = WAVEMAX(w3)
   //w3-=sm
   w3/=sw									//Here we normalize the profile to a maximum of 1
   variable i
   for (i=0;i<dimsize(w3,0);i+=1)
   	if (w3[i]<0)
   		w3[i] =0
   	endif
   endfor
   
   duplicate/o w3 $out
  
   display/k=1/N=Profilee $out
   Legend/C/N=text0/J/F=0/A=RT "\\f01\\Z14Define AZ means with cursors and close window"
   ShowInfo/CP={0,1,2}/W=Profilee
   MoveWindow/W=Profilee 0, 400, 600, 600
   
   
   ///////////Cursor Input ///////////////////////////////////////////
   if (UserCursorAdjust("Profilee",autoAbortSecs)!=0)
   	return -1
   endif
   
   mu1 = pcsr(A)
   A1= vcsr(A)
   /// CSR 2, if there
   string csrResult
   csrResult=CsrInfo(B,"Profile")
   if (cmpstr(csrResult,"")==0)
   	mu2 = 0
   	A2 = 0
   else
   	mu2 = pcsr(B)
   	A2 = vCsr(B)
   endif
   
   //Csr 3, if there
   csrResult=CsrInfo(C,"Profile")
    if (cmpstr(csrResult,"")==0)
   	mu3 = 0
   	A3 = 0
   else
   	mu3 = pcsr(C)
   	A3 = vCsr(C)
   endif
   
   //Csr 4, if there
   csrResult=CsrInfo(D,"Profile")
    if (cmpstr(csrResult,"")==0)
   	mu4 = 0
   	A4 = 0
   else
   	mu4 = pcsr(D)
   	A4 = vCsr(D)
   endif
   
   //Csr 5, if there
   csrResult=CsrInfo(E,"Profile")
    if (cmpstr(csrResult,"")==0)
   	mu5 = 0
   	A5 = 0
   else
   	mu5 = pcsr(E)
   	A5 = vCsr(E)
   endif
   
   //Csr 6, if there
   csrResult=CsrInfo(F,"Profile")
    if (cmpstr(csrResult,"")==0)
   	mu6 = 0
   	A6 =  0
   else
   	mu6 = pcsr(F)
   	A6 = vcsr(F)
   endif
   
   make/o/n=6 tmpMu, tmpA
   tmpMu = {mu1,mu2,mu3,mu4,mu5,mu6}
   tmpA = {A1,A2,A3,A4,A5,A6}
   findValue/z/v=0 tmpMu
   variable firstZero = V_Value
   print firstZero
   deletePoints firstZero, 6-firstZero, tmpMu
   deletePoints firstZero, 6-firstZero, tmpA
	DoWindow/K Profile
	Killwaves w1,w2,w3
	duplicate/o tmpMu, $muName
	duplicate/o tmpA, $AName
	killwaves tmpMu, tmpA
	fitGauss(out,muName,aName)
	Display/k=1/n=fitGraph $out as "Gaussian Mixture Fit"
	print fitName
	print spatFilt
	AppendToGraph $fitName
	Label left "Normalized Intensity";DelayUpdate
	Label bottom "Location (pixels)"
	ModifyGraph rgb($fitName)=(0,0,0)
	Legend/C/N=text1/A=MC

	
	
   end
   ///////////////////////////////////////////////////////////////
   Function newnewDefineAndTempProf(wavename,regExpCoef,FirstAZNum,chunkNum)
	string wavename, regExpCoef
	variable FirstAZNum
	variable chunkNum
	variable autoAbortSecs = 0
	string profile = (waveName[0, (strlen(waveName)-3)])
	variable i
	string dist = profile+"_d"

	print dist
	
	duplicate/o $wavename, lData
	duplicate/o $regExpCoef, coefs
	duplicate/o $dist, distance
	
	make/o/n=1 aHat
	make/o/n=1 muHat
	make/o/n=1 sigmaHat
	
	for (i=0;i<dimsize(coefs,0)/3;i+=1)
		make/o/n=1 a
		a = coefs[i*3]
		concatenate/NP=0 {a} ,aHat
		make/o/n=1 mu
		mu = coefs[i*3+1]
		concatenate/NP=0 {mu} ,muHat
		make/o/n=1 sig
		sig = coefs[i*3+2]
		//sig = 150
		concatenate/NP=0 {sig} ,sigmaHat
	endfor
	deletepoints/M=0 0,1,aHat
	deletepoints/M=0 0,1,muHat
	deletepoints/M=0 0,1,sigmaHat

	variable yscale = (distance[dimsize(distance, 0)-1]-distance[0])/dimsize(distance, 0)
	variable dt = dimdelta(lData,0)
	variable nPoints = dimsize(lData,0) //time
	variable nX = dimsize(lData,1) //space
	make/o/n=(nX) xS
	for (i=0;i<nX;i+=1)
		xS[i] = i
	endfor
	xS *= yscale
	xS += distance[0]
	variable nROI = dimsize(aHat,0)
	
	
	/// AZs
	make/o/n=(nPoints) tempRoi
	killwaves/z deconMat
	make/o/n=0 RoiDat
	//wave deconMat
	//make/o/n=(nRoi*nPoints) roiDat
	variable j, k
	make/o/n=(nX) gaussExtract=0
	make/o/n=(nX) gaussIgorExtract=0
	
	setscale/p x, distance[0], yscale, gaussExtract
	duplicate/o gaussExtract, singleGauss
	for (i=0;i<nRoi;i+=1)
		tempRoi =0
		singleGauss=0
			variable muIgor = (muhat[i]-distance[0])/yscale
			variable sigma = sigmahat[i]/yscale
			make/o/n=(nX) gaussIGOR=gauss(x,muIgor,sigma)*ahat[i]
			gaussigorextract += gaussigor
		for (j=0;j<nPoints;j+=1) //time
			for (k=0;k<nX;k+=1) //space
				//tempRoi[j] += lData[j][k] *aHat[i] * (2 * pi * sigmaHat[i])^-.5 * exp(-(xS[k]-muHat[i])^2/(2 * sigmaHat[i]))
				tempRoi[j] += lData[j][k] *aHat[i] / (sigmaHat[i]*(2*pi)^0.5) * exp(-0.5*((xs[k]-muHat[i])/sigmaHat[i])^2)
				gaussExtract[k] += aHat[i] / (sigmaHat[i]*(2*pi)^0.5) * exp(-0.5*((xs[k]-muHat[i])/sigmaHat[i])^2)
				singlegauss[k] += aHat[i] / (sigmaHat[i]*(2*pi)^0.5) * exp(-0.5*((xs[k]-muHat[i])/sigmaHat[i])^2)
			endfor
		endfor
		concatenate/np=1 {tempRoi}, roiDat
		duplicate/o singleGauss, $("gaussExtract_"+num2str(chunkNum)+"_"+num2str(i))
		duplicate/o GaussIgor, $("gaussIgor_"+num2str(chunkNum)+"_"+num2str(i))
	endfor
	
	string gaussName = "gaussExtract_"  + num2str(chunkNum)
	duplicate/o gaussExtract, $gaussName	
	
	make/O/N=(nPoints) Temptrace1
	make/o/n=0 DeconMat
	for (i=0; i<nRoi; i+=1)
		temptrace1=0
		TempTrace1[]=roiDat[p][i]
		setscale/P x,0,dt, Temptrace1
		duplicate/o TempTrace1, $(wavename[0, (strlen(wavename)-3)]+"_AZ"+num2str(i)),$(wavename[0, (strlen(wavename)-3)]+"_AZ"+num2str(i)+"_RAW")
		BaseCorrection((wavename[0, (strlen(wavename)-3)]+"_AZ"+num2str(i)))
		DeltaFWIndow((wavename[0, (strlen(wavename)-3)]+"_AZ"+num2str(i)),1,2)
		//DeltaF(wavename[0, (strlen(wavename)-3)]+"_AZ"+num2str(i))
		NewWiener(wavename[0, (strlen(wavename)-3)]+"_AZ"+num2str(i))
		concatenate/np=1 {$(wavename[0, (strlen(wavename)-3)]+"_AZ"+num2str(i)+"_D")}, deconMat
		display/k=1 $(wavename[0, (strlen(wavename)-3)]+"_AZ"+num2str(i)+"_D") as "Temporally Deconvolved AZ"+num2str(i)
		label left "Deconvolved Amplitude"
		label bottom "Time (s)"
		
	Endfor
	
	
	END
////////////////////////////////////////////////////////////////////////////////////////////////////////////