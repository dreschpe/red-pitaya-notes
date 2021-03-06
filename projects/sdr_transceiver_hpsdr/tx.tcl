# Create xlslice
cell xilinx.com:ip:xlslice:1.0 slice_0 {
  DIN_WIDTH 8 DIN_FROM 0 DIN_TO 0 DOUT_WIDTH 1
}

# Create xlslice
cell xilinx.com:ip:xlslice:1.0 slice_1 {
  DIN_WIDTH 8 DIN_FROM 1 DIN_TO 1 DOUT_WIDTH 1
}

# Create xlslice
cell xilinx.com:ip:xlslice:1.0 slice_2 {
  DIN_WIDTH 96 DIN_FROM 63 DIN_TO 0 DOUT_WIDTH 64
}

# Create xlslice
cell xilinx.com:ip:xlslice:1.0 slice_3 {
  DIN_WIDTH 96 DIN_FROM 95 DIN_TO 64 DOUT_WIDTH 32
}

# Create axi_axis_writer
cell pavel-demin:user:axi_axis_writer:1.0 writer_0 {
  AXI_DATA_WIDTH 32
} {
  aclk /ps_0/FCLK_CLK0
  aresetn /rst_0/peripheral_aresetn
}

# Create fifo_generator
cell xilinx.com:ip:fifo_generator:13.0 fifo_generator_0 {
  PERFORMANCE_OPTIONS First_Word_Fall_Through
  INPUT_DATA_WIDTH 32
  INPUT_DEPTH 16384
  OUTPUT_DATA_WIDTH 32
  OUTPUT_DEPTH 16384
  DATA_COUNT true
  DATA_COUNT_WIDTH 15
} {
  clk /ps_0/FCLK_CLK0
  srst slice_0/Dout
}

# Create axis_fifo
cell pavel-demin:user:axis_fifo:1.0 fifo_0 {
  S_AXIS_TDATA_WIDTH 32
  M_AXIS_TDATA_WIDTH 32
} {
  S_AXIS writer_0/M_AXIS
  FIFO_READ fifo_generator_0/FIFO_READ
  FIFO_WRITE fifo_generator_0/FIFO_WRITE
  aclk /ps_0/FCLK_CLK0
}

# Create axis_subset_converter
cell xilinx.com:ip:axis_subset_converter:1.1 subset_0 {
  S_TDATA_NUM_BYTES.VALUE_SRC USER
  M_TDATA_NUM_BYTES.VALUE_SRC USER
  S_TDATA_NUM_BYTES 4
  M_TDATA_NUM_BYTES 4
  TDATA_REMAP {tdata[7:0],tdata[15:8],tdata[23:16],tdata[31:24]}
} {
  S_AXIS fifo_0/M_AXIS
  aclk /ps_0/FCLK_CLK0
  aresetn /rst_0/peripheral_aresetn
}

# Create axis_dwidth_converter
cell xilinx.com:ip:axis_dwidth_converter:1.1 conv_0 {
  S_TDATA_NUM_BYTES.VALUE_SRC USER
  S_TDATA_NUM_BYTES 4
  M_TDATA_NUM_BYTES 2
} {
  S_AXIS subset_0/M_AXIS
  aclk /ps_0/FCLK_CLK0
  aresetn /rst_0/peripheral_aresetn
}

