#pragma TextEncoding = "UTF-8"
#pragma rtGlobals=3		// Use modern global access method and strict wave access.





Function fitGauss(wavename,muHat,aName)
// This is the code to fit guassian CURVES (not distributions) to the 
// temporal average of iGluSnFR linescans
// This code uses Igor's built-in curve-fitting software. If it doesn't work, don't blame me.
string waveName,muHat, aName
string/G fitcoefsName = waveName+"_fitCoefs"
//string distName = (waveName[0,strlen(waveName)-8])+"Coef"

//string fitName =(waveName[0,strlen(waveName)-8])+"fit"
//string spatFilt = (waveName[0,strlen(waveName)-8])+"SF"
//string sigmaHatName = (waveName[0,strlen(waveName)-8])+"sigmaHat"
//string fitName =waveName+"_fit"
string spatFilt = waveName+"_SF"
string sigmaHatName = waveName+"_sigmaHat"
duplicate/o $muHat, tmpMu
duplicate/o $aName, tmpA
duplicate/o $waveName, dat //tPntProfile (profile at each time point)
variable k = dimsize(tmpMu,0)
Variable Sigma = 70

make/o/n=(3*k) W_coef
// Attempt to make the convergence paramters better below...doesn't really work
Variable/g  V_FitMaxIters =2000
Variable/g V_FitTol = 0.000011
Variable/g V_FitOPtions = 1
W_Coef = 10
variable muBand = 2

//For each possible number of gaussians to fit, initialize values (means by cursors)
// and constraints
if (k==1)
	w_coef[0] = tmpA[0]
	W_Coef[1]= tmpMu[0]
	W_Coef[2]= Sigma
	Make/o/T/N=3 T_constraints
	string c1 = "k1<"+num2str((tmpMu[0]+muBand))
	string c2 = "k1>"+num2str((tmpMu[0]-muBand))
	T_Constraints[0] = {"K0>0",c1,c2}
	//FuncFit/Q/H="011" gauss1 W_Coef DAT /X=$distWaveName /D /C=T_Constraints 
	duplicate/o DAT, DAT_fit
	//FuncFit/Q/H="000" gauss1 W_Coef DAT /D=DAT_fit /X=$distWaveName /C=T_Constraints 
	FuncFit/Q/H="000" gauss1 W_Coef DAT /D /C=T_Constraints 
	makeData(W_Coef)
elseif (k==2)
	W_Coef[0] = tmpA[0]
	W_coef[1] = tmpA[1]
	W_Coef[2] = tmpMu[0]
	W_coef[3] = tmpMu[1]
	W_Coef[4]= Sigma
	W_Coef[5]= Sigma
	Make/O/T/N=6 T_Constraints
	 c1 = "k2<"+num2str((tmpMu[0]+muBand))
	 c2 = "k2>"+num2str((tmpMu[0]-muBand))
	string c3 = "k3<"+num2str((tmpMu[1]+muBand))
	string c4 = "k3>"+num2str((tmpMu[1]-muBand))
	T_Constraints[0] = {"K0 > 0","K1 > 0",c1,c2,c3,c4}
	FuncFit/Q/H="000000" gauss2 W_coef DAT /D /C=T_Constraints 
	makeData(W_Coef)
elseif (k==3)
	W_coef[0] = tmpA[0]
	W_Coef[1] = tmpA[1]
	W_coef[2] = tmpA[2]
	W_coef[3] = tmpMu[0]
	W_coef[4] = tmpMu[1]
	W_coef[5] = tmpMu[2]
	W_Coef[6]= Sigma
	W_Coef[7]= Sigma
	W_Coef[8]= Sigma
	c1 = "k3<"+num2str((tmpMu[0]+muBand))
	c2 = "k3>"+num2str((tmpMu[0]-muBand))
	c3 = "k4<"+num2str((tmpMu[1]+muBand))
	c4 = "k4>"+num2str((tmpMu[1]-muBand))
	string c5 = "k5<"+num2str((tmpMu[2]+muBand))
	string c6 = "k5>"+num2str((tmpMu[2]-muBand))
	Make/O/T/N=9 T_Constraints
	T_Constraints[0] = {"K0 > 0","K1 > 0","K2 > 0",c1,c2,c3,c4,c5,c6}
	FuncFit/Q/H="000000000" gauss3 W_coef dat /D /C=T_Constraints 
	makedata(w_Coef)
