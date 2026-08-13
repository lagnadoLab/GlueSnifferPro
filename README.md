# GlueSnifferPro
An updated version of the Glue Sniffer Analysis Package.

# Load ML Data
The load ML Data button creates a popup listbox allowing the user to select a linescan movie to analyze in the form of a .mat file. 

# Split Channels
This button allows the user to split the channels of the linescan video. In our recording setup, stimulus frames are interleaved with recording frames. Splitting the channels seperates these two aspects.

# View resampled linescan
This button converts the linescan video into a pixels x time matrix for easier analysis. 

# Split Inputs and Outputs
Creates GUI for splitting out two parts of a linescan path. ScanImage Premium allows for multiple linescans to be done within a single imaging cycle. This button allows for the separation of different parth of the cycle path. A temporal average of the linescan matrix is displayed, overlaid with the scan distanc: users place cursors on areas where the distance plot slope is stable, which is where a single line from the full scanpath will be. 

# Define synapses
Creates GUI for defining active zones. A temporal average of the linescan matrix is displayed along with automatically detected synaptic peaks, which are found from successive derivatives of the fluorescence profile. Users can then manually curate the peaks for quality control. The peak parameters were then put through constrained nonlinear least-squares fitting, which optimized the gaussian fit coefficients for the reconstructed fit profile. 

# Extract synapse activity
Creates a temporal profile for each ROI in Define synapses by weighted averaging based on the Gaussian decomposition. Thus, values nearer the center of each ROI are weighted heavier than outside areas. 