# Create fir_compiler
cell xilinx.com:ip:fir_compiler:7.2 fir_0 {
  DATA_WIDTH.VALUE_SRC USER
  DATA_WIDTH 16
  COEFFICIENTVECTOR {-1.6477801750e-08, -4.7324163097e-08, -7.9388720251e-10, 3.0935287840e-08, 1.8628693017e-08, 3.2749841074e-08, -6.3010222617e-09, -1.5228567768e-07, -8.3046659925e-08, 3.1454755170e-07, 3.0563443720e-07, -4.7419117094e-07, -7.1351635364e-07, 5.4734613636e-07, 1.3346642512e-06, -4.1415972953e-07, -2.1505805167e-06, -6.7737057259e-08, 3.0755673259e-06, 1.0370503001e-06, -3.9444966934e-06, -2.5919926122e-06, 4.5155281147e-06, 4.7479775541e-06, -4.4929951709e-06, -7.3984868151e-06, 3.5722846504e-06, 1.0289869117e-05, -1.5038710735e-06, -1.3021295240e-05, -1.8321409210e-06, 1.5078652434e-05, 6.3548656420e-06, -1.5906210356e-05, -1.1732881423e-05, 1.5011493416e-05, 1.7372569769e-05, -1.2094722059e-05, -2.2467638067e-05, 7.1699339150e-06, 2.6104136562e-05, -6.6353321968e-07, -2.7430175635e-05, -6.5509220415e-06, 2.5865174090e-05, 1.3204847015e-05, -2.1317671795e-05, -1.7790702706e-05, 1.4366763209e-05, 1.8820361840e-05, -6.3577454162e-06, -1.5163034305e-05, -6.3477521161e-07, 6.4159804236e-06, 4.0081677999e-06, 6.7578642750e-06, -1.0056827660e-06, -2.2403875454e-05, -1.0762714466e-05, 3.7234806368e-05, 3.2701648373e-05, -4.6862336568e-05, -6.4654596103e-05, 4.6261853099e-05, 1.0440518619e-04, -3.0541782239e-05, -1.4746203904e-04, -4.1198849294e-06, 1.8719214943e-04, 5.9473887298e-05, -2.1538216537e-04, -1.3430620506e-04, 2.2323170741e-04, 2.2384246785e-04, -2.0270752583e-04, -3.1963413291e-04, 1.4810123444e-04, 4.1006383426e-04, -5.7561720326e-05, -4.8153083533e-04, -6.5678588350e-05, 5.2026805597e-04, 2.1267144618e-04, -5.1463543384e-04, -3.6901841643e-04, 4.5748195652e-04, 5.1599113997e-04, -3.4848855304e-04, -6.3290255992e-04, 1.9565494419e-04, 7.0021202129e-04, -1.5798053324e-05, -7.0322833645e-04, -1.6638430162e-04, 6.3586400802e-04, 3.2084519462e-04, -5.0382599520e-04, -4.1627140642e-04, 3.2657810485e-04, 4.2540796787e-04, -1.3746783842e-04, -3.3105766856e-04, -1.8437414229e-05, 1.3195762724e-04, 8.8999575771e-05, 1.5241240648e-04, -2.2012305401e-05, -4.7912762479e-04, -2.2616088356e-04, 7.8162602932e-04, 6.8035383482e-04, -9.7387937741e-04, -1.3374712383e-03, 9.5754392732e-04, 2.1583069913e-03, -6.3308702079e-04, -3.0624965440e-03, -8.6272521497e-05, 3.9276234782e-03, 1.2589353321e-03, -4.5933559732e-03, -2.8991545030e-03, 4.8709735098e-03, 4.9628762245e-03, -4.5580353367e-03, -7.3369121192e-03, 3.4572798586e-03, 9.8328593784e-03, -1.3982386583e-03, -1.2186564412e-02, -1.7404055806e-03, 1.4062742508e-02, 6.0087446715e-03, -1.5066061872e-02, -1.1370530905e-02, 1.4748822641e-02, 1.7687827361e-02, -1.2618903157e-02, -2.4713994167e-02, 8.1311075801e-03, 3.2087529442e-02, -6.4507438695e-04, -3.9318313378e-02, -1.0692901925e-02, 4.5738050611e-02, 2.7251261077e-02, -5.0322886903e-02, -5.1717777909e-02, 5.1020708934e-02, 9.0574063244e-02, -4.1608642159e-02, -1.6375279868e-01, -1.0802988345e-02, 3.5639489212e-01, 5.5482858407e-01, 3.5639489212e-01, -1.0802988345e-02, -1.6375279868e-01, -4.1608642159e-02, 9.0574063244e-02, 5.1020708934e-02, -5.1717777909e-02, -5.0322886903e-02, 2.7251261077e-02, 4.5738050611e-02, -1.0692901925e-02, -3.9318313378e-02, -6.4507438695e-04, 3.2087529442e-02, 8.1311075801e-03, -2.4713994167e-02, -1.2618903157e-02, 1.7687827361e-02, 1.4748822641e-02, -1.1370530905e-02, -1.5066061872e-02, 6.0087446715e-03, 1.4062742508e-02, -1.7404055806e-03, -1.2186564412e-02, -1.3982386583e-03, 9.8328593784e-03, 3.4572798586e-03, -7.3369121192e-03, -4.5580353367e-03, 4.9628762245e-03, 4.8709735098e-03, -2.8991545030e-03, -4.5933559732e-03, 1.2589353321e-03, 3.9276234782e-03, -8.6272521497e-05, -3.0624965440e-03, -6.3308702079e-04, 2.1583069913e-03, 9.5754392732e-04, -1.3374712383e-03, -9.7387937741e-04, 6.8035383482e-04, 7.8162602932e-04, -2.2616088356e-04, -4.7912762479e-04, -2.2012305401e-05, 1.5241240648e-04, 8.8999575771e-05, 1.3195762724e-04, -1.8437414229e-05, -3.3105766856e-04, -1.3746783842e-04, 4.2540796787e-04, 3.2657810485e-04, -4.1627140642e-04, -5.0382599520e-04, 3.2084519462e-04, 6.3586400802e-04, -1.6638430162e-04, -7.0322833645e-04, -1.5798053324e-05, 7.0021202129e-04, 1.9565494419e-04, -6.3290255992e-04, -3.4848855304e-04, 5.1599113997e-04, 4.5748195652e-04, -3.6901841643e-04, -5.1463543384e-04, 2.1267144618e-04, 5.2026805597e-04, -6.5678588350e-05, -4.8153083533e-04, -5.7561720326e-05, 4.1006383426e-04, 1.4810123444e-04, -3.1963413291e-04, -2.0270752583e-04, 2.2384246785e-04, 2.2323170741e-04, -1.3430620506e-04, -2.1538216537e-04, 5.9473887298e-05, 1.8719214943e-04, -4.1198849294e-06, -1.4746203904e-04, -3.0541782239e-05, 1.0440518619e-04, 4.6261853099e-05, -6.4654596103e-05, -4.6862336568e-05, 3.2701648373e-05, 3.7234806368e-05, -1.0762714466e-05, -2.2403875454e-05, -1.0056827660e-06, 6.7578642750e-06, 4.0081677999e-06, 6.4159804236e-06, -6.3477521161e-07, -1.5163034305e-05, -6.3577454162e-06, 1.8820361840e-05, 1.4366763209e-05, -1.7790702706e-05, -2.1317671795e-05, 1.3204847015e-05, 2.5865174090e-05, -6.5509220415e-06, -2.7430175635e-05, -6.6353321968e-07, 2.6104136562e-05, 7.1699339150e-06, -2.2467638067e-05, -1.2094722059e-05, 1.7372569769e-05, 1.5011493416e-05, -1.1732881423e-05, -1.5906210356e-05, 6.3548656420e-06, 1.5078652434e-05, -1.8321409210e-06, -1.3021295240e-05, -1.5038710735e-06, 1.0289869117e-05, 3.5722846504e-06, -7.3984868151e-06, -4.4929951709e-06, 4.7479775541e-06, 4.5155281147e-06, -2.5919926122e-06, -3.9444966934e-06, 1.0370503001e-06, 3.0755673259e-06, -6.7737057259e-08, -2.1505805167e-06, -4.1415972953e-07, 1.3346642512e-06, 5.4734613636e-07, -7.1351635364e-07, -4.7419117094e-07, 3.0563443720e-07, 3.1454755170e-07, -8.3046659925e-08, -1.5228567768e-07, -6.3010222617e-09, 3.2749841074e-08, 1.8628693017e-08, 3.0935287840e-08, -7.9388720251e-10, -4.7324163097e-08, -1.6477801750e-08}
  COEFFICIENT_WIDTH 24
  QUANTIZATION Maximize_Dynamic_Range
  BESTPRECISION true
  FILTER_TYPE Interpolation
  INTERPOLATION_RATE 2
  NUMBER_CHANNELS 2
  NUMBER_PATHS 1
  SAMPLE_FREQUENCY 0.048
  CLOCK_FREQUENCY 125
  OUTPUT_ROUNDING_MODE Convergent_Rounding_to_Even
  OUTPUT_WIDTH 26
  M_DATA_HAS_TREADY true
  HAS_ARESETN true
} {
  S_AXIS_DATA conv_0/M_AXIS
  aclk /ps_0/FCLK_CLK0
  aresetn /rst_0/peripheral_aresetn
}