elseif (k==4)
	W_coef[0] = tmpA[0]
	W_Coef[1] = tmpA[1]
	W_coef[2] = tmpA[2]
	W_Coef[3] = tmpA[3]
	W_coef[4] = tmpMu[0]
	W_coef[5] = tmpMu[1]
	W_coef[6] = tmpMu[2]
	W_Coef[7] = tmpMu[3]
	W_Coef[8]= Sigma
	W_Coef[9]= Sigma
	W_Coef[10]= Sigma
	W_Coef[11]= Sigma
	Make/O/T/N=12 T_Constraints
	c1 = "k4<"+num2str((tmpMu[0]+muBand))
	c2 = "k4>"+num2str((tmpMu[0]-muBand))
	c3 = "k5<"+num2str((tmpMu[1]+muBand))
	c4 = "k5>"+num2str((tmpMu[1]-muBand))
	c5 = "k6<"+num2str((tmpMu[2]+muBand))
	c6 = "k6>"+num2str((tmpMu[2]-muBand))
	string c7 = "k7>"+num2str((tmpMu[3]-muBand))
	string c8 = "k7<"+num2str((tmpMu[3]+muBand))
	T_Constraints[0] = {"K0 > 0","K1 > 0","K2 > 0","K3>0",c1,c2,c3,c4,c5,c6,c7,c8}
	FuncFit/Q/H="000000000000" gauss4 W_coef dat /D /C=T_Constraints 
	makedata(W_Coef)
elseif (k==5)
	W_coef[0] = tmpA[0]
	W_Coef[1] = tmpA[1]
	W_coef[2] = tmpA[2]
	W_Coef[3] = tmpA[3]
	W_coef[4] = tmpA[4]
	W_coef[5] = tmpMu[0]
	W_coef[6] = tmpMu[1]
	W_coef[7] = tmpMu[2]
	w_Coef[8] = tmpMu[3]
	w_coef[9] = tmpMu[4]
	W_Coef[10]= Sigma
	W_Coef[11]= Sigma
	W_Coef[12]= Sigma
	W_Coef[13]= Sigma
	W_Coef[14]= Sigma
	Make/O/T/N=15 T_Constraints
	c1 = "k5<"+num2str((tmpMu[0]+muBand))
	c2 = "k5>"+num2str((tmpMu[0]-muBand))
	c3 = "k6<"+num2str((tmpMu[1]+muBand))
	c4 = "k6>"+num2str((tmpMu[1]-muBand))
	c5 = "k7<"+num2str((tmpMu[2]+muBand))
	c6 = "k7>"+num2str((tmpMu[2]-muBand))
	c7 = "k8>"+num2str((tmpMu[3]-muBand))
	c8 = "k8<"+num2str((tmpMu[3]+muBand))
	string c9 = "k9>" +num2str(tmpMu[4]-muBand)
	string c10 = "k9<" +num2str(tmpMu[4]+muBand)
	k10=Sigma
	k11=Sigma
	k12=Sigma
	k13=Sigma
	k14=Sigma
	
	//string c11 = "k10=" +num2str(Sigma)
	//string c12 = "k11=" +num2str(Sigma)
	//string c13 = "k12=" +num2str(Sigma)
	//string c14 = "k13=" +num2str(Sigma)
	//string c15 = "k14=" +num2str(Sigma)
	T_Constraints[0] = {"K0 > 0","K1 > 0","K2 > 0","K3>0","K4>0",c1,c2,c3,c4,c5,c6,c7,c8,c9,c10}
	FuncFit/Q/H="000000000000000" gauss5 W_coef dat /D /C=T_Constraints 
	makeData(W_coef)
