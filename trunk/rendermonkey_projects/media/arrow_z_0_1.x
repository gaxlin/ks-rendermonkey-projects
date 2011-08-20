xof 0303txt 0032
template FVFData {
 <b6e70a0e-8ef9-4e83-94ad-ecc8b0c04897>
 DWORD dwFVF;
 DWORD nDWords;
 array DWORD data[nDWords];
}

template EffectInstance {
 <e331f7e4-0559-4cc2-8e99-1cec1657928f>
 STRING EffectFilename;
 [...]
}

template EffectParamFloats {
 <3014b9a0-62f5-478c-9b86-e4ac9f4e418b>
 STRING ParamName;
 DWORD nFloats;
 array FLOAT Floats[nFloats];
}

template EffectParamString {
 <1dbc4c88-94c1-46ee-9076-2c28818c9481>
 STRING ParamName;
 STRING Value;
}

template EffectParamDWord {
 <e13963bc-ae51-4c5d-b00f-cfa3a9d97ce5>
 STRING ParamName;
 DWORD Value;
}


Mesh cylinder {
 360;
 0.005976;0.002864;0.893549;,
 0.005976;0.002864;0.000344;,
 0.003740;0.004969;0.000344;,
 0.003740;0.004969;0.000344;,
 0.003740;0.004969;0.893549;,
 0.005976;0.002864;0.893549;,
 0.003740;0.004969;0.893549;,
 0.003740;0.004969;0.000344;,
 0.000686;0.005740;0.000344;,
 0.000686;0.005740;0.000344;,
 0.000686;0.005740;0.893549;,
 0.003740;0.004969;0.893549;,
 0.000686;0.005740;0.893549;,
 0.000686;0.005740;0.000344;,
 -0.002367;0.004969;0.000344;,
 -0.002367;0.004969;0.000344;,
 -0.002367;0.004969;0.893549;,
 0.000686;0.005740;0.893549;,
 -0.002367;0.004969;0.893549;,
 -0.002367;0.004969;0.000344;,
 -0.004603;0.002864;0.000344;,
 -0.004603;0.002864;0.000344;,
 -0.004603;0.002864;0.893549;,
 -0.002367;0.004969;0.893549;,
 -0.005421;-0.000013;0.893549;,
 -0.004603;0.002864;0.893549;,
 -0.004603;0.002864;0.000344;,
 -0.004603;0.002864;0.000344;,
 -0.005421;-0.000013;0.000344;,
 -0.005421;-0.000013;0.893549;,
 -0.004603;-0.002889;0.893549;,
 -0.005421;-0.000013;0.893549;,
 -0.005421;-0.000013;0.000344;,
 -0.005421;-0.000013;0.000344;,
 -0.004603;-0.002889;0.000344;,
 -0.004603;-0.002889;0.893549;,
 -0.004603;-0.002889;0.893549;,
 -0.004603;-0.002889;0.000344;,
 -0.002367;-0.004995;0.000344;,
 -0.002367;-0.004995;0.000344;,
 -0.002367;-0.004995;0.893549;,
 -0.004603;-0.002889;0.893549;,
 -0.002367;-0.004995;0.893549;,
 -0.002367;-0.004995;0.000344;,
 0.000686;-0.005766;0.000344;,
 0.000686;-0.005766;0.000344;,
 0.000686;-0.005766;0.893549;,
 -0.002367;-0.004995;0.893549;,
 0.000686;-0.005766;0.893549;,
 0.000686;-0.005766;0.000344;,
 0.003740;-0.004995;0.000344;,
 0.003740;-0.004995;0.000344;,
 0.003740;-0.004995;0.893549;,
 0.000686;-0.005766;0.893549;,
 0.003740;-0.004995;0.893549;,
 0.003740;-0.004995;0.000344;,
 0.005976;-0.002889;0.000344;,
 0.005976;-0.002889;0.000344;,
 0.005976;-0.002889;0.893549;,
 0.003740;-0.004995;0.893549;,
 0.005976;-0.002889;0.000344;,
 0.006794;-0.000013;0.000344;,
 0.006794;-0.000013;0.893549;,
 0.006794;-0.000013;0.893549;,
 0.005976;-0.002889;0.893549;,
 0.005976;-0.002889;0.000344;,
 0.006794;-0.000013;0.000344;,
 0.005976;0.002864;0.000344;,
 0.005976;0.002864;0.893549;,
 0.005976;0.002864;0.893549;,
 0.006794;-0.000013;0.893549;,
 0.006794;-0.000013;0.000344;,
 0.000686;-0.000013;0.000344;,
 0.003740;0.004969;0.000344;,
 0.005976;0.002864;0.000344;,
 0.000686;-0.000013;0.000344;,
 0.000686;0.005740;0.000344;,
 0.003740;0.004969;0.000344;,
 0.000686;-0.000013;0.000344;,
 -0.002367;0.004969;0.000344;,
 0.000686;0.005740;0.000344;,
 0.000686;-0.000013;0.000344;,
 -0.004603;0.002864;0.000344;,
 -0.002367;0.004969;0.000344;,
 0.000686;-0.000013;0.000344;,
 -0.005421;-0.000013;0.000344;,
 -0.004603;0.002864;0.000344;,
 0.000686;-0.000013;0.000344;,
 -0.004603;-0.002889;0.000344;,
 -0.005421;-0.000013;0.000344;,
 0.000686;-0.000013;0.000344;,
 -0.002367;-0.004995;0.000344;,
 -0.004603;-0.002889;0.000344;,
 0.000686;-0.000013;0.000344;,
 0.000686;-0.005766;0.000344;,
 -0.002367;-0.004995;0.000344;,
 0.000686;-0.000013;0.000344;,
 0.003740;-0.004995;0.000344;,
 0.000686;-0.005766;0.000344;,
 0.000686;-0.000013;0.000344;,
 0.005976;-0.002889;0.000344;,
 0.003740;-0.004995;0.000344;,
 0.000686;-0.000013;0.000344;,
 0.006794;-0.000013;0.000344;,
 0.005976;-0.002889;0.000344;,
 0.000686;-0.000013;0.000344;,
 0.005976;0.002864;0.000344;,
 0.006794;-0.000013;0.000344;,
 0.007844;0.011663;0.890073;,
 0.013082;0.006729;0.890073;,
 0.005976;0.002864;0.893549;,
 0.005976;0.002864;0.893549;,
 0.003740;0.004969;0.893549;,
 0.007844;0.011663;0.890073;,
 0.000688;0.013469;0.890073;,
 0.007844;0.011663;0.890073;,
 0.003740;0.004969;0.893549;,
 0.003740;0.004969;0.893549;,
 0.000686;0.005740;0.893549;,
 0.000688;0.013469;0.890073;,
 0.000688;0.013469;0.890073;,
 0.000686;0.005740;0.893549;,
 -0.002367;0.004969;0.893549;,
 -0.002367;0.004969;0.893549;,
 -0.006468;0.011663;0.890073;,
 0.000688;0.013469;0.890073;,
 -0.006468;0.011663;0.890073;,
 -0.002367;0.004969;0.893549;,
 -0.004603;0.002864;0.893549;,
 -0.004603;0.002864;0.893549;,
 -0.011706;0.006729;0.890073;,
 -0.006468;0.011663;0.890073;,
 -0.011706;0.006729;0.890073;,
 -0.004603;0.002864;0.893549;,
 -0.005421;-0.000013;0.893549;,
 -0.005421;-0.000013;0.893549;,
 -0.013623;-0.000011;0.890073;,
 -0.011706;0.006729;0.890073;,
 -0.005421;-0.000013;0.893549;,
 -0.004603;-0.002889;0.893549;,
 -0.011706;-0.006752;0.890073;,
 -0.011706;-0.006752;0.890073;,
 -0.013623;-0.000011;0.890073;,
 -0.005421;-0.000013;0.893549;,
 -0.004603;-0.002889;0.893549;,
 -0.002367;-0.004995;0.893549;,
 -0.006468;-0.011686;0.890073;,
 -0.006468;-0.011686;0.890073;,
 -0.011706;-0.006752;0.890073;,
 -0.004603;-0.002889;0.893549;,
 -0.002367;-0.004995;0.893549;,
 0.000686;-0.005766;0.893549;,
 0.000688;-0.013492;0.890073;,
 0.000688;-0.013492;0.890073;,
 -0.006468;-0.011686;0.890073;,
 -0.002367;-0.004995;0.893549;,
 0.003740;-0.004995;0.893549;,
 0.007844;-0.011686;0.890073;,
 0.000688;-0.013492;0.890073;,
 0.000688;-0.013492;0.890073;,
 0.000686;-0.005766;0.893549;,
 0.003740;-0.004995;0.893549;,
 0.005976;-0.002889;0.893549;,
 0.013082;-0.006752;0.890073;,
 0.007844;-0.011686;0.890073;,
 0.007844;-0.011686;0.890073;,
 0.003740;-0.004995;0.893549;,
 0.005976;-0.002889;0.893549;,
 0.006794;-0.000013;0.893549;,
 0.014999;-0.000011;0.890073;,
 0.013082;-0.006752;0.890073;,
 0.013082;-0.006752;0.890073;,
 0.005976;-0.002889;0.893549;,
 0.006794;-0.000013;0.893549;,
 0.013082;0.006729;0.890073;,
 0.014999;-0.000011;0.890073;,
 0.006794;-0.000013;0.893549;,
 0.006794;-0.000013;0.893549;,
 0.005976;0.002864;0.893549;,
 0.013082;0.006729;0.890073;,
 0.003481;0.001508;0.945159;,
 0.013082;0.006729;0.890073;,
 0.007844;0.011663;0.890073;,
 0.007844;0.011663;0.890073;,
 0.002301;0.002619;0.945159;,
 0.003481;0.001508;0.945159;,
 0.002301;0.002619;0.945159;,
 0.007844;0.011663;0.890073;,
 0.000688;0.013469;0.890073;,
 0.000688;0.013469;0.890073;,
 0.000690;0.003026;0.945159;,
 0.002301;0.002619;0.945159;,
 0.000690;0.003026;0.945159;,
 0.000688;0.013469;0.890073;,
 -0.006468;0.011663;0.890073;,
 -0.006468;0.011663;0.890073;,
 -0.000922;0.002619;0.945159;,
 0.000690;0.003026;0.945159;,
 -0.000922;0.002619;0.945159;,
 -0.006468;0.011663;0.890073;,
 -0.011706;0.006729;0.890073;,
 -0.011706;0.006729;0.890073;,
 -0.002102;0.001508;0.945159;,
 -0.000922;0.002619;0.945159;,
 -0.002533;-0.000010;0.945159;,
 -0.002102;0.001508;0.945159;,
 -0.011706;0.006729;0.890073;,
 -0.011706;0.006729;0.890073;,
 -0.013623;-0.000011;0.890073;,
 -0.002533;-0.000010;0.945159;,
 -0.002102;-0.001528;0.945159;,
 -0.002533;-0.000010;0.945159;,
 -0.013623;-0.000011;0.890073;,
 -0.013623;-0.000011;0.890073;,
 -0.011706;-0.006752;0.890073;,
 -0.002102;-0.001528;0.945159;,
 -0.002102;-0.001528;0.945159;,
 -0.011706;-0.006752;0.890073;,
 -0.006468;-0.011686;0.890073;,
 -0.006468;-0.011686;0.890073;,
 -0.000922;-0.002639;0.945159;,
 -0.002102;-0.001528;0.945159;,
 -0.000922;-0.002639;0.945159;,
 -0.006468;-0.011686;0.890073;,
 0.000688;-0.013492;0.890073;,
 0.000688;-0.013492;0.890073;,
 0.000690;-0.003046;0.945159;,
 -0.000922;-0.002639;0.945159;,
 0.000690;-0.003046;0.945159;,
 0.000688;-0.013492;0.890073;,
 0.007844;-0.011686;0.890073;,
 0.007844;-0.011686;0.890073;,
 0.002301;-0.002639;0.945159;,
 0.000690;-0.003046;0.945159;,
 0.002301;-0.002639;0.945159;,
 0.007844;-0.011686;0.890073;,
 0.013082;-0.006752;0.890073;,
 0.013082;-0.006752;0.890073;,
 0.003481;-0.001528;0.945159;,
 0.002301;-0.002639;0.945159;,
 0.014999;-0.000011;0.890073;,
 0.003912;-0.000010;0.945159;,
 0.003481;-0.001528;0.945159;,
 0.003481;-0.001528;0.945159;,
 0.013082;-0.006752;0.890073;,
 0.014999;-0.000011;0.890073;,
 0.013082;0.006729;0.890073;,
 0.003481;0.001508;0.945159;,
 0.003912;-0.000010;0.945159;,
 0.003912;-0.000010;0.945159;,
 0.014999;-0.000011;0.890073;,
 0.013082;0.006729;0.890073;,
 0.001932;0.000667;0.993656;,
 0.003481;0.001508;0.945159;,
 0.002301;0.002619;0.945159;,
 0.002301;0.002619;0.945159;,
 0.001408;0.001161;0.993656;,
 0.001932;0.000667;0.993656;,
 0.001408;0.001161;0.993656;,
 0.002301;0.002619;0.945159;,
 0.000690;0.003026;0.945159;,
 0.000690;0.003026;0.945159;,
 0.000691;0.001342;0.993656;,
 0.001408;0.001161;0.993656;,
 0.000691;0.001342;0.993656;,
 0.000690;0.003026;0.945159;,
 -0.000922;0.002619;0.945159;,
 -0.000922;0.002619;0.945159;,
 -0.000026;0.001161;0.993656;,
 0.000691;0.001342;0.993656;,
 -0.000026;0.001161;0.993656;,
 -0.000922;0.002619;0.945159;,
 -0.002102;0.001508;0.945159;,
 -0.002102;0.001508;0.945159;,
 -0.000550;0.000667;0.993656;,
 -0.000026;0.001161;0.993656;,
 -0.000742;-0.000008;0.993656;,
 -0.000550;0.000667;0.993656;,
 -0.002102;0.001508;0.945159;,
 -0.002102;0.001508;0.945159;,
 -0.002533;-0.000010;0.945159;,
 -0.000742;-0.000008;0.993656;,
 -0.000550;-0.000683;0.993656;,
 -0.000742;-0.000008;0.993656;,
 -0.002533;-0.000010;0.945159;,
 -0.002533;-0.000010;0.945159;,
 -0.002102;-0.001528;0.945159;,
 -0.000550;-0.000683;0.993656;,
 -0.000550;-0.000683;0.993656;,
 -0.002102;-0.001528;0.945159;,
 -0.000922;-0.002639;0.945159;,
 -0.000922;-0.002639;0.945159;,
 -0.000026;-0.001177;0.993656;,
 -0.000550;-0.000683;0.993656;,
 -0.000026;-0.001177;0.993656;,
 -0.000922;-0.002639;0.945159;,
 0.000690;-0.003046;0.945159;,
 0.000690;-0.003046;0.945159;,
 0.000691;-0.001358;0.993656;,
 -0.000026;-0.001177;0.993656;,
 0.000691;-0.001358;0.993656;,
 0.000690;-0.003046;0.945159;,
 0.002301;-0.002639;0.945159;,
 0.002301;-0.002639;0.945159;,
 0.001408;-0.001177;0.993656;,
 0.000691;-0.001358;0.993656;,
 0.001408;-0.001177;0.993656;,
 0.002301;-0.002639;0.945159;,
 0.003481;-0.001528;0.945159;,
 0.003481;-0.001528;0.945159;,
 0.001932;-0.000683;0.993656;,
 0.001408;-0.001177;0.993656;,
 0.003912;-0.000010;0.945159;,
 0.002124;-0.000008;0.993656;,
 0.001932;-0.000683;0.993656;,
 0.001932;-0.000683;0.993656;,
 0.003481;-0.001528;0.945159;,
 0.003912;-0.000010;0.945159;,
 0.003481;0.001508;0.945159;,
 0.001932;0.000667;0.993656;,
 0.002124;-0.000008;0.993656;,
 0.002124;-0.000008;0.993656;,
 0.003912;-0.000010;0.945159;,
 0.003481;0.001508;0.945159;,
 0.000691;-0.000008;0.993656;,
 0.001932;0.000667;0.993656;,
 0.001408;0.001161;0.993656;,
 0.000691;-0.000008;0.993656;,
 0.001408;0.001161;0.993656;,
 0.000691;0.001342;0.993656;,
 0.000691;-0.000008;0.993656;,
 0.000691;0.001342;0.993656;,
 -0.000026;0.001161;0.993656;,
 0.000691;-0.000008;0.993656;,
 -0.000026;0.001161;0.993656;,
 -0.000550;0.000667;0.993656;,
 0.000691;-0.000008;0.993656;,
 -0.000550;0.000667;0.993656;,
 -0.000742;-0.000008;0.993656;,
 0.000691;-0.000008;0.993656;,
 -0.000742;-0.000008;0.993656;,
 -0.000550;-0.000683;0.993656;,
 0.000691;-0.000008;0.993656;,
 -0.000550;-0.000683;0.993656;,
 -0.000026;-0.001177;0.993656;,
 0.000691;-0.000008;0.993656;,
 -0.000026;-0.001177;0.993656;,
 0.000691;-0.001358;0.993656;,
 0.000691;-0.000008;0.993656;,
 0.000691;-0.001358;0.993656;,
 0.001408;-0.001177;0.993656;,
 0.000691;-0.000008;0.993656;,
 0.001408;-0.001177;0.993656;,
 0.001932;-0.000683;0.993656;,
 0.000691;-0.000008;0.993656;,
 0.001932;-0.000683;0.993656;,
 0.002124;-0.000008;0.993656;,
 0.000691;-0.000008;0.993656;,
 0.002124;-0.000008;0.993656;,
 0.001932;0.000667;0.993656;;
 120;
 3;0,1,2;,
 3;3,4,5;,
 3;6,7,8;,
 3;9,10,11;,
 3;12,13,14;,
 3;15,16,17;,
 3;18,19,20;,
 3;21,22,23;,
 3;24,25,26;,
 3;27,28,29;,
 3;30,31,32;,
 3;33,34,35;,
 3;36,37,38;,
 3;39,40,41;,
 3;42,43,44;,
 3;45,46,47;,
 3;48,49,50;,
 3;51,52,53;,
 3;54,55,56;,
 3;57,58,59;,
 3;60,61,62;,
 3;63,64,65;,
 3;66,67,68;,
 3;69,70,71;,
 3;72,73,74;,
 3;75,76,77;,
 3;78,79,80;,
 3;81,82,83;,
 3;84,85,86;,
 3;87,88,89;,
 3;90,91,92;,
 3;93,94,95;,
 3;96,97,98;,
 3;99,100,101;,
 3;102,103,104;,
 3;105,106,107;,
 3;108,109,110;,
 3;111,112,113;,
 3;114,115,116;,
 3;117,118,119;,
 3;120,121,122;,
 3;123,124,125;,
 3;126,127,128;,
 3;129,130,131;,
 3;132,133,134;,
 3;135,136,137;,
 3;138,139,140;,
 3;141,142,143;,
 3;144,145,146;,
 3;147,148,149;,
 3;150,151,152;,
 3;153,154,155;,
 3;156,157,158;,
 3;159,160,161;,
 3;162,163,164;,
 3;165,166,167;,
 3;168,169,170;,
 3;171,172,173;,
 3;174,175,176;,
 3;177,178,179;,
 3;180,181,182;,
 3;183,184,185;,
 3;186,187,188;,
 3;189,190,191;,
 3;192,193,194;,
 3;195,196,197;,
 3;198,199,200;,
 3;201,202,203;,
 3;204,205,206;,
 3;207,208,209;,
 3;210,211,212;,
 3;213,214,215;,
 3;216,217,218;,
 3;219,220,221;,
 3;222,223,224;,
 3;225,226,227;,
 3;228,229,230;,
 3;231,232,233;,
 3;234,235,236;,
 3;237,238,239;,
 3;240,241,242;,
 3;243,244,245;,
 3;246,247,248;,
 3;249,250,251;,
 3;252,253,254;,
 3;255,256,257;,
 3;258,259,260;,
 3;261,262,263;,
 3;264,265,266;,
 3;267,268,269;,
 3;270,271,272;,
 3;273,274,275;,
 3;276,277,278;,
 3;279,280,281;,
 3;282,283,284;,
 3;285,286,287;,
 3;288,289,290;,
 3;291,292,293;,
 3;294,295,296;,
 3;297,298,299;,
 3;300,301,302;,
 3;303,304,305;,
 3;306,307,308;,
 3;309,310,311;,
 3;312,313,314;,
 3;315,316,317;,
 3;318,319,320;,
 3;321,322,323;,
 3;324,325,326;,
 3;327,328,329;,
 3;330,331,332;,
 3;333,334,335;,
 3;336,337,338;,
 3;339,340,341;,
 3;342,343,344;,
 3;345,346,347;,
 3;348,349,350;,
 3;351,352,353;,
 3;354,355,356;,
 3;357,358,359;;

 MeshNormals  {
  360;
  0.685664;0.727918;0.000000;,
  0.685664;0.727918;0.000000;,
  0.480631;0.876923;0.000000;,
  0.480631;0.876923;0.000000;,
  0.480631;0.876923;0.000000;,
  0.685664;0.727918;0.000000;,
  0.480631;0.876923;0.000000;,
  0.480631;0.876923;0.000000;,
  -0.000000;1.000000;0.000000;,
  -0.000000;1.000000;0.000000;,
  0.000000;1.000000;0.000000;,
  0.480631;0.876923;0.000000;,
  0.000000;1.000000;0.000000;,
  -0.000000;1.000000;0.000000;,
  -0.480631;0.876923;0.000000;,
  -0.480631;0.876923;0.000000;,
  -0.480631;0.876923;0.000000;,
  0.000000;1.000000;0.000000;,
  -0.480631;0.876923;0.000000;,
  -0.480631;0.876923;0.000000;,
  -0.854499;0.519453;0.000000;,
  -0.854499;0.519453;0.000000;,
  -0.854499;0.519453;0.000000;,
  -0.480631;0.876923;0.000000;,
  -1.000000;-0.000000;0.000000;,
  -0.854499;0.519453;0.000000;,
  -0.854499;0.519453;0.000000;,
  -0.854499;0.519453;0.000000;,
  -1.000000;0.000000;0.000000;,
  -1.000000;-0.000000;0.000000;,
  -0.854499;-0.519453;0.000000;,
  -1.000000;-0.000000;0.000000;,
  -1.000000;0.000000;0.000000;,
  -1.000000;0.000000;0.000000;,
  -0.854499;-0.519453;0.000000;,
  -0.854499;-0.519453;0.000000;,
  -0.854499;-0.519453;0.000000;,
  -0.854499;-0.519453;0.000000;,
  -0.480631;-0.876923;0.000000;,
  -0.480631;-0.876923;0.000000;,
  -0.480632;-0.876923;0.000000;,
  -0.854499;-0.519453;0.000000;,
  -0.480632;-0.876923;0.000000;,
  -0.480631;-0.876923;0.000000;,
  -0.000000;-1.000000;0.000000;,
  -0.000000;-1.000000;0.000000;,
  -0.000001;-1.000000;0.000000;,
  -0.480632;-0.876923;0.000000;,
  -0.000001;-1.000000;0.000000;,
  -0.000000;-1.000000;0.000000;,
  0.480631;-0.876923;0.000000;,
  0.480631;-0.876923;0.000000;,
  0.480630;-0.876923;0.000000;,
  -0.000001;-1.000000;0.000000;,
  0.480630;-0.876923;0.000000;,
  0.480631;-0.876923;0.000000;,
  0.854499;-0.519453;0.000000;,
  0.854499;-0.519453;0.000000;,
  0.854499;-0.519453;0.000000;,
  0.480630;-0.876923;0.000000;,
  0.854499;-0.519453;0.000000;,
  1.000000;-0.000001;0.000000;,
  1.000000;-0.000000;0.000000;,
  1.000000;-0.000000;0.000000;,
  0.854499;-0.519453;0.000000;,
  0.854499;-0.519453;0.000000;,
  1.000000;-0.000001;0.000000;,
  0.961842;0.273606;0.000000;,
  0.961842;0.273606;0.000000;,
  0.961842;0.273606;0.000000;,
  1.000000;-0.000000;0.000000;,
  1.000000;-0.000001;0.000000;,
  0.000000;0.000000;-1.000000;,
  0.000000;0.000000;-1.000000;,
  0.000000;0.000000;-1.000000;,
  0.000000;0.000000;-1.000000;,
  0.000000;0.000000;-1.000000;,
  0.000000;0.000000;-1.000000;,
  0.000000;0.000000;-1.000000;,
  0.000000;0.000000;-1.000000;,
  0.000000;0.000000;-1.000000;,
  0.000000;0.000000;-1.000000;,
  0.000000;0.000000;-1.000000;,
  0.000000;0.000000;-1.000000;,
  0.000000;0.000000;-1.000000;,
  0.000000;0.000000;-1.000000;,
  0.000000;0.000000;-1.000000;,
  0.000000;0.000000;-1.000000;,
  0.000000;0.000000;-1.000000;,
  0.000000;0.000000;-1.000000;,
  0.000000;0.000000;-1.000000;,
  0.000000;0.000000;-1.000000;,
  0.000000;0.000000;-1.000000;,
  0.000000;0.000000;-1.000000;,
  0.000000;0.000000;-1.000000;,
  0.000000;0.000000;-1.000000;,
  0.000000;0.000000;-1.000000;,
  0.000000;0.000000;-1.000000;,
  0.000000;0.000000;-1.000000;,
  0.000000;0.000000;-1.000000;,
  0.000000;0.000000;-1.000000;,
  0.000000;0.000000;-1.000000;,
  0.000000;0.000000;-1.000000;,
  0.000000;0.000000;-1.000000;,
  0.000000;0.000000;-1.000000;,
  0.000000;0.000000;-1.000000;,
  0.000000;0.000000;-1.000000;,
  0.000000;0.000000;-1.000000;,
  0.333820;0.610856;-0.717927;,
  0.601934;0.366808;-0.709315;,
  -0.335804;-0.208625;-0.918538;,
  -0.335804;-0.208625;-0.918538;,
  -0.191601;-0.357231;-0.914153;,
  0.333820;0.610856;-0.717927;,
  -0.000015;0.691815;-0.722075;,
  0.333820;0.610856;-0.717927;,
  -0.191601;-0.357231;-0.914153;,
  -0.191601;-0.357231;-0.914153;,
  0.000015;-0.410144;-0.912021;,
  -0.000015;0.691815;-0.722075;,
  -0.000015;0.691815;-0.722075;,
  0.000015;-0.410144;-0.912021;,
  0.191653;-0.357274;-0.914125;,
  0.191653;-0.357274;-0.914125;,
  -0.333836;0.610832;-0.717940;,
  -0.000015;0.691815;-0.722075;,
  -0.333836;0.610832;-0.717940;,
  0.191653;-0.357274;-0.914125;,
  0.335904;-0.208669;-0.918491;,
  0.335904;-0.208669;-0.918491;,
  -0.601924;0.366785;-0.709335;,
  -0.333836;0.610832;-0.717940;,
  -0.601924;0.366785;-0.709335;,
  0.335904;-0.208669;-0.918491;,
  0.390182;0.000016;-0.920738;,
  0.390182;0.000016;-0.920738;,
  -0.709343;-0.000015;-0.704864;,
  -0.601924;0.366785;-0.709335;,
  0.390182;0.000016;-0.920738;,
  0.335949;0.208729;-0.918461;,
  -0.601899;-0.366801;-0.709348;,
  -0.601899;-0.366801;-0.709348;,
  -0.709343;-0.000015;-0.704864;,
  0.390182;0.000016;-0.920738;,
  0.335949;0.208729;-0.918461;,
  0.191696;0.357387;-0.914072;,
  -0.333811;-0.610819;-0.717963;,
  -0.333811;-0.610819;-0.717963;,
  -0.601899;-0.366801;-0.709348;,
  0.335949;0.208729;-0.918461;,
  0.191696;0.357387;-0.914072;,
  0.000015;0.410282;-0.911959;,
  -0.000015;-0.691787;-0.722102;,
  -0.000015;-0.691787;-0.722102;,
  -0.333811;-0.610819;-0.717963;,
  0.191696;0.357387;-0.914072;,
  -0.191643;0.357344;-0.914100;,
  0.333795;-0.610843;-0.717950;,
  -0.000015;-0.691787;-0.722102;,
  -0.000015;-0.691787;-0.722102;,
  0.000015;0.410282;-0.911959;,
  -0.191643;0.357344;-0.914100;,
  -0.335849;0.208684;-0.918508;,
  0.601910;-0.366824;-0.709327;,
  0.333795;-0.610843;-0.717950;,
  0.333795;-0.610843;-0.717950;,
  -0.191643;0.357344;-0.914100;,
  -0.335849;0.208684;-0.918508;,
  -0.390056;0.000016;-0.920791;,
  0.709366;-0.000015;-0.704840;,
  0.601910;-0.366824;-0.709327;,
  0.601910;-0.366824;-0.709327;,
  -0.335849;0.208684;-0.918508;,
  -0.390056;0.000016;-0.920791;,
  0.601934;0.366808;-0.709315;,
  0.709366;-0.000015;-0.704840;,
  -0.390056;0.000016;-0.920791;,
  -0.390056;0.000016;-0.920791;,
  -0.335804;-0.208625;-0.918538;,
  0.601934;0.366808;-0.709315;,
  0.848244;0.516459;0.117265;,
  0.601934;0.366808;-0.709315;,
  0.333820;0.610856;-0.717927;,
  0.333820;0.610856;-0.717927;,
  0.476951;0.871535;0.113771;,
  0.848244;0.516459;0.117265;,
  0.476951;0.871535;0.113771;,
  0.333820;0.610856;-0.717927;,
  -0.000015;0.691815;-0.722075;,
  -0.000015;0.691815;-0.722075;,
  -0.000000;0.993693;0.112138;,
  0.476951;0.871535;0.113771;,
  -0.000000;0.993693;0.112138;,
  -0.000015;0.691815;-0.722075;,
  -0.333836;0.610832;-0.717940;,
  -0.333836;0.610832;-0.717940;,
  -0.476950;0.871532;0.113800;,
  -0.000000;0.993693;0.112138;,
  -0.476950;0.871532;0.113800;,
  -0.333836;0.610832;-0.717940;,
  -0.601924;0.366785;-0.709335;,
  -0.601924;0.366785;-0.709335;,
  -0.848239;0.516456;0.117317;,
  -0.476950;0.871532;0.113800;,
  -0.992871;-0.000000;0.119195;,
  -0.848239;0.516456;0.117317;,
  -0.601924;0.366785;-0.709335;,
  -0.601924;0.366785;-0.709335;,
  -0.709343;-0.000015;-0.704864;,
  -0.992871;-0.000000;0.119195;,
  -0.848236;-0.516455;0.117348;,
  -0.992871;-0.000000;0.119195;,
  -0.709343;-0.000015;-0.704864;,
  -0.709343;-0.000015;-0.704864;,
  -0.601899;-0.366801;-0.709348;,
  -0.848236;-0.516455;0.117348;,
  -0.848236;-0.516455;0.117348;,
  -0.601899;-0.366801;-0.709348;,
  -0.333811;-0.610819;-0.717963;,
  -0.333811;-0.610819;-0.717963;,
  -0.476948;-0.871527;0.113852;,
  -0.848236;-0.516455;0.117348;,
  -0.476948;-0.871527;0.113852;,
  -0.333811;-0.610819;-0.717963;,
  -0.000015;-0.691787;-0.722102;,
  -0.000015;-0.691787;-0.722102;,
  -0.000001;-0.993686;0.112197;,
  -0.476948;-0.871527;0.113852;,
  -0.000001;-0.993686;0.112197;,
  -0.000015;-0.691787;-0.722102;,
  0.333795;-0.610843;-0.717950;,
  0.333795;-0.610843;-0.717950;,
  0.476948;-0.871530;0.113824;,
  -0.000001;-0.993686;0.112197;,
  0.476948;-0.871530;0.113824;,
  0.333795;-0.610843;-0.717950;,
  0.601910;-0.366824;-0.709327;,
  0.601910;-0.366824;-0.709327;,
  0.848241;-0.516459;0.117297;,
  0.476948;-0.871530;0.113824;,
  0.709366;-0.000015;-0.704840;,
  0.992878;-0.000001;0.119135;,
  0.848241;-0.516459;0.117297;,
  0.848241;-0.516459;0.117297;,
  0.601910;-0.366824;-0.709327;,
  0.709366;-0.000015;-0.704840;,
  0.601934;0.366808;-0.709315;,
  0.848244;0.516459;0.117265;,
  0.992878;-0.000001;0.119135;,
  0.992878;-0.000001;0.119135;,
  0.709366;-0.000015;-0.704840;,
  0.601934;0.366808;-0.709315;,
  0.637810;0.387989;0.665329;,
  0.848244;0.516459;0.117265;,
  0.476951;0.871535;0.113771;,
  0.476951;0.871535;0.113771;,
  0.357623;0.652916;0.667687;,
  0.637810;0.387989;0.665329;,
  0.357623;0.652916;0.667687;,
  0.476951;0.871535;0.113771;,
  -0.000000;0.993693;0.112138;,
  -0.000000;0.993693;0.112138;,
  0.000004;0.743452;0.668790;,
  0.357623;0.652916;0.667687;,
  0.000004;0.743452;0.668790;,
  -0.000000;0.993693;0.112138;,
  -0.476950;0.871532;0.113800;,
  -0.476950;0.871532;0.113800;,
  -0.357613;0.652910;0.667699;,
  0.000004;0.743452;0.668790;,
  -0.357613;0.652910;0.667699;,
  -0.476950;0.871532;0.113800;,
  -0.848239;0.516456;0.117317;,
  -0.848239;0.516456;0.117317;,
  -0.637792;0.387983;0.665350;,
  -0.357613;0.652910;0.667699;,
  -0.747650;0.000004;0.664093;,
  -0.637792;0.387983;0.665350;,
  -0.848239;0.516456;0.117317;,
  -0.848239;0.516456;0.117317;,
  -0.992871;-0.000000;0.119195;,
  -0.747650;0.000004;0.664093;,
  -0.637786;-0.387972;0.665362;,
  -0.747650;0.000004;0.664093;,
  -0.992871;-0.000000;0.119195;,
  -0.992871;-0.000000;0.119195;,
  -0.848236;-0.516455;0.117348;,
  -0.637786;-0.387972;0.665362;,
  -0.637786;-0.387972;0.665362;,
  -0.848236;-0.516455;0.117348;,
  -0.476948;-0.871527;0.113852;,
  -0.476948;-0.871527;0.113852;,
  -0.357607;-0.652892;0.667719;,
  -0.637786;-0.387972;0.665362;,
  -0.357607;-0.652892;0.667719;,
  -0.476948;-0.871527;0.113852;,
  -0.000001;-0.993686;0.112197;,
  -0.000001;-0.993686;0.112197;,
  0.000003;-0.743430;0.668814;,
  -0.357607;-0.652892;0.667719;,
  0.000003;-0.743430;0.668814;,
  -0.000001;-0.993686;0.112197;,
  0.476948;-0.871530;0.113824;,
  0.476948;-0.871530;0.113824;,
  0.357617;-0.652899;0.667708;,
  0.000003;-0.743430;0.668814;,
  0.357617;-0.652899;0.667708;,
  0.476948;-0.871530;0.113824;,
  0.848241;-0.516459;0.117297;,
  0.848241;-0.516459;0.117297;,
  0.637804;-0.387978;0.665342;,
  0.357617;-0.652899;0.667708;,
  0.992878;-0.000001;0.119135;,
  0.747671;0.000004;0.664069;,
  0.637804;-0.387978;0.665342;,
  0.637804;-0.387978;0.665342;,
  0.848241;-0.516459;0.117297;,
  0.992878;-0.000001;0.119135;,
  0.848244;0.516459;0.117265;,
  0.637810;0.387989;0.665329;,
  0.747671;0.000004;0.664069;,
  0.747671;0.000004;0.664069;,
  0.992878;-0.000001;0.119135;,
  0.848244;0.516459;0.117265;,
  0.000000;0.000000;1.000000;,
  0.637810;0.387989;0.665329;,
  0.357623;0.652916;0.667687;,
  0.000000;0.000000;1.000000;,
  0.357623;0.652916;0.667687;,
  0.000004;0.743452;0.668790;,
  0.000000;0.000000;1.000000;,
  0.000004;0.743452;0.668790;,
  -0.357613;0.652910;0.667699;,
  0.000000;0.000000;1.000000;,
  -0.357613;0.652910;0.667699;,
  -0.637792;0.387983;0.665350;,
  0.000000;0.000000;1.000000;,
  -0.637792;0.387983;0.665350;,
  -0.747650;0.000004;0.664093;,
  0.000000;0.000000;1.000000;,
  -0.747650;0.000004;0.664093;,
  -0.637786;-0.387972;0.665362;,
  0.000000;0.000000;1.000000;,
  -0.637786;-0.387972;0.665362;,
  -0.357607;-0.652892;0.667719;,
  0.000000;0.000000;1.000000;,
  -0.357607;-0.652892;0.667719;,
  0.000003;-0.743430;0.668814;,
  0.000000;0.000000;1.000000;,
  0.000003;-0.743430;0.668814;,
  0.357617;-0.652899;0.667708;,
  0.000000;0.000000;1.000000;,
  0.357617;-0.652899;0.667708;,
  0.637804;-0.387978;0.665342;,
  0.000000;0.000000;1.000000;,
  0.637804;-0.387978;0.665342;,
  0.747671;0.000004;0.664069;,
  0.000000;0.000000;1.000000;,
  0.747671;0.000004;0.664069;,
  0.637810;0.387989;0.665329;;
  120;
  3;0,1,2;,
  3;3,4,5;,
  3;6,7,8;,
  3;9,10,11;,
  3;12,13,14;,
  3;15,16,17;,
  3;18,19,20;,
  3;21,22,23;,
  3;24,25,26;,
  3;27,28,29;,
  3;30,31,32;,
  3;33,34,35;,
  3;36,37,38;,
  3;39,40,41;,
  3;42,43,44;,
  3;45,46,47;,
  3;48,49,50;,
  3;51,52,53;,
  3;54,55,56;,
  3;57,58,59;,
  3;60,61,62;,
  3;63,64,65;,
  3;66,67,68;,
  3;69,70,71;,
  3;72,73,74;,
  3;75,76,77;,
  3;78,79,80;,
  3;81,82,83;,
  3;84,85,86;,
  3;87,88,89;,
  3;90,91,92;,
  3;93,94,95;,
  3;96,97,98;,
  3;99,100,101;,
  3;102,103,104;,
  3;105,106,107;,
  3;108,109,110;,
  3;111,112,113;,
  3;114,115,116;,
  3;117,118,119;,
  3;120,121,122;,
  3;123,124,125;,
  3;126,127,128;,
  3;129,130,131;,
  3;132,133,134;,
  3;135,136,137;,
  3;138,139,140;,
  3;141,142,143;,
  3;144,145,146;,
  3;147,148,149;,
  3;150,151,152;,
  3;153,154,155;,
  3;156,157,158;,
  3;159,160,161;,
  3;162,163,164;,
  3;165,166,167;,
  3;168,169,170;,
  3;171,172,173;,
  3;174,175,176;,
  3;177,178,179;,
  3;180,181,182;,
  3;183,184,185;,
  3;186,187,188;,
  3;189,190,191;,
  3;192,193,194;,
  3;195,196,197;,
  3;198,199,200;,
  3;201,202,203;,
  3;204,205,206;,
  3;207,208,209;,
  3;210,211,212;,
  3;213,214,215;,
  3;216,217,218;,
  3;219,220,221;,
  3;222,223,224;,
  3;225,226,227;,
  3;228,229,230;,
  3;231,232,233;,
  3;234,235,236;,
  3;237,238,239;,
  3;240,241,242;,
  3;243,244,245;,
  3;246,247,248;,
  3;249,250,251;,
  3;252,253,254;,
  3;255,256,257;,
  3;258,259,260;,
  3;261,262,263;,
  3;264,265,266;,
  3;267,268,269;,
  3;270,271,272;,
  3;273,274,275;,
  3;276,277,278;,
  3;279,280,281;,
  3;282,283,284;,
  3;285,286,287;,
  3;288,289,290;,
  3;291,292,293;,
  3;294,295,296;,
  3;297,298,299;,
  3;300,301,302;,
  3;303,304,305;,
  3;306,307,308;,
  3;309,310,311;,
  3;312,313,314;,
  3;315,316,317;,
  3;318,319,320;,
  3;321,322,323;,
  3;324,325,326;,
  3;327,328,329;,
  3;330,331,332;,
  3;333,334,335;,
  3;336,337,338;,
  3;339,340,341;,
  3;342,343,344;,
  3;345,346,347;,
  3;348,349,350;,
  3;351,352,353;,
  3;354,355,356;,
  3;357,358,359;;
 }

 MeshMaterialList  {
  1;
  120;
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0;

  Material ac3dmat1 {
   1.000000;1.000000;1.000000;1.000000;;
   32.000000;
   0.000000;0.000000;0.000000;;
   0.000000;0.000000;0.000000;;
  }
 }
}