# Create axis_subset_converter
cell xilinx.com:ip:axis_subset_converter:1.1 subset_1 {
  S_TDATA_NUM_BYTES.VALUE_SRC USER
  M_TDATA_NUM_BYTES.VALUE_SRC USER
  S_TDATA_NUM_BYTES 4
  M_TDATA_NUM_BYTES 3
  TDATA_REMAP {tdata[23:0]}
} {
  S_AXIS fir_0/M_AXIS_DATA
  aclk /ps_0/FCLK_CLK0
  aresetn /rst_0/peripheral_aresetn
}

# Create fir_compiler
cell xilinx.com:ip:fir_compiler:7.2 fir_1 {
  DATA_WIDTH.VALUE_SRC USER
  DATA_WIDTH 24
  COEFFICIENTVECTOR {-2.3372642819e-11, -8.7554391032e-10, -1.8848800582e-09, -3.0643417761e-09, -4.4295401629e-09, -5.9990958339e-09, -7.7949737965e-09, -9.8427829255e-09, -1.2172028352e-08, -1.4816304734e-08, -1.7813418207e-08, -2.1205424868e-08, -2.5038573890e-08, -2.9363143880e-08, -3.4233161836e-08, -3.9705995054e-08, -4.5841807610e-08, -5.2702874552e-08, -6.0352748733e-08, -6.8855277238e-08, -7.8273466632e-08, -8.8668198730e-08, -1.0009680130e-07, -1.1261148097e-07, -1.2625762848e-07, -1.4107200988e-07, -1.5708085979e-07, -1.7429789681e-07, -1.9272228359e-07, -2.1233655765e-07, -2.3310456155e-07, -2.5496940417e-07, -2.7785148696e-07, -3.0164663132e-07, -3.2622434523e-07, -3.5142626842e-07, -3.7706483630e-07, -4.0292220352e-07, -4.2874946747e-07, -4.5426623153e-07, -4.7916054643e-07, -5.0308926570e-07, -5.2567884892e-07, -5.4652664249e-07, -5.6520266374e-07, -5.8125190931e-07, -5.9419720320e-07, -6.0354259349e-07, -6.0877730048e-07, -6.0938021105e-07, -6.0482490685e-07, -5.9458520539e-07, -5.7814118472e-07, -5.5498565373e-07, -5.2463102135e-07, -4.8661650895e-07, -4.4051564175e-07, -3.8594394665e-07, -3.2256677578e-07, -2.5010716780e-07, -1.6835365181e-07, -7.7167893311e-08, 2.3507924009e-08, 1.3364409040e-07, 2.5311684886e-07, 3.8170247481e-07, 5.1907207083e-07, 6.6478718937e-07, 8.1829639311e-07, 9.7893285821e-07, 1.1459131193e-06, 1.3183370468e-06, 1.4951891383e-06, 1.6753411927e-06, 1.8575564252e-06, 2.0404950638e-06, 2.2227214552e-06, 2.4027126879e-06, 2.5788687235e-06, 2.7495240073e-06, 2.9129605089e-06, 3.0674221230e-06, 3.2111303393e-06, 3.3423010693e-06, 3.4591624964e-06, 3.5599737958e-06, 3.6430445502e-06, 3.7067546701e-06, 3.7495746073e-06, 3.7700856388e-06, 3.7669999804e-06, 3.7391804815e-06, 3.6856596416e-06, 3.6056576838e-06, 3.4985994183e-06, 3.3641296286e-06, 3.2021267165e-06, 3.0127143505e-06, 2.7962708723e-06, 2.5534362316e-06, 2.2851162366e-06, 1.9924839320e-06, 1.6769779395e-06, 1.3402976271e-06, 9.8439500583e-07, 6.1146328649e-07, 2.2392207006e-07, -1.7560081602e-07, -5.8429077933e-07, -9.9917112158e-07, -1.4171307493e-06, -1.8349547444e-06, -2.2493575563e-06, -2.6570185318e-06, -3.0546194565e-06, -3.4388837343e-06, -3.8066167979e-06, -4.1547473001e-06, -4.4803686074e-06, -4.7807800850e-06, -5.0535276393e-06, -5.2964429676e-06, -5.5076809486e-06, -5.6857546041e-06, -5.8295670614e-06, -5.9384399560e-06, -6.0121377269e-06, -6.0508872833e-06, -6.0553925500e-06, -6.0268434389e-06, -5.9669188411e-06, -5.8777832860e-06, -5.7620769787e-06, -5.6228989911e-06, -5.4637834604e-06, -5.2886687265e-06, -5.1018594253e-06, -4.9079816461e-06, -4.7119313520e-06, -4.5188163592e-06, -4.3338922645e-06, -4.1624928120e-06, -4.0099552801e-06, -3.8815415659e-06, -3.7823557347e-06, -3.7172588840e-06, -3.6907822548e-06, -3.7070395888e-06, -3.7696397995e-06, -3.8816010722e-06, -4.0452675550e-06, -4.2622298292e-06, -4.5332503685e-06, -4.8581951968e-06, -5.2359729455e-06, -5.6644824838e-06, -6.1405702554e-06, -6.6599983972e-06, -7.2174246409e-06, -7.8063949129e-06, -8.4193494408e-06, -9.0476430571e-06, -9.6815802573e-06, -1.0310465422e-05, -1.0922668454e-05, -1.1505705919e-05, -1.2046337576e-05, -1.2530678037e-05, -1.2944323055e-05, -1.3272489789e-05, -1.3500170156e-05, -1.3612296207e-05, -1.3593916277e-05, -1.3430380422e-05, -1.3107533542e-05, -1.2611914356e-05, -1.1930958281e-05, -1.1053202079e-05, -9.9684880701e-06, -8.6681655250e-06, -7.1452868450e-06, -5.3947960137e-06, -3.4137068065e-06, -1.2012682205e-06, 1.2408853891e-06, 3.9086019279e-06, 6.7950993214e-06, 9.8908756850e-06, 1.3183644036e-05, 1.6658293501e-05, 2.0296878782e-05, 2.4078639392e-05, 2.7980049931e-05, 3.1974902383e-05, 3.6034421093e-05, 4.0127410773e-05, 4.4220437520e-05, 4.8278042472e-05, 5.2262987360e-05, 5.6136530803e-05, 5.9858733838e-05, 6.3388792767e-05, 6.6685397027e-05, 6.9707109397e-05, 7.2412765535e-05, 7.4761889437e-05, 7.6715121143e-05, 7.8234652684e-05, 7.9284668018e-05, 7.9831782473e-05, 7.9845477031e-05, 7.9298522638e-05, 7.8167389634e-05, 7.6432637350e-05, 7.4079278927e-05, 7.1097116462e-05, 6.7481041720e-05, 6.3231297820e-05, 5.8353697518e-05, 5.2859794025e-05, 4.6767000624e-05, 4.0098655759e-05, 3.2884030714e-05, 2.5158277512e-05, 1.6962315208e-05, 8.3426533243e-06, -6.4884816032e-07, -9.9552822389e-06, -1.9515060978e-05, -2.9262342864e-05, -3.9127519234e-05, -4.9037756930e-05, -5.8917593580e-05, -6.8689581211e-05, -7.8274973212e-05, -8.7594448994e-05, -9.6568870096e-05, -1.0512006086e-04, -1.1317160633e-04, -1.2064965945e-04, -1.2748374942e-04, -1.3360758252e-04, -1.3895982661e-04, -1.4348487032e-04, -1.4713354782e-04, -1.4986382015e-04, -1.5164140417e-04, -1.5244034046e-04, -1.5224349166e-04, -1.5104296353e-04, -1.4884044103e-04, -1.4564743287e-04, -1.4148541826e-04, -1.3638589082e-04, -1.3039029513e-04, -1.2354985270e-04, -1.1592527501e-04, -1.0758636258e-04, -9.8611489958e-05, -8.9086978037e-05, -7.9106356183e-05, -6.8769518019e-05, -5.8181776000e-05, -4.7452821197e-05, -3.6695596001e-05, -2.6025088688e-05, -1.5557059985e-05, -5.4067129231e-06, 4.3126816926e-06, 1.3491190876e-05, 2.2023641945e-05, 2.9811046965e-05, 3.6762013588e-05, 4.2794126255e-05, 4.7835281383e-05, 5.1824959972e-05, 5.4715421077e-05, 5.6472799742e-05, 5.7078093326e-05, 5.6528020680e-05, 5.4835739343e-05, 5.2031406782e-05, 4.8162572807e-05, 4.3294391483e-05, 3.7509642310e-05, 3.0908551972e-05, 2.3608409719e-05, 1.5742971254e-05, 7.4616480230e-06, -1.0715191309e-06, -9.6791007814e-06, -1.8171730790e-05, -2.6349763498e-05, -3.4005128159e-05, -4.0923370180e-05, -4.6885866380e-05, -5.1672199173e-05, -5.5062672336e-05, -5.6840948852e-05, -5.6796789252e-05, -5.4728866970e-05, -5.0447635460e-05, -4.3778220201e-05, -3.4563307391e-05, -2.2665999883e-05, -7.9726100757e-06, 9.6046412742e-06, 3.0125051681e-05, 5.3617020521e-05, 8.0075820882e-05, 1.0946159050e-04, 1.4169757178e-04, 1.7666862977e-04, 2.1422007562e-04, 2.5415682107e-04, 2.9624288779e-04, 3.4020129277e-04, 3.8571432842e-04, 4.3242425315e-04, 4.7993440506e-04, 5.2781074797e-04, 5.7558385523e-04, 6.2275133352e-04, 6.6878068415e-04, 7.1311259607e-04, 7.5516466021e-04, 7.9433549070e-04, 8.3000923444e-04, 8.6156044619e-04, 8.8835930222e-04, 9.0977712176e-04, 9.2519216123e-04, 9.3399564305e-04, 9.3559797681e-04, 9.2943512778e-04, 9.1497508463e-04, 8.9172437546e-04, 8.5923457946e-04, 8.1710877906e-04, 7.6500789641e-04, 7.0265685691e-04, 6.2985052177e-04, 5.4645933181e-04, 4.5243460494e-04, 3.4781343056e-04, 2.3272310594e-04, 1.0738506110e-04, -2.7881778505e-05, -1.7265823947e-04, -3.2642280249e-04, -4.8855019963e-04, -6.5831074306e-04, -8.3487041672e-04, -1.0172917574e-03, -1.2045355460e-03, -1.3954633239e-03, -1.5888407439e-03, -1.7833417575e-03, -1.9775536360e-03, -2.1699828126e-03, -2.3590615312e-03, -2.5431552756e-03, -2.7205709489e-03, -2.8895657660e-03, -3.0483568159e-03, -3.1951312414e-03, -3.3280569827e-03, -3.4452940208e-03, -3.5450060539e-03, -3.6253725352e-03, -3.6846009933e-03, -3.7209395565e-03, -3.7326895952e-03, -3.7182183951e-03, -3.6759717729e-03, -3.6044865419e-03, -3.5024027365e-03, -3.3684755034e-03, -3.2015865672e-03, -3.0007551797e-03, -2.7651484662e-03, -2.4940910794e-03, -2.1870740824e-03, -1.8437629782e-03, -1.4640048157e-03, -1.0478343005e-03, -5.9547884974e-04, -1.0736253508e-04, 4.1589113623e-04, 9.7345764244e-04, 1.5643111045e-03, 2.1872252041e-03, 2.8407753796e-03, 3.5233423063e-03, 4.2331166603e-03, 4.9681051551e-03, 5.7261378307e-03, 6.5048765662e-03, 7.3018247775e-03, 8.1143382540e-03, 8.9396370764e-03, 9.7748185537e-03, 1.0616871107e-02, 1.1462689017e-02, 1.2309087959e-02, 1.3152821213e-02, 1.3990596478e-02, 1.4819093156e-02, 1.5634980026e-02, 1.6434933171e-02, 1.7215654067e-02, 1.7973887696e-02, 1.8706440582e-02, 1.9410198622e-02, 2.0082144599e-02, 2.0719375258e-02, 2.1319117835e-02, 2.1878745930e-02, 2.2395794602e-02, 2.2867974611e-02, 2.3293185684e-02, 2.3669528736e-02, 2.3995316947e-02, 2.4269085627e-02, 2.4489600803e-02, 2.4655866469e-02, 2.4767130438e-02, 2.4822888779e-02, 2.4822888779e-02, 2.4767130438e-02, 2.4655866469e-02, 2.4489600803e-02, 2.4269085627e-02, 2.3995316947e-02, 2.3669528736e-02, 2.3293185684e-02, 2.2867974611e-02, 2.2395794602e-02, 2.1878745930e-02, 2.1319117835e-02, 2.0719375258e-02, 2.0082144599e-02, 1.9410198622e-02, 1.8706440582e-02, 1.7973887696e-02, 1.7215654067e-02, 1.6434933171e-02, 1.5634980026e-02, 1.4819093156e-02, 1.3990596478e-02, 1.3152821213e-02, 1.2309087959e-02, 1.1462689017e-02, 1.0616871107e-02, 9.7748185537e-03, 8.9396370764e-03, 8.1143382540e-03, 7.3018247775e-03, 6.5048765662e-03, 5.7261378307e-03, 4.9681051551e-03, 4.2331166603e-03, 3.5233423063e-03, 2.8407753796e-03, 2.1872252041e-03, 1.5643111045e-03, 9.7345764244e-04, 4.1589113623e-04, -1.0736253508e-04, -5.9547884974e-04, -1.0478343005e-03, -1.4640048157e-03, -1.8437629782e-03, -2.1870740824e-03, -2.4940910794e-03, -2.7651484662e-03, -3.0007551797e-03, -3.2015865672e-03, -3.3684755034e-03, -3.5024027365e-03, -3.6044865419e-03, -3.6759717729e-03, -3.7182183951e-03, -3.7326895952e-03, -3.7209395565e-03, -3.6846009933e-03, -3.6253725352e-03, -3.5450060539e-03, -3.4452940208e-03, -3.3280569827e-03, -3.1951312414e-03, -3.0483568159e-03, -2.8895657660e-03, -2.7205709489e-03, -2.5431552756e-03, -2.3590615312e-03, -2.1699828126e-03, -1.9775536360e-03, -1.7833417575e-03, -1.5888407439e-03, -1.3954633239e-03, -1.2045355460e-03, -1.0172917574e-03, -8.3487041672e-04, -6.5831074306e-04, -4.8855019963e-04, -3.2642280249e-04, -1.7265823947e-04, -2.7881778505e-05, 1.0738506110e-04, 2.3272310594e-04, 3.4781343056e-04, 4.5243460494e-04, 5.4645933181e-04, 6.2985052177e-04, 7.0265685691e-04, 7.6500789641e-04, 8.1710877906e-04, 8.5923457946e-04, 8.9172437546e-04, 9.1497508463e-04, 9.2943512778e-04, 9.3559797681e-04, 9.3399564305e-04, 9.2519216123e-04, 9.0977712176e-04, 8.8835930222e-04, 8.6156044619e-04, 8.3000923444e-04, 7.9433549070e-04, 7.5516466021e-04, 7.1311259607e-04, 6.6878068415e-04, 6.2275133352e-04, 5.7558385523e-04, 5.2781074797e-04, 4.7993440506e-04, 4.3242425315e-04, 3.8571432842e-04, 3.4020129277e-04, 2.9624288779e-04, 2.5415682107e-04, 2.1422007562e-04, 1.7666862977e-04, 1.4169757178e-04, 1.0946159050e-04, 8.0075820882e-05, 5.3617020521e-05, 3.0125051681e-05, 9.6046412742e-06, -7.9726100757e-06, -2.2665999883e-05, -3.4563307391e-05, -4.3778220201e-05, -5.0447635460e-05, -5.4728866970e-05, -5.6796789252e-05, -5.6840948852e-05, -5.5062672336e-05, -5.1672199173e-05, -4.6885866380e-05, -4.0923370180e-05, -3.4005128159e-05, -2.6349763498e-05, -1.8171730790e-05, -9.6791007814e-06, -1.0715191309e-06, 7.4616480230e-06, 1.5742971254e-05, 2.3608409719e-05, 3.0908551972e-05, 3.7509642310e-05, 4.3294391483e-05, 4.8162572807e-05, 5.2031406782e-05, 5.4835739343e-05, 5.6528020680e-05, 5.7078093326e-05, 5.6472799742e-05, 5.4715421077e-05, 5.1824959972e-05, 4.7835281383e-05, 4.2794126255e-05, 3.6762013588e-05, 2.9811046965e-05, 2.2023641945e-05, 1.3491190876e-05, 4.3126816926e-06, -5.4067129231e-06, -1.5557059985e-05, -2.6025088688e-05, -3.6695596001e-05, -4.7452821197e-05, -5.8181776000e-05, -6.8769518019e-05, -7.9106356183e-05, -8.9086978037e-05, -9.8611489958e-05, -1.0758636258e-04, -1.1592527501e-04, -1.2354985270e-04, -1.3039029513e-04, -1.3638589082e-04, -1.4148541826e-04, -1.4564743287e-04, -1.4884044103e-04, -1.5104296353e-04, -1.5224349166e-04, -1.5244034046e-04, -1.5164140417e-04, -1.4986382015e-04, -1.4713354782e-04, -1.4348487032e-04, -1.3895982661e-04, -1.3360758252e-04, -1.2748374942e-04, -1.2064965945e-04, -1.1317160633e-04, -1.0512006086e-04, -9.6568870096e-05, -8.7594448994e-05, -7.8274973212e-05, -6.8689581211e-05, -5.8917593580e-05, -4.9037756930e-05, -3.9127519234e-05, -2.9262342864e-05, -1.9515060978e-05, -9.9552822389e-06, -6.4884816032e-07, 8.3426533243e-06, 1.6962315208e-05, 2.5158277512e-05, 3.2884030714e-05, 4.0098655759e-05, 4.6767000624e-05, 5.2859794025e-05, 5.8353697518e-05, 6.3231297820e-05, 6.7481041720e-05, 7.1097116462e-05, 7.4079278927e-05, 7.6432637350e-05, 7.8167389634e-05, 7.9298522638e-05, 7.9845477031e-05, 7.9831782473e-05, 7.9284668018e-05, 7.8234652684e-05, 7.6715121143e-05, 7.4761889437e-05, 7.2412765535e-05, 6.9707109397e-05, 6.6685397027e-05, 6.3388792767e-05, 5.9858733838e-05, 5.6136530803e-05, 5.2262987360e-05, 4.8278042472e-05, 4.4220437520e-05, 4.0127410773e-05, 3.6034421093e-05, 3.1974902383e-05, 2.7980049931e-05, 2.4078639392e-05, 2.0296878782e-05, 1.6658293501e-05, 1.3183644036e-05, 9.8908756850e-06, 6.7950993213e-06, 3.9086019279e-06, 1.2408853891e-06, -1.2012682205e-06, -3.4137068065e-06, -5.3947960137e-06, -7.1452868450e-06, -8.6681655250e-06, -9.9684880701e-06, -1.1053202079e-05, -1.1930958281e-05, -1.2611914356e-05, -1.3107533542e-05, -1.3430380422e-05, -1.3593916277e-05, -1.3612296207e-05, -1.3500170156e-05, -1.3272489789e-05, -1.2944323055e-05, -1.2530678037e-05, -1.2046337576e-05, -1.1505705919e-05, -1.0922668454e-05, -1.0310465422e-05, -9.6815802572e-06, -9.0476430571e-06, -8.4193494408e-06, -7.8063949129e-06, -7.2174246409e-06, -6.6599983972e-06, -6.1405702554e-06, -5.6644824838e-06, -5.2359729455e-06, -4.8581951968e-06, -4.5332503685e-06, -4.2622298292e-06, -4.0452675550e-06, -3.8816010722e-06, -3.7696397995e-06, -3.7070395888e-06, -3.6907822548e-06, -3.7172588840e-06, -3.7823557347e-06, -3.8815415659e-06, -4.0099552801e-06, -4.1624928120e-06, -4.3338922645e-06, -4.5188163592e-06, -4.7119313520e-06, -4.9079816461e-06, -5.1018594253e-06, -5.2886687265e-06, -5.4637834604e-06, -5.6228989911e-06, -5.7620769787e-06, -5.8777832860e-06, -5.9669188411e-06, -6.0268434389e-06, -6.0553925500e-06, -6.0508872833e-06, -6.0121377269e-06, -5.9384399560e-06, -5.8295670614e-06, -5.6857546041e-06, -5.5076809486e-06, -5.2964429676e-06, -5.0535276393e-06, -4.7807800850e-06, -4.4803686074e-06, -4.1547473001e-06, -3.8066167979e-06, -3.4388837343e-06, -3.0546194565e-06, -2.6570185318e-06, -2.2493575563e-06, -1.8349547444e-06, -1.4171307493e-06, -9.9917112158e-07, -5.8429077933e-07, -1.7560081602e-07, 2.2392207006e-07, 6.1146328649e-07, 9.8439500583e-07, 1.3402976271e-06, 1.6769779395e-06, 1.9924839320e-06, 2.2851162366e-06, 2.5534362316e-06, 2.7962708723e-06, 3.0127143505e-06, 3.2021267165e-06, 3.3641296286e-06, 3.4985994183e-06, 3.6056576838e-06, 3.6856596416e-06, 3.7391804815e-06, 3.7669999804e-06, 3.7700856388e-06, 3.7495746073e-06, 3.7067546701e-06, 3.6430445502e-06, 3.5599737958e-06, 3.4591624964e-06, 3.3423010693e-06, 3.2111303393e-06, 3.0674221230e-06, 2.9129605089e-06, 2.7495240073e-06, 2.5788687235e-06, 2.4027126879e-06, 2.2227214552e-06, 2.0404950638e-06, 1.8575564252e-06, 1.6753411927e-06, 1.4951891383e-06, 1.3183370468e-06, 1.1459131193e-06, 9.7893285821e-07, 8.1829639311e-07, 6.6478718937e-07, 5.1907207083e-07, 3.8170247481e-07, 2.5311684886e-07, 1.3364409040e-07, 2.3507924009e-08, -7.7167893311e-08, -1.6835365181e-07, -2.5010716780e-07, -3.2256677578e-07, -3.8594394665e-07, -4.4051564175e-07, -4.8661650895e-07, -5.2463102135e-07, -5.5498565373e-07, -5.7814118472e-07, -5.9458520539e-07, -6.0482490685e-07, -6.0938021105e-07, -6.0877730048e-07, -6.0354259349e-07, -5.9419720320e-07, -5.8125190931e-07, -5.6520266374e-07, -5.4652664249e-07, -5.2567884892e-07, -5.0308926570e-07, -4.7916054643e-07, -4.5426623153e-07, -4.2874946747e-07, -4.0292220352e-07, -3.7706483630e-07, -3.5142626842e-07, -3.2622434523e-07, -3.0164663132e-07, -2.7785148696e-07, -2.5496940417e-07, -2.3310456155e-07, -2.1233655765e-07, -1.9272228359e-07, -1.7429789681e-07, -1.5708085979e-07, -1.4107200988e-07, -1.2625762848e-07, -1.1261148097e-07, -1.0009680130e-07, -8.8668198730e-08, -7.8273466632e-08, -6.8855277238e-08, -6.0352748733e-08, -5.2702874552e-08, -4.5841807610e-08, -3.9705995054e-08, -3.4233161836e-08, -2.9363143880e-08, -2.5038573890e-08, -2.1205424868e-08, -1.7813418207e-08, -1.4816304734e-08, -1.2172028352e-08, -9.8427829255e-09, -7.7949737965e-09, -5.9990958339e-09, -4.4295401629e-09, -3.0643417761e-09, -1.8848800582e-09, -8.7554391032e-10, -2.3372642819e-11}
  COEFFICIENT_WIDTH 24
  QUANTIZATION Maximize_Dynamic_Range
  BESTPRECISION true
  FILTER_TYPE Interpolation
  RATE_CHANGE_TYPE Fixed_Fractional
  INTERPOLATION_RATE 25
  DECIMATION_RATE 24
  NUMBER_CHANNELS 2
  NUMBER_PATHS 1
  SAMPLE_FREQUENCY 0.096
  CLOCK_FREQUENCY 125
  OUTPUT_ROUNDING_MODE Convergent_Rounding_to_Even
  OUTPUT_WIDTH 25
  M_DATA_HAS_TREADY true
  HAS_ARESETN true
} {
  S_AXIS_DATA subset_1/M_AXIS
  aclk /ps_0/FCLK_CLK0
  aresetn /rst_0/peripheral_aresetn
}