elseif (k==6)
	w_coef[6] = tmpMu[0]
	W_coef[7] = tmpMu[1]
	W_coef[8] = tmpMu[2]
	W_coef[9] = tmpMu[3]
	w_Coef[10] = tmpMu[4]
	w_coef[11] = tmpMu[5]
	W_coef[0] = tmpA[0]
	W_Coef[1] = tmpA[1]
	W_coef[2] = tmpA[2]
	W_Coef[3] = tmpA[3]
	W_coef[4] = tmpA[4]
	W_coef[5] = tmpA[5]
	W_Coef[12]= Sigma
	W_Coef[13]= Sigma
	W_Coef[14]= Sigma
	W_Coef[15]= Sigma
	W_Coef[16]= Sigma
	W_Coef[17]= Sigma
	c1 = "k6<"+num2str((tmpMu[0]+muBand))
	c2 = "k6>"+num2str((tmpMu[0]-muBand))
	c3 = "k7<"+num2str((tmpMu[1]+muBand))
	c4 = "k7>"+num2str((tmpMu[1]-muBand))
	c5 = "k8<"+num2str((tmpMu[2]+muBand))
	c6 = "k8>"+num2str((tmpMu[2]-muBand))
	c7 = "k9>"+num2str((tmpMu[3]-muBand))
	c8 = "k9<"+num2str((tmpMu[3]+muBand))
	c9 = "k10>" +num2str(tmpMu[4]-muBand)
	c10 = "k10<" +num2str(tmpMu[4]+muBand)
	String c11= "k11>"+num2str(tmpMu[5]-muBand)
	String c12= "k11<"+num2str(tmpMu[5]+muBand)
	Make/O/T/N=18 T_Constraints
	T_Constraints[0] = {"K0 > 0","K1 > 0","K2 > 0","K3>0","K4>0","K5>0",c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12}
	FuncFit/Q/H="000000000000000000" gauss6 W_coef dat /D /C=T_Constraints 
	
endif
wave fit_dat, sumDat, xS, data, sigma2, mu
duplicate/o W_Coef, $fitcoefsName
//duplicate/o fit_dat, $fitName
duplicate/o data, $spatFilt
duplicate/o sigma2, $sigmaHatName
//killwaves W_Coef, dat, fit_dat, sumDat, tmpMu, tmpA, xS, sigma2, mu
//killwaves/z T_Constraints, data, A

end
	
	




Function makeData(w_Coef)
//Initialize some shit
wave W_Coef
variable k = dimsize(W_Coef,0)/3
variable xLen = 128
make/o/n=(xLen) xS
variable i
for (i=0;i<xLen;i+=1)
	xS[i] = i
endfor
make/o/n=(k) mu, sigma2,A
if (k==1)
	A = {W_Coef[0]}
	mu = {W_Coef[1]}
	sigma2 = {w_Coef[2]}
elseif (k==3)
	mu = {w_Coef[3],W_Coef[4],W_Coef[5]}
	sigma2 = {w_Coef[6],W_Coef[7],W_Coef[8]}
	A = {w_Coef[0],W_Coef[1],W_Coef[2]}
elseif (k==2)
	A = {W_Coef[0],W_Coef[1]}
	mu = {W_Coef[2],W_Coef[3]}
	sigma2 = {w_Coef[4],W_Coef[5]}
elseif (k==4)
	mu = {w_Coef[4],W_Coef[5],W_Coef[6],W_Coef[7]}
	sigma2 = {w_Coef[8],W_Coef[9],W_Coef[10],W_Coef[11]}
	A = {w_Coef[0],W_Coef[1],W_Coef[2],W_Coef[3]}
elseif (k==5)
	mu = {W_Coef[5],W_Coef[6],W_Coef[7],w_Coef[8],w_Coef[9]}
	sigma2 = {w_Coef[10],W_Coef[11],W_Coef[12],W_Coef[13],W_Coef[14]}
	A = {w_Coef[0],W_Coef[1],W_Coef[2],W_Coef[3],W_Coef[4]}
elseif (k==6)
	mu = {W_Coef[6],W_Coef[7],w_Coef[8],w_Coef[9],W_Coef[11],W_Coef[12]}
	sigma2 = {w_Coef[13],W_Coef[14],W_Coef[15],W_Coef[16],W_Coef[17],W_Coef[18]}
	A = {w_Coef[0],W_Coef[1],W_Coef[2],W_Coef[3],W_Coef[4],W_Coef[5]}

endif



normpdf(xS,mu,sigma2,A)
end



Function normpdf(xS,mu,sigma2,A)
// Computes the pdf of the gaussian mixture 
wave xS, mu, sigma2, A
if (dimsize(mu,0) >0)
	make/o/n=(dimsize(xS,0),dimsize(mu,0)) data
else 
	make/o/n=(dimsize(xS,0)) data
endif
duplicate/o xS, sumDat
sumDat = 0
variable xLen = dimsize(xS,0)
variable k = dimsize(mu,0)
variable i,j
for (i=0;i<xLen;i+=1)
	for (j=0;j<k;j+=1)
		data[i][j] = A[j]*(2 * pi * sigma2[j])^-.5 * exp(-(xS[i]-mu[j])^2/(2*sigma2[j]))
		sumDat[i] = sumDat[i] + data[i][j]
	endfor
