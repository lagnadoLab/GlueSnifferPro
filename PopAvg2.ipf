#pragma rtGlobals=1		// Use modern global access method.



//||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

function PopAvg2(popwave)

wave popwave
String wavename = NameofWave(popwave) 
String AVGWaveName = wavename + "_avg"
String SEMWaveName = wavename + "_sem"
String SDWaveName = wavename + "_sd"

variable ydim = dimsize(popwave, 1)
variable deltat=DimDelta(popwave, 0)	
variable xdim =  dimsize(popwave, 0)
variable starttime=pnt2x(popwave,0)

variable counter, c2, npoints, ii, k

make /o/n=(xdim) cw, ncounts, SEMWave, SDwave
Make/O/N=(xdim, ydim) temp_pop, temp_pop1
SetScale/P x 0,deltat,"",cw, temp_pop

temp_pop1[][] = popwave[p][q]


for(ii=0;ii<xdim;ii+=1)
		WaveStats/Q/RMD=[ii][] temp_pop1
		//SEMWave[ii]=V_sem
		//SDwave[ii]=V_sdev
		cw[ii]=V_avg
endfor

setscale/P x,starttime,deltat, cw,SEMWave 
duplicate/O cw, $AVGWaveName
//duplicate/O SEMWave, $SEMWaveName
//duplicate/O SDWave, $SDWaveName
Display/K=1 $AVGWaveName
ErrorBars $AVGWaveName SHADE= {0,0,(0,0,0,0),(0,0,0,0)},wave=($SEMWaveName,$SEMWaveName)
killwaves cw
end
//|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||


//||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

function PopNormAvg(popwave)

wave popwave
String wavename = NameofWave(popwave) 
String AVGWaveName = wavename + "_avg"
String SEMWaveName = wavename + "_sem"
String SDWaveName = wavename + "_sd"

variable ydim = dimsize(popwave, 1)
variable deltat=DimDelta(popwave, 0)	
variable xdim =  dimsize(popwave, 0)
variable starttime=pnt2x(popwave,0)

variable counter, c2, npoints, ii, j, k

make /o/n=(xdim) cw, ncounts, SEMWave, SDwave
Make/O/N=(xdim, ydim) temp_pop, temp_pop, temp_pop1
SetScale/P x 0,deltat,"",cw, temp_pop
Duplicate/O popwave, pop_smth, pop_norm
Smooth 3, pop_smth;DelayUpdate 


for(j=0;j<ydim;j+=1)
		Duplicate/O/RMD=[][j] pop_smth, ROI_smth 
		WaveStats/Q ROI_smth 
		ROI_smth/=V_max
		pop_norm[][j]=ROI_smth[p]
endfor

for(ii=0;ii<xdim;ii+=1)
		WaveStats/Q/RMD=[ii][] pop_norm
		SEMWave[ii]=V_sem
		SDwave[ii]=V_sdev
		cw[ii]=V_avg
endfor

setscale/P x,starttime,deltat, cw,SEMWave 
duplicate/O cw, $AVGWaveName
duplicate/O SEMWave, $SEMWaveName
duplicate/O SDWave, $SDWaveName
Display/K=1 $AVGWaveName
ErrorBars $AVGWaveName SHADE= {0,0,(0,0,0,0),(0,0,0,0)},wave=($SDWaveName,$SDWaveName)
killwaves cw
end
//|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||



//||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

function AINormAvg(popwave, AIwave)

wave popwave, AIwave
//string add
String newwavename = NameofWave(AIwave) + "_AI" 
String AVGWaveName = newwavename + "_avg"//+add
String SEMWaveName = newwavename + "_sem"//+add
String SDWaveName = newwavename + "_sd"//+add

//String AvgWaveName = NameOfWave(wavenums) + "_avg"

variable deltat=DimDelta(popwave, 0)	
variable xdim = dimsize(popwave, 0)
Variable nROIs=DimSize(popwave,1)
Variable nPop=DimSize(popwave,1)