# Create axis_dwidth_converter
cell xilinx.com:ip:axis_dwidth_converter:1.1 conv_1 {
  S_TDATA_NUM_BYTES.VALUE_SRC USER
  S_TDATA_NUM_BYTES 4
  M_TDATA_NUM_BYTES 8
} {
  S_AXIS fir_1/M_AXIS_DATA
  aclk /ps_0/FCLK_CLK0
  aresetn /rst_0/peripheral_aresetn
}

# Create axis_broadcaster
cell xilinx.com:ip:axis_broadcaster:1.1 bcast_0 {
  S_TDATA_NUM_BYTES.VALUE_SRC USER
  M_TDATA_NUM_BYTES.VALUE_SRC USER
  S_TDATA_NUM_BYTES 8
  M_TDATA_NUM_BYTES 3
  M00_TDATA_REMAP {tdata[23:0]}
  M01_TDATA_REMAP {tdata[55:32]}
} {
  S_AXIS conv_1/M_AXIS
  aclk /ps_0/FCLK_CLK0
  aresetn /rst_0/peripheral_aresetn
}

# Create cic_compiler
cell xilinx.com:ip:cic_compiler:4.0 cic_0 {
  INPUT_DATA_WIDTH.VALUE_SRC USER
  FILTER_TYPE Interpolation
  NUMBER_OF_STAGES 6
  FIXED_OR_INITIAL_RATE 1250
  INPUT_SAMPLE_FREQUENCY 0.1
  CLOCK_FREQUENCY 125
  INPUT_DATA_WIDTH 24
  QUANTIZATION Truncation
  OUTPUT_DATA_WIDTH 24
  USE_XTREME_DSP_SLICE false
  HAS_DOUT_TREADY true
  HAS_ARESETN true
} {
  S_AXIS_DATA bcast_0/M00_AXIS
  aclk /ps_0/FCLK_CLK0
  aresetn /rst_0/peripheral_aresetn
}