endfor

end

/////////////////////////////// Fit Functions //////////////////////
//All these functions are just gaussian mixtures with one or more components
// For each gaussian, A, Mu, Sigma2. 
Function gauss1(w,x) : FitFunc
	Wave w
	Variable x

	Variable/g V_FitNumIts

	//CurveFitDialog/ These comments were created by the Curve Fitting dialog. Altering them will
	//CurveFitDialog/ make the function less convenient to work with in the Curve Fitting dialog.
	//CurveFitDialog/ Equation:
	//CurveFitDialog/ f(x) = (A1*(2*pi*sigmaS1)^-.5 * exp(-(x-mu1)^2/(2*sigmaS1)))
	//CurveFitDialog/ End of Equation
	//CurveFitDialog/ Independent Variables 1
	//CurveFitDialog/ x
	//CurveFitDialog/ Coefficients 3
	//CurveFitDialog/ w[0] = A1
	//CurveFitDialog/ w[1] = mu1
	//CurveFitDialog/ w[2] = sigmaS1


	return (w[0]*(2*pi*w[2])^-.5 * exp(-(x-w[1])^2/(2*w[2])))

End





Function gauss2(w,x) : FitFunc
	Wave w
	Variable x

	Variable/g V_FitNumIts

	//CurveFitDialog/ These comments were created by the Curve Fitting dialog. Altering them will
	//CurveFitDialog/ make the function less convenient to work with in the Curve Fitting dialog.
	//CurveFitDialog/ Equation:
	//CurveFitDialog/ f(x) = (A1*(2*pi*sigmaS1)^-.5 * exp(-(x-mu1)^2/(2*sigmaS1))) + (A2 * (2*pi*sigmaS2)^-.5 * exp(-(x-mu2)^2/(2*sigmaS2)))
	//CurveFitDialog/ End of Equation
	//CurveFitDialog/ Independent Variables 1
	//CurveFitDialog/ x
	//CurveFitDialog/ Coefficients 6
	//CurveFitDialog/ w[0] = A1
	//CurveFitDialog/ w[1] = A2
	//CurveFitDialog/ w[2] = mu1
	//CurveFitDialog/ w[3] = mu2
	//CurveFitDialog/ w[4] = sigmaS1
	//CurveFitDialog/ w[5] = sigmaS2

	return (w[0]*(2*pi*w[4])^-.5 * exp(-(x-w[2])^2/(2*w[4]))) + (w[1] * (2*pi*w[5])^-.5 * exp(-(x-w[3])^2/(2*w[5])))

End


Function gauss3(w,x) : FitFunc
	Wave w
	Variable x
	variable/g V_FitMaxIters
	variable/g v_FitTol
	Variable/g V_FitNumIts

	//CurveFitDialog/ These comments were created by the Curve Fitting dialog. Altering them will
	//CurveFitDialog/ make the function less convenient to work with in the Curve Fitting dialog.
	//CurveFitDialog/ Equation:
	//CurveFitDialog/ f(x) = (A1*(2*pi*sigma21)^-.5 * exp(-(x-mu1)^2/(2*sigma21))) + (A2 * (2*pi*sigma22)^-.5 * exp(-(x-mu2)^2/(2*sigma22)))  + (A3 * (2*pi*sigma23)^-.5 * exp(-(x-mu3)^2/(2*sigma23)))
	//CurveFitDialog/ End of Equation
	//CurveFitDialog/ Independent Variables 1
	//CurveFitDialog/ x
	//CurveFitDialog/ Coefficients 9
	//CurveFitDialog/ w[0] = A1
	//CurveFitDialog/ w[1] = A2
	//CurveFitDialog/ w[2] = A3
	//CurveFitDialog/ w[3] = mu1
	//CurveFitDialog/ w[4] = mu2
	//CurveFitDialog/ w[5] = mu3
	//CurveFitDialog/ w[6] = sigma21
	//CurveFitDialog/ w[7] = sigma22
	//CurveFitDialog/ w[8] = sigma23

	return (w[0]*(2*pi*w[6])^-.5 * exp(-(x-w[3])^2/(2*w[6]))) + (w[1] * (2*pi*w[7])^-.5 * exp(-(x-w[4])^2/(2*w[7])))  + (w[2] * (2*pi*w[8])^-.5 * exp(-(x-w[5])^2/(2*w[8])))
	
	variable V_FitNumIters
