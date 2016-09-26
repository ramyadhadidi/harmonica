module h2_rom(
  phi,
  imem_req_contents_addr,
  imem_req_contents_data_0,
  imem_req_contents_data_1,
  imem_req_contents_data_2,
  imem_req_contents_data_3,
  imem_req_contents_llsc,
  imem_req_contents_mask,
  imem_req_contents_wr,
  imem_req_valid,
  imem_resp_ready,
  imem_req_ready,
  imem_resp_contents_data_0,
  imem_resp_contents_data_1,
  imem_resp_contents_data_2,
  imem_resp_contents_data_3,
  imem_resp_contents_llsc,
  imem_resp_contents_llsc_suc,
  imem_resp_contents_wr,
  imem_resp_valid
);

  input phi;
  input [29:0] imem_req_contents_addr;
  assign __x169 = imem_req_contents_addr[0];
  assign __x170 = imem_req_contents_addr[1];
  assign __x171 = imem_req_contents_addr[2];
  assign __x172 = imem_req_contents_addr[3];
  assign __x173 = imem_req_contents_addr[4];
  assign __x174 = imem_req_contents_addr[5];
  assign __x175 = imem_req_contents_addr[6];
  assign __x176 = imem_req_contents_addr[7];
  assign __x177 = imem_req_contents_addr[8];
  assign __x178 = imem_req_contents_addr[9];
  assign __x179 = imem_req_contents_addr[10];
  assign __x180 = imem_req_contents_addr[11];
  assign __x181 = imem_req_contents_addr[12];
  assign __x182 = imem_req_contents_addr[13];
  assign __x183 = imem_req_contents_addr[14];
  assign __x184 = imem_req_contents_addr[15];
  assign __x185 = imem_req_contents_addr[16];
  assign __x186 = imem_req_contents_addr[17];
  assign __x187 = imem_req_contents_addr[18];
  assign __x188 = imem_req_contents_addr[19];
  assign __x189 = imem_req_contents_addr[20];
  assign __x190 = imem_req_contents_addr[21];
  assign __x191 = imem_req_contents_addr[22];
  assign __x192 = imem_req_contents_addr[23];
  assign __x193 = imem_req_contents_addr[24];
  assign __x194 = imem_req_contents_addr[25];
  assign __x195 = imem_req_contents_addr[26];
  assign __x196 = imem_req_contents_addr[27];
  assign __x197 = imem_req_contents_addr[28];
  assign __x198 = imem_req_contents_addr[29];
  input [7:0] imem_req_contents_data_0;
  assign __x199 = imem_req_contents_data_0[0];
  assign __x200 = imem_req_contents_data_0[1];
  assign __x201 = imem_req_contents_data_0[2];
  assign __x202 = imem_req_contents_data_0[3];
  assign __x203 = imem_req_contents_data_0[4];
  assign __x204 = imem_req_contents_data_0[5];
  assign __x205 = imem_req_contents_data_0[6];
  assign __x206 = imem_req_contents_data_0[7];
  input [7:0] imem_req_contents_data_1;
  assign __x207 = imem_req_contents_data_1[0];
  assign __x208 = imem_req_contents_data_1[1];
  assign __x209 = imem_req_contents_data_1[2];
  assign __x210 = imem_req_contents_data_1[3];
  assign __x211 = imem_req_contents_data_1[4];
  assign __x212 = imem_req_contents_data_1[5];
  assign __x213 = imem_req_contents_data_1[6];
  assign __x214 = imem_req_contents_data_1[7];
  input [7:0] imem_req_contents_data_2;
  assign __x215 = imem_req_contents_data_2[0];
  assign __x216 = imem_req_contents_data_2[1];
  assign __x217 = imem_req_contents_data_2[2];
  assign __x218 = imem_req_contents_data_2[3];
  assign __x219 = imem_req_contents_data_2[4];
  assign __x220 = imem_req_contents_data_2[5];
  assign __x221 = imem_req_contents_data_2[6];
  assign __x222 = imem_req_contents_data_2[7];
  input [7:0] imem_req_contents_data_3;
  assign __x223 = imem_req_contents_data_3[0];
  assign __x224 = imem_req_contents_data_3[1];
  assign __x225 = imem_req_contents_data_3[2];
  assign __x226 = imem_req_contents_data_3[3];
  assign __x227 = imem_req_contents_data_3[4];
  assign __x228 = imem_req_contents_data_3[5];
  assign __x229 = imem_req_contents_data_3[6];
  assign __x230 = imem_req_contents_data_3[7];
  input imem_req_contents_llsc;
  assign __x231 = imem_req_contents_llsc;
  input [3:0] imem_req_contents_mask;
  assign __x232 = imem_req_contents_mask[0];
  assign __x233 = imem_req_contents_mask[1];
  assign __x234 = imem_req_contents_mask[2];
  assign __x235 = imem_req_contents_mask[3];
  input imem_req_contents_wr;
  assign __x236 = imem_req_contents_wr;
  input imem_req_valid;
  assign __x237 = imem_req_valid;
  input imem_resp_ready;
  assign __x238 = imem_resp_ready;
  output imem_req_ready;
  assign imem_req_ready = __x16;
  output [7:0] imem_resp_contents_data_0;
  assign imem_resp_contents_data_0[0] = __x137;
  assign imem_resp_contents_data_0[1] = __x138;
  assign imem_resp_contents_data_0[2] = __x139;
  assign imem_resp_contents_data_0[3] = __x140;
  assign imem_resp_contents_data_0[4] = __x141;
  assign imem_resp_contents_data_0[5] = __x142;
  assign imem_resp_contents_data_0[6] = __x143;
  assign imem_resp_contents_data_0[7] = __x144;
  output [7:0] imem_resp_contents_data_1;
  assign imem_resp_contents_data_1[0] = __x145;
  assign imem_resp_contents_data_1[1] = __x146;
  assign imem_resp_contents_data_1[2] = __x147;
  assign imem_resp_contents_data_1[3] = __x148;
  assign imem_resp_contents_data_1[4] = __x149;
  assign imem_resp_contents_data_1[5] = __x150;
  assign imem_resp_contents_data_1[6] = __x151;
  assign imem_resp_contents_data_1[7] = __x152;
  output [7:0] imem_resp_contents_data_2;
  assign imem_resp_contents_data_2[0] = __x153;
  assign imem_resp_contents_data_2[1] = __x154;
  assign imem_resp_contents_data_2[2] = __x155;
  assign imem_resp_contents_data_2[3] = __x156;
  assign imem_resp_contents_data_2[4] = __x157;
  assign imem_resp_contents_data_2[5] = __x158;
  assign imem_resp_contents_data_2[6] = __x159;
  assign imem_resp_contents_data_2[7] = __x160;
  output [7:0] imem_resp_contents_data_3;
  assign imem_resp_contents_data_3[0] = __x161;
  assign imem_resp_contents_data_3[1] = __x162;
  assign imem_resp_contents_data_3[2] = __x163;
  assign imem_resp_contents_data_3[3] = __x164;
  assign imem_resp_contents_data_3[4] = __x165;
  assign imem_resp_contents_data_3[5] = __x166;
  assign imem_resp_contents_data_3[6] = __x167;
  assign imem_resp_contents_data_3[7] = __x168;
  output imem_resp_contents_llsc;
  assign imem_resp_contents_llsc = __x244;
  output imem_resp_contents_llsc_suc;
  assign imem_resp_contents_llsc_suc = __x244;
  output imem_resp_contents_wr;
  assign imem_resp_contents_wr = __x244;
  output imem_resp_valid;
  assign imem_resp_valid = __x14;
  wire reset;
  assign reset = 0;
  reg __x0;
  wire __x1;
  wire __x2;
  wire __x3;
  wire __x4;
  wire __x5;
  wire __x6;
  wire __x7;
  wire __x8;
  wire __x9;
  wire __x10;
  wire __x11;
  reg __x12;
  wire __x13;
  wire __x14;
  wire __x15;
  wire __x16;
  wire __x17;
  wire __x18;
  wire __x19;
  wire __x20;
  wire __x21;
  wire __x22;
  wire __x23;
  wire __x24;
  wire __x25;
  wire __x26;
  wire __x27;
  wire __x28;
  wire __x29;
  wire __x30;
  wire __x31;
  wire __x32;
  wire __x33;
  wire __x34;
  wire __x35;
  wire __x36;
  wire __x37;
  wire __x38;
  wire __x39;
  wire __x40;
  wire __x41;
  wire __x42;
  wire __x43;
  wire __x44;
  wire __x45;
  wire __x46;
  wire __x47;
  wire __x48;
  wire __x49;
  wire __x50;
  wire __x51;
  wire __x52;
  wire __x53;
  wire __x54;
  wire __x55;
  wire __x56;
  wire __x57;
  wire __x58;
  wire __x59;
  wire __x60;
  wire __x61;
  wire __x62;
  wire __x63;
  wire __x64;
  wire __x65;
  wire __x66;
  wire __x67;
  wire __x68;
  wire __x69;
  wire __x70;
  wire __x71;
  wire __x72;
  wire __x73;
  wire __x74;
  wire __x75;
  wire __x76;
  wire __x77;
  wire __x78;
  wire __x79;
  wire __x80;
  wire __x81;
  wire __x82;
  wire __x83;
  wire __x84;
  wire __x85;
  wire __x86;
  wire __x87;
  wire __x88;
  wire __x89;
  wire __x90;
  wire __x91;
  wire __x92;
  wire __x93;
  wire __x94;
  wire __x95;
  wire __x96;
  wire __x97;
  wire __x98;
  wire __x99;
  wire __x100;
  wire __x101;
  wire __x102;
  wire __x103;
  wire __x104;
  wire __x105;
  wire __x106;
  wire __x107;
  wire __x108;
  wire __x109;
  wire __x110;
  wire __x111;
  wire __x112;
  wire __x113;
  wire __x114;
  wire __x115;
  wire __x116;
  wire __x117;
  wire __x118;
  wire __x119;
  wire __x120;
  wire __x121;
  wire __x122;
  wire __x123;
  wire __x124;
  wire __x125;
  wire __x126;
  wire __x127;
  wire __x128;
  wire __x129;
  wire __x130;
  wire __x131;
  wire __x132;
  wire __x133;
  wire __x134;
  wire __x135;
  wire __x136;
  reg __x137;
  reg __x138;
  reg __x139;
  reg __x140;
  reg __x141;
  reg __x142;
  reg __x143;
  reg __x144;
  reg __x145;
  reg __x146;
  reg __x147;
  reg __x148;
  reg __x149;
  reg __x150;
  reg __x151;
  reg __x152;
  reg __x153;
  reg __x154;
  reg __x155;
  reg __x156;
  reg __x157;
  reg __x158;
  reg __x159;
  reg __x160;
  reg __x161;
  reg __x162;
  reg __x163;
  reg __x164;
  reg __x165;
  reg __x166;
  reg __x167;
  reg __x168;
  wire __x169;
  wire __x170;
  wire __x171;
  wire __x172;
  wire __x173;
  wire __x174;
  wire __x175;
  wire __x176;
  wire __x177;
  wire __x178;
  wire __x179;
  wire __x180;
  wire __x181;
  wire __x182;
  wire __x183;
  wire __x184;
  wire __x185;
  wire __x186;
  wire __x187;
  wire __x188;
  wire __x189;
  wire __x190;
  wire __x191;
  wire __x192;
  wire __x193;
  wire __x194;
  wire __x195;
  wire __x196;
  wire __x197;
  wire __x198;
  wire __x199;
  wire __x200;
  wire __x201;
  wire __x202;
  wire __x203;
  wire __x204;
  wire __x205;
  wire __x206;
  wire __x207;
  wire __x208;
  wire __x209;
  wire __x210;
  wire __x211;
  wire __x212;
  wire __x213;
  wire __x214;
  wire __x215;
  wire __x216;
  wire __x217;
  wire __x218;
  wire __x219;
  wire __x220;
  wire __x221;
  wire __x222;
  wire __x223;
  wire __x224;
  wire __x225;
  wire __x226;
  wire __x227;
  wire __x228;
  wire __x229;
  wire __x230;
  wire __x231;
  wire __x232;
  wire __x233;
  wire __x234;
  wire __x235;
  wire __x236;
  wire __x237;
  wire __x238;
  wire __x239;
  wire __x240;
  wire __x241;
  wire __x242;
  wire __x243;
  wire __x244;
  initial
    begin
      __x0 <= 0;
    end
  always @ (posedge phi)
    begin
      __x0 <= __x10;
    end
  not __i1(__x1, __x236);
  nand __n2(__x2, __x237, __x16);
  not __i3(__x3, __x2);
  nand __n4(__x4, __x3, __x1);
  not __i5(__x5, __x4);
  nand __n6(__x6, __x0, __x238);
  not __i7(__x7, __x0);
  nand __n8(__x8, __x7, __x5);
  nand __n9(__x9, __x8, __x239);
  nand __n10(__x10, __x9, __x8);
  nand __n11(__x11, __x6, __x0);
  initial
    begin
      __x12 <= 0;
    end
  always @ (posedge phi)
    begin
      __x12 <= __x5;
    end
  not __i13(__x13, __x12);
  nand __n14(__x14, __x13, __x7);
  not __i15(__x15, __x238);
  nand __n16(__x16, __x0, __x15);
  not __i17(__x17, __x171);
  nand __n18(__x18, __x169, __x170);
  not __i19(__x19, __x18);
  nand __n20(__x20, __x17, __x19);
  not __i21(__x21, __x20);
  not __i22(__x22, __x170);
  nand __n23(__x23, __x22, __x171);
  not __i24(__x24, __x172);
  nand __n25(__x25, __x23, __x24);
  nand __n26(__x26, __x170, __x171);
  not __i27(__x27, __x26);
  nand __n28(__x28, __x169, __x27);
  not __i29(__x29, __x28);
  nand __n30(__x30, __x28, __x24);
  nand __n31(__x31, __x169, __x171);
  nand __n32(__x32, __x31, __x24);
  not __i33(__x33, __x169);
  nand __n34(__x34, __x33, __x170);
  not __i35(__x35, __x34);
  nand __n36(__x36, __x17, __x35);
  nand __n37(__x37, __x33, __x171);
  not __i38(__x38, __x37);
  nand __n39(__x39, __x22, __x38);
  nand __n40(__x40, __x36, __x39);
  not __i41(__x41, __x30);
  not __i42(__x42, __x40);
  nand __n43(__x43, __x42, __x41);
  nand __n44(__x44, __x26, __x24);
  nand __n45(__x45, __x22, __x169);
  not __i46(__x46, __x45);
  nand __n47(__x47, __x17, __x46);
  nand __n48(__x48, __x47, __x39);
  not __i49(__x49, __x48);
  nand __n50(__x50, __x49, __x41);
  nand __n51(__x51, __x17, __x22);
  not __i52(__x52, __x32);
  nand __n53(__x53, __x51, __x52);
  nand __n54(__x54, __x33, __x27);
  not __i55(__x55, __x54);
  nand __n56(__x56, __x18, __x24);
  not __i57(__x57, __x56);
  nand __n58(__x58, __x23, __x57);
  not __i59(__x59, __x51);
  nand __n60(__x60, __x24, __x59);
  nand __n61(__x61, __x47, __x34);
  not __i62(__x62, __x61);
  nand __n63(__x63, __x60, __x62);
  nand __n64(__x64, __x5, __x21);
  nand __n65(__x65, __x4, __x137);
  nand __n66(__x66, __x65, __x64);
  nand __n67(__x67, __x4, __x138);
  nand __n68(__x68, __x5, __x25);
  nand __n69(__x69, __x4, __x139);
  nand __n70(__x70, __x69, __x68);
  nand __n71(__x71, __x5, __x30);
  nand __n72(__x72, __x4, __x140);
  nand __n73(__x73, __x72, __x71);
  nand __n74(__x74, __x5, __x172);
  nand __n75(__x75, __x4, __x141);
  nand __n76(__x76, __x75, __x74);
  nand __n77(__x77, __x5, __x32);
  nand __n78(__x78, __x4, __x142);
  nand __n79(__x79, __x78, __x77);
  nand __n80(__x80, __x4, __x143);
  nand __n81(__x81, __x80, __x77);
  nand __n82(__x82, __x4, __x144);
  nand __n83(__x83, __x82, __x71);
  nand __n84(__x84, __x4, __x145);
  nand __n85(__x85, __x84, __x71);
  nand __n86(__x86, __x4, __x146);
  nand __n87(__x87, __x86, __x71);
  nand __n88(__x88, __x4, __x147);
  nand __n89(__x89, __x88, __x71);
  nand __n90(__x90, __x4, __x148);
  nand __n91(__x91, __x90, __x71);
  nand __n92(__x92, __x4, __x149);
  nand __n93(__x93, __x92, __x71);
  nand __n94(__x94, __x4, __x150);
  nand __n95(__x95, __x94, __x71);
  nand __n96(__x96, __x4, __x151);
  nand __n97(__x97, __x96, __x71);
  nand __n98(__x98, __x4, __x152);
  nand __n99(__x99, __x98, __x71);
  nand __n100(__x100, __x5, __x43);
  nand __n101(__x101, __x4, __x153);
  nand __n102(__x102, __x101, __x100);
  nand __n103(__x103, __x5, __x44);
  nand __n104(__x104, __x4, __x154);
  nand __n105(__x105, __x104, __x103);
  nand __n106(__x106, __x4, __x155);
  nand __n107(__x107, __x106, __x71);
  nand __n108(__x108, __x5, __x50);
  nand __n109(__x109, __x4, __x156);
  nand __n110(__x110, __x109, __x108);
  nand __n111(__x111, __x4, __x157);
  nand __n112(__x112, __x111, __x77);
  nand __n113(__x113, __x4, __x158);
  nand __n114(__x114, __x113, __x71);
  nand __n115(__x115, __x5, __x53);
  nand __n116(__x116, __x4, __x159);
  nand __n117(__x117, __x116, __x115);
  nand __n118(__x118, __x5, __x55);
  nand __n119(__x119, __x4, __x160);
  nand __n120(__x120, __x119, __x118);
  nand __n121(__x121, __x4, __x161);
  nand __n122(__x122, __x121, __x4);
  nand __n123(__x123, __x4, __x162);
  nand __n124(__x124, __x123, __x71);
  nand __n125(__x125, __x5, __x58);
  nand __n126(__x126, __x4, __x163);
  nand __n127(__x127, __x126, __x125);
  nand __n128(__x128, __x5, __x63);
  nand __n129(__x129, __x4, __x164);
  nand __n130(__x130, __x129, __x128);
  nand __n131(__x131, __x4, __x165);
  nand __n132(__x132, __x4, __x166);
  nand __n133(__x133, __x4, __x167);
  nand __n134(__x134, __x5, __x29);
  nand __n135(__x135, __x4, __x168);
  nand __n136(__x136, __x135, __x134);
  initial
    begin
      __x137 <= 0;
    end
  always @ (posedge phi)
    begin
      __x137 <= __x66;
    end
  initial
    begin
      __x138 <= 0;
    end
  always @ (posedge phi)
    begin
      __x138 <= __x240;
    end
  initial
    begin
      __x139 <= 0;
    end
  always @ (posedge phi)
    begin
      __x139 <= __x70;
    end
  initial
    begin
      __x140 <= 0;
    end
  always @ (posedge phi)
    begin
      __x140 <= __x73;
    end
  initial
    begin
      __x141 <= 0;
    end
  always @ (posedge phi)
    begin
      __x141 <= __x76;
    end
  initial
    begin
      __x142 <= 0;
    end
  always @ (posedge phi)
    begin
      __x142 <= __x79;
    end
  initial
    begin
      __x143 <= 0;
    end
  always @ (posedge phi)
    begin
      __x143 <= __x81;
    end
  initial
    begin
      __x144 <= 0;
    end
  always @ (posedge phi)
    begin
      __x144 <= __x83;
    end
  initial
    begin
      __x145 <= 0;
    end
  always @ (posedge phi)
    begin
      __x145 <= __x85;
    end
  initial
    begin
      __x146 <= 0;
    end
  always @ (posedge phi)
    begin
      __x146 <= __x87;
    end
  initial
    begin
      __x147 <= 0;
    end
  always @ (posedge phi)
    begin
      __x147 <= __x89;
    end
  initial
    begin
      __x148 <= 0;
    end
  always @ (posedge phi)
    begin
      __x148 <= __x91;
    end
  initial
    begin
      __x149 <= 0;
    end
  always @ (posedge phi)
    begin
      __x149 <= __x93;
    end
  initial
    begin
      __x150 <= 0;
    end
  always @ (posedge phi)
    begin
      __x150 <= __x95;
    end
  initial
    begin
      __x151 <= 0;
    end
  always @ (posedge phi)
    begin
      __x151 <= __x97;
    end
  initial
    begin
      __x152 <= 0;
    end
  always @ (posedge phi)
    begin
      __x152 <= __x99;
    end
  initial
    begin
      __x153 <= 0;
    end
  always @ (posedge phi)
    begin
      __x153 <= __x102;
    end
  initial
    begin
      __x154 <= 0;
    end
  always @ (posedge phi)
    begin
      __x154 <= __x105;
    end
  initial
    begin
      __x155 <= 0;
    end
  always @ (posedge phi)
    begin
      __x155 <= __x107;
    end
  initial
    begin
      __x156 <= 0;
    end
  always @ (posedge phi)
    begin
      __x156 <= __x110;
    end
  initial
    begin
      __x157 <= 0;
    end
  always @ (posedge phi)
    begin
      __x157 <= __x112;
    end
  initial
    begin
      __x158 <= 0;
    end
  always @ (posedge phi)
    begin
      __x158 <= __x114;
    end
  initial
    begin
      __x159 <= 0;
    end
  always @ (posedge phi)
    begin
      __x159 <= __x117;
    end
  initial
    begin
      __x160 <= 0;
    end
  always @ (posedge phi)
    begin
      __x160 <= __x120;
    end
  initial
    begin
      __x161 <= 0;
    end
  always @ (posedge phi)
    begin
      __x161 <= __x122;
    end
  initial
    begin
      __x162 <= 0;
    end
  always @ (posedge phi)
    begin
      __x162 <= __x124;
    end
  initial
    begin
      __x163 <= 0;
    end
  always @ (posedge phi)
    begin
      __x163 <= __x127;
    end
  initial
    begin
      __x164 <= 0;
    end
  always @ (posedge phi)
    begin
      __x164 <= __x130;
    end
  initial
    begin
      __x165 <= 0;
    end
  always @ (posedge phi)
    begin
      __x165 <= __x241;
    end
  initial
    begin
      __x166 <= 0;
    end
  always @ (posedge phi)
    begin
      __x166 <= __x242;
    end
  initial
    begin
      __x167 <= 0;
    end
  always @ (posedge phi)
    begin
      __x167 <= __x243;
    end
  initial
    begin
      __x168 <= 0;
    end
  always @ (posedge phi)
    begin
      __x168 <= __x136;
    end
  not __i239(__x239, __x11);
  not __i240(__x240, __x67);
  not __i241(__x241, __x131);
  not __i242(__x242, __x132);
  not __i243(__x243, __x133);
  assign __x244 = 0;
endmodule