# Create cic_compiler
cell xilinx.com:ip:cic_compiler:4.0 cic_1 {
  INPUT_DATA_WIDTH.VALUE_SRC USER
  FILTER_TYPE Interpolation
  NUMBER_OF_STAGES 6
  FIXED_OR_INITIAL_RATE 1250
  INPUT_SAMPLE_FREQUENCY 0.1
  CLOCK_FREQUENCY 125
  INPUT_DATA_WIDTH 24
  QUANTIZATION Truncation
  OUTPUT_DATA_WIDTH 24
  USE_XTREME_DSP_SLICE false
  HAS_DOUT_TREADY true
  HAS_ARESETN true
} {
  S_AXIS_DATA bcast_0/M01_AXIS
  aclk /ps_0/FCLK_CLK0
  aresetn /rst_0/peripheral_aresetn
}

# Create axis_combiner
cell  xilinx.com:ip:axis_combiner:1.1 comb_0 {
  TDATA_NUM_BYTES.VALUE_SRC USER
  TDATA_NUM_BYTES 3
} {
  S00_AXIS cic_0/M_AXIS_DATA
  S01_AXIS cic_1/M_AXIS_DATA
  aclk /ps_0/FCLK_CLK0
  aresetn /rst_0/peripheral_aresetn
}