//print V_FitNumIters
End

Function gauss4(w,x) : FitFunc
	Wave w
	Variable x

	//CurveFitDialog/ These comments were created by the Curve Fitting dialog. Altering them will
	//CurveFitDialog/ make the function less convenient to work with in the Curve Fitting dialog.
	//CurveFitDialog/ Equation:
	//CurveFitDialog/ f(x) =  (A1 * (2 * pi * sigmaS1)^-.5 * exp(-(x-mu1)^2/(2*sigmaS1))) +  A2 * (2 * pi * sigmaS2)^-.5 * exp(-(x-mu2)^2/(2*sigmaS2)) +  A3 * (2 * pi * sigmaS3)^-.5 * exp(-(x-mu3)^2/(2*sigmaS3))  +  A4 * (2 * pi * sigmaS4)^-.5 * exp(-(x-mu4)^2/(2*sigmaS4)) 
	//CurveFitDialog/ End of Equation
	//CurveFitDialog/ Independent Variables 1
	//CurveFitDialog/ x
	//CurveFitDialog/ Coefficients 12
	//CurveFitDialog/ w[0] = A1
	//CurveFitDialog/ w[1] = A2
	//CurveFitDialog/ w[2] = A3
	//CurveFitDialog/ w[3] = A4
	//CurveFitDialog/ w[4] = mu1
	//CurveFitDialog/ w[5] = mu2
	//CurveFitDialog/ w[6] = mu3
	//CurveFitDialog/ w[7] = mu4
	//CurveFitDialog/ w[8] = sigmaS1
	//CurveFitDialog/ w[9] = sigmaS2
	//CurveFitDialog/ w[10] = sigmaS3
	//CurveFitDialog/ w[11] = sigmaS4

	return (w[0] * (2 * pi * w[8])^-.5 * exp(-(x-w[4])^2/(2*w[8]))) +  w[1] * (2 * pi * w[9])^-.5 * exp(-(x-w[5])^2/(2*w[9])) +  w[2] * (2 * pi * w[10])^-.5 * exp(-(x-w[6])^2/(2*w[10]))  +  w[3] * (2 * pi * w[11])^-.5 * exp(-(x-w[7])^2/(2*w[11])) 
End

Function gauss5(w,x) : FitFunc
	Wave w
	Variable x

	//CurveFitDialog/ These comments were created by the Curve Fitting dialog. Altering them will
	//CurveFitDialog/ make the function less convenient to work with in the Curve Fitting dialog.
	//CurveFitDialog/ Equation:
	//CurveFitDialog/ f(x) = (A1 * (2 * pi * sigmaS1)^-.5 * exp(-(x-mu1)^2/(2*sigmaS1))) +  A2 * (2 * pi * sigmaS2)^-.5 * exp(-(x-mu2)^2/(2*sigmaS2)) +  A3 * (2 * pi * sigmaS3)^-.5 * exp(-(x-mu3)^2/(2*sigmaS3))  +  A4 * (2 * pi * sigmaS4)^-.5 * exp(-(x-mu4)^2/(2*sigmaS4)) +  A5 * (2 * pi * sigmaS5)^-.5 * exp(-(x-mu5)^2/(2*sigmaS5)) 
	//CurveFitDialog/ 
	//CurveFitDialog/ End of Equation
	//CurveFitDialog/ Independent Variables 1
	//CurveFitDialog/ x
	//CurveFitDialog/ Coefficients 15
	//CurveFitDialog/ w[0] = A1
	//CurveFitDialog/ w[1] = A2
	//CurveFitDialog/ w[2] = A3
	//CurveFitDialog/ w[3] = A4
	//CurveFitDialog/ w[4] = A5
	//CurveFitDialog/ w[5] = mu1
	//CurveFitDialog/ w[6] = mu2
	//CurveFitDialog/ w[7] = mu3
	//CurveFitDialog/ w[8] = mu4
	//CurveFitDialog/ w[9] = mu5
	//CurveFitDialog/ w[10] = sigmaS1
	//CurveFitDialog/ w[11] = sigmaS2
	//CurveFitDialog/ w[12] = sigmaS3
	//CurveFitDialog/ w[13] = sigmaS4
	//CurveFitDialog/ w[14] = sigmaS5

	return (w[0] * (2 * pi * w[10])^-.5 * exp(-(x-w[5])^2/(2*w[10]))) +  w[1] * (2 * pi * w[11])^-.5 * exp(-(x-w[6])^2/(2*w[11])) +  w[2] * (2 * pi * w[12])^-.5 * exp(-(x-w[7])^2/(2*w[12]))  +  w[3] * (2 * pi * w[13])^-.5 * exp(-(x-w[8])^2/(2*w[13])) +  w[4] * (2 * pi * w[14])^-.5 * exp(-(x-w[9])^2/(2*w[14])) 
	