variable counter, c2, npoints, ii, j, k
variable nwavesused = 0


Make/O/N=(xdim, nROIs) temp_pop, temp_pop2
SetScale/P x 0,deltat,"", temp_pop, temp_pop2

Duplicate/O popwave, pop_smth, pop_norm
Smooth/S=3, 11, pop_smth;DelayUpdate
 
for(j=0;j<nROIs;j+=1)
		Duplicate/O/RMD=[][j] pop_smth, ROI_smth
		Redimension/N=-1 ROI_smth
		//WaveStats/Q ROI_smth 
		//ROI_smth/=V_max
		ROI_smth/=wavemax(ROI_smth, 70, 74)
		temp_pop[][j]=ROI_smth[p]
endfor

for(ii=0;ii<nROIs;ii+=1)
	k=AIwave[ii]
	if((k>-1) && (k<1))
		Duplicate/O/R=[0, xdim-1][ii] temp_pop, temp_wave
		Redimension/N=-1 temp_wave
		temp_pop2[][nWavesUsed]=temp_wave[p]
		nWavesUsed+=1
	endif	
endfor

print nwavesused-1
DeletePoints/M=1 nwavesused-1, nROIs, temp_pop2
//temp_pop2/=(nWavesUsed-1)
Duplicate/O temp_pop2, $newwavename

PopAvg2($newwavename)

//killwaves temp_pop2
end
//|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||



//||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
function PopAvgRange(popwave, first, last)

wave popwave
variable first,last
//string target

//String SEMWaveName = target + "_sem"
//String AvgWaveName = target
String AvgWaveName = nameofWave(popwave) + "_avg_"+num2str(first)+"_to_"+num2str(last)
string SEMWaveName = nameofWave(popwave) + "_SEM_"+num2str(first)+"_to_"+num2str(last)

//variable nROIs = dimsize(popwave, 1)
variable deltat=DimDelta(popwave, 0)	
variable npoints =  dimsize(popwave, 0)
variable i, j, k
variable nWaves = first-last

//Copy the range from the popwave

Make/O/N=(npoints) AvgWave, SEMWave, temp_pop
SetScale/P x 0,deltat,"", temp_pop, AvgWave, SEMWave
Duplicate/O/RMD=[][first, last] popwave, temp_pop

//This is the average over all waves in temp_pop
	for(i=0;i<npoints;i+=1)
		WaveStats/Q/RMD=[i][] temp_pop
		SEMWave[i]=V_sem
		AvgWave[i]=V_avg
	endfor

Duplicate/O AvgWave $AvgWaveName
Duplicate/O SEMWave $SEMWaveName
Display/K=1 $AvgWaveName

Killwaves AvgWave, SEMWave, temp_pop

end
//||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||




//||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||//
//||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
//Input is a 2D popwave and a wave that contais a list of the ROI numbers of the 1D waves to average.
//Output is put in a wave thattakes name of wavnums and adds "_avg"
//Leon 4/3/2019

Function PopAvgfromList(popwave, wavenums)	
	wave popwave, wavenums
	
	String AvgWaveName = NameOfWave(wavenums) + "_avg"
	
	//Duplicate/O wavenums $AvgPopWaveName
	variable npoints, ii, k
	variable nwaves
	variable nWavesUsed=0
	variable deltat=DimDelta(popwave, 0)	

	//Preferences 1
	npoints=DimSize(popwave,0)
	nwaves=DimSize(wavenums,0)

	Make/O/N=(npoints) AvWave=0
	setscale/P x,0,deltat, AvWave
	
	for(ii=0;ii<nwaves;ii+=1)
		k=wavenums[ii]
		if(numtype(k)==0)
			Duplicate/O/R=[0, npoints-1][k] popwave, tempwave
			AvWave+= tempwave
			nWavesUsed+=1
		endif	
	endfor
	