# Create axis_keyer
cell pavel-demin:user:axis_keyer:1.0 keyer_0 {
  AXIS_TDATA_WIDTH 48
} {
  key_flag slice_1/Dout
  key_data slice_2/Dout
  S_AXIS comb_0/M_AXIS
  aclk /ps_0/FCLK_CLK0
}

# Create axis_constant
cell pavel-demin:user:axis_constant:1.0 phase_0 {
  AXIS_TDATA_WIDTH 32
} {
  cfg_data slice_3/Dout
  aclk /ps_0/FCLK_CLK0
}

# Create dds_compiler
cell xilinx.com:ip:dds_compiler:6.0 dds_0 {
  DDS_CLOCK_RATE 125
  SPURIOUS_FREE_DYNAMIC_RANGE 138
  FREQUENCY_RESOLUTION 0.2
  PHASE_INCREMENT Streaming
  HAS_TREADY true
  HAS_PHASE_OUT false
  PHASE_WIDTH 30
  OUTPUT_WIDTH 24
  DSP48_USE Minimal
} {
  S_AXIS_PHASE phase_0/M_AXIS
  aclk /ps_0/FCLK_CLK0
}

# Create axis_lfsr
cell pavel-demin:user:axis_lfsr:1.0 lfsr_0 {} {
  aclk /ps_0/FCLK_CLK0
  aresetn /rst_0/peripheral_aresetn
}

# Create cmpy
cell xilinx.com:ip:cmpy:6.0 mult_0 {
  FLOWCONTROL Blocking
  APORTWIDTH.VALUE_SRC USER
  BPORTWIDTH.VALUE_SRC USER
  APORTWIDTH 24
  BPORTWIDTH 24
  ROUNDMODE Random_Rounding
  OUTPUTWIDTH 17
} {
  S_AXIS_A keyer_0/M_AXIS
  S_AXIS_B dds_0/M_AXIS_DATA
  S_AXIS_CTRL lfsr_0/M_AXIS
  aclk /ps_0/FCLK_CLK0
}

# Create xlconstant
cell xilinx.com:ip:xlconstant:1.1 const_0

# Create axis_clock_converter
cell xilinx.com:ip:axis_clock_converter:1.1 fifo_1 {
  TDATA_NUM_BYTES.VALUE_SRC USER
  TDATA_NUM_BYTES 2
} {
  S_AXIS mult_0/M_AXIS_DOUT
  s_axis_aclk /ps_0/FCLK_CLK0
  s_axis_aresetn /rst_0/peripheral_aresetn
}