End



//////////////////////////////////////  fitGausses(wavename,xValsName, YvalsName)  //////////////////////////////////////////////////////		
/// Now attempting to fit sum of multiple Gaussians in more elegant way with no limit to number, using approach described in Igor manual
/// Input wavename is the intensity PROFILE wave ending in "_p".  BUT if you are usin variance to identify synpses, the input is the _Fano wave
/// xVals is a global string conatining name of wave with locations of initial guesses of peaks from function automaticDefineAZ
/// yVals is a global string conatining name of wave with amplitudes of initial guesses of peaks from function automaticDefineAZ
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
Function fitGausses(wavename, xValsName, YvalsName)
string waveName, XvalsName, YvalsName

variable nGauss = dimsize($xValsName, 0)
//To get access go the gobal wave that contains distance wave
//If input is _Fano wave
string/G DistWaveName = "fit_"+(wavename[0, (strlen(wavename)-6)]) + "_d"  //Shorten name if input is the Fano wave
//string/G DistWaveName = wavename + "_d"
Duplicate/O $distWaveName distance_c

//string/G FanoWaveName = wavename + "_Fano"	
//string/G coefWaveName = waveName+"_coefs"  //The name of the string containing the fit coefficients
string/G coefWaveName = wavename +"_coefs"
//string/G fitWaveName = waveName+"_fit"

Duplicate/O $YvalsName, Yvals
Duplicate/O $XvalsName, Xvals
Make/D/O/N=(3*nGauss) CoefsTemp, eps		//NB double precision

print "Fitting intensity profile " + wavename + " which has corresponding distance wave " + DistWaveName

//Initial guess of sigma based on anatomy requires proper calibration of distance from scanner.dat
Variable Sigma = 0.35// Units: microns. Sigma will not vary much for different peaks.  So can always start with same initial estimate.
variable SigmaMax = 0.75  //microns
variable SigmaMin = 0.1  //microns
variable muBand = 0.05  //microns
variable SigmaBand =  0.2 //microns
variable AmpMin = 0.2*Wavemax($wavename)

//Wave distance_c

//NB All Gaussians have zero y offset i.e settle to zero.  So background must be subtracted from profile.
//duplicate/o $waveName, inTemp
//inTemp-= (WaveMin(inTemp))
//duplicate/o inTemp, $waveName
duplicate/o $waveName, dat

string/G fitwaveName =waveName+"_fit"
//string/G fitName = FanoWaveName
string/G ConstraintsName =waveName+"_cons"

variable i, j, k

// Attempt to make the convergence parameters better below
Variable/g  V_FitMaxIters =1000
Variable/g V_FitTol = 0.00001
Variable/g V_FitOptions = 1

//Coefficient order is: amplitude, mean, sigma.
String/G myFunctions=""
string GausstermName
String/G Coeffs
String HoldString = "010"

// Make the myFunctions string that is the sum of multiple Gaussians for subsequent use in Funcfit option 1
/// Also make the epsilon wave which is supposed to help with curve fitting.  eps wave is the size of perturbation of each coefficient.  
//  Not used at the moment.  Default is 1e-10 of the coef value.
Make/D/O GaussTerm

variable cfi

for(i=0; i<nGauss; i+=1)
	CoefsTemp[i*3]=Yvals[i]
	CoefsTemp[i*3+1]=Xvals[i]
	CoefsTemp[i*3+2]=Sigma*(i+1)/(i+2)
	eps[i*3]=1e-8  * CoefsTemp[i*3]
	eps[i*3+1]=1e-8 * CoefsTemp[i*3+1]
	eps[i*3+2]=1e-8 * CoefsTemp[i*3+2]
endfor
Duplicate/O CoefsTemp W_coef