AvWave/=nWavesUsed
print nwavesused

Duplicate/O AvWave $AvgWaveName
Display/K=1 $AvgWaveName;DelayUpdate
//AppendImage $AvgWaveName

Killwaves AvWave, tempwave

END


//||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

function PopAvgCycle(popwave, target, cycleTime, nCycles)

wave popwave
string target
variable cycleTime, nCycles  //cyclelength is in points

String AllCyclesAvgWaveName = target + "_Allcycles_avg"
String AllCyclesAvgQAWaveName = target + "_QA_avg"
String AllCyclesSEMWaveName = target + "_Allcycles_sem"

variable nROIs = dimsize(popwave, 1)
variable deltat=DimDelta(popwave, 0)	
variable xdim =  dimsize(popwave, 0)
variable cycleLength=cycleTime/deltat
variable offsetPnts=cycleLength/4

variable counter, c2, npoints, ii, j, k

Make/O/N=(cycleLength, (nROIs*nCycles)),  QA_Allcycles
Make/O/N=(cycleLength, nROIs),  QA_Onecycle
SetScale/P x 0,deltat,"",QA_cycles

for(j=0; j<(nROIs); j+=1)
	for(k=0; k<(nCycles); k+=1)
		//for(ii=0; ii<xdim; ii+=1)
				QA_Allcycles[][(j*ncycles)+k]=popwave[(k*cycleLength+offsetPnts)+p][j]
		//endfor
	endfor
endfor


make /o/n=(cycleLength) cw, ncounts, SEMWave
Make/O/N=(cycleLength, nROIs*nCycles) temp_pop, temp_pop1
SetScale/P x 0,deltat,"",cw, temp_pop


temp_pop1[][] = QA_Allcycles[p][q]
//This is the average over all trials and ROIs
for(ii=0;ii<xdim;ii+=1)
		WaveStats/Q/RMD=[ii][] temp_pop1
		SEMWave[ii]=V_sem
		cw[ii]=V_avg
endfor

setscale/P x,0,deltat, cw,SEMWave 
duplicate/O cw, $AllCyclesAvgWaveName 
duplicate/O SEMWave, $AllCyclesSEMWaveName
Display/K=1 $AllCyclesAvgWaveName
ErrorBars $target SHADE= {0,0,(0,0,0,0),(0,0,0,0)},wave=($AllCyclesSEMWaveName,$AllCyclesSEMWaveName)

//This is the average over ROIs
for(j=0; j<nROIs; j+=1)
	Duplicate/O/RMD=[][j, j+ncycles] QA_Allcycles, temp_pop1
	for(ii=0;ii<cyclelength;ii+=1)
		WaveStats/Q/RMD=[ii][] temp_pop1
		//SEMWave[ii]=V_sem
		QA_Onecycle[ii][j]=V_avg
	endfor
endfor

setscale/P x,0,deltat, QA_Onecycle 
duplicate/O QA_Onecycle, $AllCyclesAvgQAWaveName
//duplicate/O SEMWave, $SEMWaveName
Display/K=1;DelayUpdate
AppendImage $AllCyclesAvgQAWaveName
ModifyImage $AllCyclesAvgQAWaveName ctab= {0,4,Grays,0}
//Display/K=1 $AllCyclesAvgQAWaveName
//ErrorBars $target SHADE= {0,0,(0,0,0,0),(0,0,0,0)},wave=($SEMWaveName,$SEMWaveName)

killwaves cw
end
//|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||



//|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
function PopAvg(popwave, target)

wave popwave
string target

variable xdim, ydim = dimsize(popwave, 1)
variable counter, c2

xdim =  dimsize(popwave, 0)

make /o/n=(xdim) cw = popwave[p][0]



for (counter=1;counter<ydim;counter+=1)

 cw[] +=  popwave[p][counter]
c2 +=1
endfor

cw /= ydim


duplicate cw, $target
killwaves cw
end