for(i=0; i<nGauss; i+=1)
	GaussTermName = "GaussTerm"+num2str(i)
	gaussTerm = {CoefsTemp[i*3], CoefsTemp[i*3+1], CoefsTemp[i*3+2]}
	Duplicate/O gaussTerm, $gaussTermName
	//myFunctions += "{gauss1," + GaussTermName + ", HOLD=" + HoldString +"}" 
	myFunctions += "{gauss1," + GaussTermName + "}" 	
endfor


///  Make the text wave containing the constraints for fitting
variable nConstraints = 6   //Not used at the moment  
string knum
Make/O/D/T/N=(nGauss*6) T_constraints  //We constrain amplitude, mean and sigma between two bounds. 

//  Make the text wave containing the constraints for fitting using Option 1

for(i=0; i<nGauss; i+=1)		
		knum="K"+num2str(i*3)
		T_Constraints[i*6]= knum + ">" +num2str(0.1*Wavemax($wavename))    //More than a finite number greater than zero.
		T_Constraints[i*6+1]= knum + "<" +num2str(10*Wavemax($wavename)) 	//Less than 10x max in profile average.
		
		knum="K"+num2str(i*3+1)
		T_Constraints[i*6+2]=knum + ">" +num2str((CoefsTemp[i*3+1]- muBand))
		T_Constraints[i*6+3]=knum + "<" +num2str((CoefsTemp[i*3+1]+ muBand))
		
		knum="K"+num2str(i*3+2)
		T_Constraints[i*6+4]=knum + ">" +num2str((CoefsTemp[i*3+2]- SigmaBand))
		T_Constraints[i*6+5]=knum + "<" +num2str((CoefsTemp[i*3+2]+ SigmaBand))
endfor

variable V_FitQuitReason=0
variable V_FitNumIters=0
variable V_FitError=0

// Now do fit.  Two options.
// Option 1: use a sum of Gauss functions created above (myFunction), whch seems to work robustly.
// Option 2: use the fitManyGaussians function (probably more elegant)
Duplicate/O dat, fit_dat
Duplicate/O T_Constraints, $ConstraintsName

Make/O/D M_FitConstraint, W_FitConstraint					//These are globals which are filled after FuncFit below

/////////////////  Option 1  ////////////////////
//FuncFit/C/Q {string = myFunctions} dat /D=fit_dat/X=distance_c/C=T_Constraints///E=eps//C=T_Constraints//E=eps

/////////////////  Option 2  ////////////////////
FuncFit/Q/ODR=(0) FitManyGaussian W_Coef dat /D=fit_dat/X=$DistWaveName/C=T_Constraints/E=eps

print "Number of iterations = " + num2str(V_FitNumIters)
print "Quit reason = " + num2str(V_FitQuitReason)
print "Fit Error = " + num2str(V_FitError)

Duplicate/O W_coef, $CoefWaveName
Duplicate/O W_coef, $(wavename+"_init_fit")
Duplicate/O fit_dat, $fitWaveName
//Duplicate/O fit_dat, $fitName

END
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////	


////////////////////////////////////////////////////////////////////////////////	
// This function is called via the ThreadStart operation so that more than one copy of it
// can be run simultaneously.
Threadsafe Function TS_MultiGaussFuncFit_Driver(coefwave, ydata, xdata, CMatrix, DVector)
	Wave xdata, CMatrix, DVector, ydata, coefwave
	
	variable/G count1 = 0
	variable/G count2 = 0
	variable V_FitQuitReason=0
	variable V_FitNumIters=0
	variable V_FitError=0

	//wave fitted
	FuncFit/N/ODR=0/Q FitManyGaussian coefwave ydata /X=xdata/C={CMatrix, DVector}
	
	if (V_FitError != 0)
		count1 +=1
		V_FitError = 0
	endif
	if (V_FitQuitReason != 0)
		count2 +=1
		V_FitQuitReason = 0	
	endif
	//print count1
	//print count2
END




////////////////////////////////////////////////////////////////////////////////
// This function takes in two lists of data waves, plus a wave with reasonable guesses. This wave isn't really
// necessary, because the built-in exp_XOfset function automatically guesses. It would be necessary for
// a user-defined curve fit.

Function/S DoMultipleGaussFitsMT(startCoefs, LinePlotName, xdata, CMatrix, DVector)
	Wave startCoefs, xdata, CMatrix, DVector
	String LinePlotName
	Variable ntpoints = dimsize($LinePlotName,0) 				//The total number of time points to be fitted
	Variable nProfpoints = dimsize($LinePlotName,1)			//Number of points in intensity profile along one line 	
	Variable nCoefs = 	dimsize(startCoefs,0)	
	variable nThreads= ThreadProcessorCount		//Number of time points in one MT block
	
	Make/O/N=(nCoefs,ntpoints) AllCoefs
	Make/O/N=((nCoefs/3),ntpoints) AmpCoefs
	
	Variable nBlocks = floor(ntpoints/nThreads)
	variable remaindertpoints = ntpoints - (nBlocks*nThreads)
	print "Using " + num2str(nThreads) + " threads in " + num2str(nBlocks) + " blocks" 
	print "If there is a problem and this stage aborted type \"print ThreadGroupRelease(-2)\" into command line. Return value 0 indicates all threads succesfully terminated."
	
	variable i, j, k, timepoint
	
	// Create a thread group with nthreads. If you have more processors, you might want to change
	// the number of threads. You would also need to change the loop to accommodate more threads.
	Variable tgID= ThreadGroupCreate(nThreads)
	
	Variable dataIndex = 0
	Variable V_fitOptions=4
	//Variable V_fitOptions=1
	
	String ywName, CWaveName
	Duplicate/O $LinePlotName, tempLP
	CWaveName = "CoefWave"+num2str(0)
	Duplicate/O startCoefs, $CWaveName 
	Make/O/N=(nProfPoints) tempProf
	
	//Timing info.  Start by making sure that all timers 0-9 are stopped
	variable timerrefNum, t1
	for(i=0; i<=9; i+=1)
		t1 = StopMSTimer(i)
	endfor
	t1=0
	
	for (j=0; j<nBlocks; j+=1)
		
		if(j==0)
			timerrefNum = StartMStimer
		endif
		
		timerrefNum = StartMStimer
		for(i=0; i<nThreads; i+=1)
			timepoint = ( (j*nThreads) + i)
			ywName = "yw"+num2str(i)								// Make a ydata wave just for this func fit
			Duplicate/O/RMD=[timepoint][] 	tempLP $ywName
			Redimension/N=(dimsize($LinePlotName,1)) $ywName
			CWaveName = "CoefWave"+num2str(timepoint)
			Duplicate/O startCoefs, $CWaveName 
			ThreadStart tgID, i, TS_MultiGaussFuncFit_Driver($CWaveName, $ywName, xdata, CMatrix, DVector)	
		endfor
		
		// Wait for this block of Funcfits to finish.
		Variable threadStatus = ThreadGroupWait(tgID, inf)
		if (threadStatus)
			print "There was a problem with a thread. Aborting!"
			break;
		endif
		
		for(i=0; i<nThreads; i+=1)
			timepoint = ( (j*nThreads) + i)
			ywName = "yw"+num2str(i)
			CWaveName = "CoefWave"+num2str(timepoint)
			Duplicate/O $CWaveName, temp
			AllCoefs[][timepoint]=temp[p]
			AmpCoefs[][timepoint] = temp[p*3]
			KillWaves $CWaveName, $ywName
		endfor
		
		if(j==0)
			t1 = StopMSTimer(timerrefNum)
			print "Expected time for completion = " + num2str( (t1*nBlocks/10^6)/60) + " mins plus a bit more."
		endif
	endfor //j
	
	print "Zero means threads terminated OK: " + num2str(ThreadGroupRelease(-2))
	
	string OutputName = LinePlotName + "Coefs"
	Duplicate/O AllCoefs $OutputName
	return OutputName
End
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////
Threadsafe Function FitManyGaussian(w, x) : FitFunc
	WAVE w
	Variable x

	Variable returnValue = 0//w[0]
	Variable i
	Variable numPeaks = floor((numpnts(w))/3)
	Variable cfi

	for (i = 0; i < numPeaks; i += 1)
		cfi = 3*i
		//returnValue += w[cfi]*(2*pi*w[cfi+2])^-.5 * exp(-(x-w[cfi+1])^2/(2*w[cfi+2]))
		returnValue += w[cfi]* exp(-(x-w[cfi+1])^2/(2*w[cfi+2]^2))
	endfor
	
	if(returnvalue==nan || returnvalue==inf)
		returnvalue = 0
	endif
	
	return returnValue
End
////////////////////////////////////////////////////////////////////////////////







