import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
import seaborn as sns
# found cost, optimal
data_60s = [(100,122,0, 0), 
  (101,123,0, 0), 
  (102,124,1, 0), 
  (103,125,0, 0), 
  (104,126,1, 1), 
  (105,127,1, 0), 
  (106,128,0, 0), 
  (107,130,2, 0), 
  (108,131,0, 0), 
  (109,132,1, 0), 
  (110,133,0, 0), 
  (111,134,1, 0), 
  (112,135,0, 0), 
  (113,136,1, 0), 
  (114,138,2, 0), 
  (115,139,0, 0), 
  (116,140,2, 1), 
  (117,141,3, 1), 
  (118,142,2, 0), 
  (119,143,0, 0), 
  (120,144,1, 0), 
  (121,145,3, 2), 
  (122,147,2, 0), 
  (123,148,2, 0), 
  (124,149,1, 0), 
  (125,150,1, 0), 
  (126,151,2, 0), 
  (127,152,"-", 1), 
  (128,153,0, 0), 
  (129,155,"-", 0), 
  (130,156,2, 0), 
  (131,157,3, 0), 
  (132,158,3, 0), 
  (133,159,2, 1), 
  (134,160,"-", 0), 
  (135,161,1, 0), 
  (136,162,2, 0), 
  (137,164,2, 0), 
  (138,165,"-", 0), 
  (139,166,4, 0), 
  (140,167,"-", 0), 
  (141,168,2, 1), 
  (142,169,2, 0), 
  (143,170,4, 1), 
  (144,171,1, 0), 
  (145,173,3, 0), 
  (146,174,1, 0), 
  (147,175,"-", 0), 
  (148,176,"-", 0), 
  (149,177,"-", 0), 
  (150,178,2, 0), 
  (151,179,"-", 0), 
  (152,180,2, 1), 
  (153,182,"-", 0), 
  (154,183,4, 0), 
  (155,184,"-", 0), 
  (156,185,"-", 0), 
  (157,186,"-", 0), 
  (158,187,"-", 0), 
  (159,188,"-", 0), 
  (160,189,5, 0), 
  (161,191,"-", 0), 
  (162,192,"-", 0), 
  (163,193,"-", 0), 
  (164,194,"-", 0), 
  (165,195,"-", 0), 
  (166,196,"-", 0), 
  (167,197,"-", 0), 
  (168,198,"-", 0), 
  (169,200,"-", 0), 
  (170,201,"-", 2), 
  (171,202,"-", 0), 
  (172,203,"-", 1), 
  (173,204,"-", 0), 
  (174,205,"-", 0), 
  (175,206,"-", 0), 
  (176,207,"-", 0), 
  (177,209,"-", 0), 
  (178,210,"-", 0), 
  (179,211,"-", 0), 
  (180,212,"-", 0), 
  (181,213,"-", 0), 
  (182,214,"-", 0), 
  (183,215,"-", 0), 
  (184,216,"-", 1), 
  (185,217,"-", 0), 
  (186,219,"-", 0), 
  (187,220,"-", 0), 
  (188,221,"-", 1), 
  (189,222,"-", 1), 
  (190,223,"-", 0), 
  (191,224,"-", 0), 
  (192,225,"-", 0), 
  (193,226,"-", 1), 
  (194,228,"-", 1), 
  (195,229,"-", 2), 
  (196,230,"-", 1), 
  (197,231,"-", 0), 
  (198,232,"-", 1), 
  (199,233,"-", 0), 
  (200,234,"-", 0)]
         
data_60s_15x = [(100,150,3.0,2),
  (101,152,1.0,1),
  (102,153,2.0,1),
  (103,154,2.0,0),
  (104,156,3.0,1),
  (105,158,1.0,1),
  (106,159,"-" ,1),
  (107,160,3.0,3),
  (108,162,0.0,0),
  (109,164,4.0,0),
  (110,165,4.0,1),
  (111,166,4.0,0),
  (112,168,4.0,3),
  (113,170,3.0,2),
  (114,171,4.0,0),
  (115,172,3.0,1),
  (116,174,2.0,0),
  (117,176,2.0,0),
  (118,177,2.0,1),
  (119,178,6.0,2),
  (120,180,3.0,2),
  (121,182,3.0,1),
  (122,183,3.0,0),
  (123,184,3.0,0),
  (124,186,3.0,1),
  (125,188,1.0,0),
  (126,189,2.0,0),
  (127,190,3.0,0),
  (128,192,4.0,3),
  (129,194,5.0,2),
  (130,195,6.0,2),
  (131,196,6.0,3),
  (132,198,"-"  ,0),
  (133,200,"-"  ,1),
  (134,201,5.0,2),
  (135,202,"-"  ,1),
  (136,204,"-"  ,4),
  (137,206,"-"  ,3),
  (138,207,"-"  ,3),
  (139,208,"-"  ,1),
  (140,210,"-"  ,2),
  (141,212,"-"  ,1),
  (142,213,"-"  ,2),
  (143,214,"-"  ,1),
  (144,216,"-"  ,0),
  (145,218,"-"  ,1),
  (146,219,"-"  ,4),
  (147,220,"-"  ,2),
  (148,222,"-"  ,3),
  (149,224,"-"  ,1),
  (150,225,"-"  ,2),
  (151,226,"-"  ,1),
  (152,228,"-"  ,1),
  (153,230,"-"  ,2),
  (154,231,"-"  ,2),
  (155,232,"-"  ,1),
  (156,234,"-"  ,2),
  (157,236,"-"  ,3),
  (158,237,"-"  ,0),
  (159,238,"-"  ,2),
  (160,240,"-"  ,0),
  (161,242,"-"  ,0),
  (162,243,"-"  ,1),
  (163,244,"-"  ,1),
  (164,246,"-"  ,2),
  (165,248,"-"  ,3),
  (166,249,"-"  ,1),
  (167,250,"-"  ,0),
  (168,252,"-"  ,3),
  (169,254,"-"  ,1),
  (170,255,"-"  ,2),
  (171,256,"-"  ,3),
  (172,258,"-"  ,2),
  (173,260,"-"  ,1),
  (174,261,"-"  ,0),
  (175,262,"-"  ,1),
  (176,264,"-"  ,1),
  (177,266,"-"  ,2),
  (178,267,"-"  ,2),
  (179,268,"-"  ,0),
  (180,270,"-"  ,1),
  (181,272,"-"  ,2),
  (182,273,"-"  ,3),
  (183,274,"-"  ,0),
  (184,276,"-"  ,1),
  (185,278,"-"  ,3),
  (186,279,"-"  ,2),
  (187,280,"-"  ,5),
  (188,282,"-"  ,3),
  (189,284,"-"  ,3),
  (190,285,"-"  ,3),
  (191,286,"-"  ,2),
  (192,288,"-"  ,3),
  (193,290,"-"  ,1),
  (194,291,"-"  ,1),
  (195,292,"-"  ,1),
  (196,294,"-"  ,4),
  (197,296,"-"  ,2),
  (198,297,"-"  ,4),
  (199,298,"-"  ,1),
  (200,300,"-"  ,1)]

data_60s_2x = [(100, 200, 4.0, 4 ), (101, 202, 6.0, 3 ),
  (102, 204, 8.0, 5 ),
  (103, 206, 6.0, 5 ),
  (104, 208, 4.0, 2 ),
  (105, 210, 8.0, 4 ),
  (106, 212, 5.0, 5 ),
  (107, 214, 7.0, 6 ),
  (108, 216, 8.0, 3 ),
  (109, 218, 5.0, 4 ),
  (110, 220, 6.0, 6 ),
  (111, 222, 10., 5 ),
  (112, 224, 7.0, 5 ),
  (113, 226, 5.0, 5 ),
  (114, 228, 8.0, 5 ),
  (115, 230, 9.0, 5 ),
  (116, 232, 5.0, 3 ),
  (117, 234, 6.0, 6 ),
  (118, 236, 9.0, 2 ),
  (119, 238, 7.0, 6 ),
  (120, 240, 6.0, 6 ),
  (121, 242, 8.0, 5 ),
  (122, 244, 10., 4 ),
  (123, 246, 9.0, 5 ),
  (124, 248, "-", 3 ),
  (125, 250, 10., 6 ),
  (126, 252, 8.0, 5 ),
  (127, 254, 13., 4 ),
  (128, 256, "-", 6 ),
  (129, 258, "-", 9 ),
  (130, 260, "-", 7 ),
  (131, 262, 7.0, 5 ),
  (132, 264, "-", 8 ),
  (133, 266, "-", 5 ),
  (134, 268, 10., 5 ),
  (135, 270, 9.0, 7 ),
  (136, 272, 11., 8 ),
  (137, 274, 12., 3 ),
  (138, 276, "-", 10),
  (139, 278, 8.0, 8 ),
  (140, 280, "-", 6 ),
  (141, 282, 13., 4 ),
  (142, 284, 11., 5 ),
  (143, 286, "-", 7 ),
  (144, 288, "-", 5 ),
  (145, 290, "-", 4 ),
  (146, 292, "-", 7 ),
  (147, 294, "-", 6 ),
  (148, 296, "-", 7 ),
  (149, 298, "-", 7 ),
  (150, 300, "-", 2 ),
  (151, 302, "-", 5 ),
  (152, 304, "-", 7 ),
  (153, 306, "-", 6 ),
  (154, 308, "-", 7 ),
  (155, 310, "-", 6 ),
  (156, 312, "-", 4 ),
  (157, 314, "-", 6 ),
  (158, 316, "-", 4 ),
  (159, 318, "-", 9 ),
  (160, 320, "-", 6 ),
  (161, 322, "-", 6 ),
  (162, 324, "-", 8 ),
  (163, 326, "-", 7 ),
  (164, 328, "-", 4 ),
  (165, 330, "-", 5 ),
  (166, 332, "-", 5 ),
  (167, 334, "-", 7 ),
  (168, 336, "-", 7 ),
  (169, 338, "-", 9 ),
  (170, 340, "-", 7 ),
  (171, 342, "-", 6 ),
  (172, 344, "-", 9 ),
  (173, 346, "-", 11),
  (174, 348, "-", 10),
  (175, 350, "-", 8 ),
  (176, 352, "-", 8 ),
  (177, 354, "-", 6 ),
  (178, 356, "-", 9 ),
  (179, 358, "-", 10),
  (180, 360, "-", 5 ),
  (181, 362, "-", 8 ),
  (182, 364, "-", 8 ),
  (183, 366, "-", 9 ),
  (184, 368, "-", 7 ),
  (185, 370, "-", 9 ),
  (186, 372, "-", 9 ),
  (187, 374, "-", 7 ),
  (188, 376, "-", 8 ),
  (189, 378, "-", 7 ),
  (190, 380, "-", 8 ),
  (191, 382, "-", 9 ),
  (192, 384, "-", 8 ),
  (193, 386, "-", 9 ),
  (194, 388, "-", 10),
  (195, 390, "-", 5 ),
  (196, 392, "-", 7 ),
  (197, 394, "-", 9 ),
  (198, 396, "-", 7 ),
  (199, 398, "-", 9 ),
  (200, 400, "-", 9 )]

data_300s =[(100,122, 0.0, 0),
  (101,123, 1.0, 0),
  (102,124, 0.0, 0),
  (103,125, 0.0, 0),
  (104,126, 1.0, 1),
  (105,127, 0.0, 0),
  (106,128, 0.0, 0),
  (107,130, 0.0, 0),
  (108,131, 0.0, 0),
  (109,132, 0.0, 0),
  (110,133, 0.0, 0),
  (111,134, 1.0, 0),
  (112,135, 0.0, 0),
  (113,136, 1.0, 0),
  (114,138, 0.0, 0),
  (115,139, 0.0, 0),
  (116,140, 2.0, 1),
  (117,141, 1.0, 1),
  (118,142, 1.0, 0),
  (119,143, 0.0, 0),
  (120,144, 0.0, 0),
  (121,145, 3.0, 2),
  (122,147, 1.0, 0),
  (123,148, 1.0, 0),
  (124,149, 0.0, 0),
  (125,150, 0.0, 0),
  (126,151, 1.0, 0),
  (127,152, 2.0, 1),
  (128,153, 0.0, 0),
  (129,155, 0.0, 0),
  (130,156, 1.0, 0),
  (131,157, 1.0, 0),
  (132,158, 2.0, 0),
  (133,159, 3.0, 1),
  (134,160, 1.0, 0),
  (135,161, 1.0, 0),
  (136,162, 0.0, 0),
  (137,164, 2.0, 0),
  (138,165, 3.0, 0),
  (139,166, 1.0, 0),
  (140,167, 1.0, 0),
  (141,168, 2.0, 1),
  (142,169, 1.0, 0),
  (143,170, 3.0, 1),
  (144,171, 1.0, 0),
  (145,173, "-"  , 0),
  (146,174, "-"  , 0),
  (147,175, 1.0, 0),
  (148,176, 3.0, 0),
  (149,177, "-"  , 0),
  (150,178, "-"  , 0),
  (151,179, 1.0, 0),
  (152,180, 2.0, 1),
  (153,182, "-"  , 0),
  (154,183, 2.0, 0),
  (155,184, "-"  , 0),
  (156,185, "-"  , 0),
  (157,186, 1.0, 0),
  (158,187, 1.0, 0),
  (159,188, "-"  , 0),
  (160,189, "-"  , 0),
  (161,191, "-"  , 0),
  (162,192, "-"  , 0),
  (163,193, "-"  , 0),
  (164,194, "-"  , 0),
  (165,195, "-"  , 0),
  (166,196, 3.0, 0),
  (167,197, 1.0, 0),
  (168,198, 0.0, 0),
  (169,200, "-"  , 0),
  (170,201, "-"  , 2),
  (171,202, 3.0, 0),
  (172,203, "-"  , 1),
  (173,204, "-"  , 0),
  (174,205, 3.0, 0),
  (175,206, 3.0, 0),
  (176,207, 2.0, 0),
  (177,209, 3.0, 0),
  (178,210, 0.0, 0),
  (179,211, 0.0, 0),
  (180,212, 6.0, 0),
  (181,213, 3.0, 0),
  (182,214, 4.0, 0),
  (183,215, 2.0, 0),
  (184,216, 6.0, 1),
  (185,217, "-"  , 0),
  (186,219, 2.0, 0),
  (187,220, 3.0, 0),
  (188,221, 4.0, 1),
  (189,222, 4.0, 1),
  (190,223, "-", 0),
  (191,224, "-", 0),
  (192,225, "-", 0),
  (193,226, "-", 1),
  (194,228, "-", 1),
  (195,229, "-", 2),
  (196,230, "-", 1),
  (197,231, "-", 0),
  (198,232, "-", 1),
  (199,233, "-", 0),
  (200,234, "-", 0)]

data_300s_15x=[
  (101,152 , 1.0 ,1),
  (102,153 , 2.0 ,1),
  (100,150 , 2.0 ,2),
  (103,154 , 1.0 ,0),
  (104,156 , 2.0 ,1),
  (105,158 , 1.0 ,1),
  (106,159 , 3.0 ,1),
  (107,160 , 3.0 ,3),
  (108,162 , 0.0 ,0),
  (109,164 , "-" ,0),
  (110,165 , 3.0 ,1),
  (111,166 , 4.0 ,0),
  (112,168 , 5.0 ,3),
  (113,170 , 4.0 ,2),
  (114,171 , 4.0 ,0),
  (115,172 , 2.0 ,1),
  (116,174 , 4.0 ,0),
  (117,176 , 1.0 ,0),
  (118,177 , "-" ,1),
  (119,178 , 5.0 ,2),
  (120,180 , "-" ,2),
  (121,182 , 2.0 ,1),
  (122,183 , 2.0 ,0),
  (123,184 , 3.0 ,0),
  (124,186 , 2.0 ,1),
  (125,188 , 2.0 ,0),
  (126,189 , 1.0 ,0),
  (127,190 , 2.0 ,0),
  (128,192 , 4.0 ,3),
  (129,194 , 3.0 ,2),
  (130,195 , 6.0 ,2),
  (131,196 , 5.0 ,3),
  (132,198 , 1.0 ,0),
  (133,200 , 4.0 ,1),
  (134,201 , 5.0 ,2),
  (135,202 , 3.0 ,1),
  (136,204 , 5.0 ,4),
  (137,206 , 6.0 ,3),
  (138,207 , 4.0 ,3),
  (139,208 , 3.0 ,1),
  (140,210 , 3.0 ,2),
  (141,212 , 3.0 ,1),
  (142,213 , 4.0 ,2),
  (143,214 , 2.0 ,1),
  (144,216 , 2.0 ,0),
  (145,218 , 4.0 ,1),
  (146,219 , 6.0 ,4),
  (147,220 , 4.0 ,2),
  (148,222 , 5.0 ,3),
  (149,224 , 4.0 ,1),
  (150,225 , 6.0 ,2),
  (151,226 , 4.0 ,1),
  (152,228 , 3.0 ,1),
  (153,230 , 6.0 ,2),
  (154,231 , "-" ,2),
  (155,232 , "-" ,1),
  (156,234 , "-" ,2),
  (157,236 , 7.0 ,3),
  (158,237 , 3.0 ,0),
  (159,238 , 5.0 ,2),
  (160,240 , 2.0 ,0),
  (161,242 , 4.0 ,0),
  (162,243 , 6.0 ,1),
  (163,244 , 5.0 ,1),
  (164,246 , 5.0 ,2),
  (165,248 , 5.0 ,3),
  (166,249 , 4.0 ,1),
  (167,250 , 4.0 ,0),
  (168,252 , 8.0 ,3),
  (169,254 , "-" ,1),
  (170,255 , "-" ,2),
  (171,256 , "-" ,3),
  (172,258 , "-" ,2),
  (173,260 , "-" ,1),
  (174,261 , "-" ,0),
  (175,262 , 6.0 ,1),
  (176,264 , 2.0 ,1),
  (177,266 , 6.0 ,2),
  (178,267 , 6.0 ,2),
  (179,268 , 4.0 ,0),
  (180,270 , 7.0 ,1),
  (181,272 , 7.0 ,2),
  (182,273 , 5.0 ,3),
  (183,274 , 4.0 ,0),
  (184,276 , 7.0 ,1),
  (185,278 , 8.0 ,3),
  (186,279 , 8.0 ,2),
  (187,280 , 9.0 ,5),
  (188,282 , 5.0 ,3),
  (189,284 , 9.0 ,3),
  (190,285 , 8.0 ,3),
  (191,286 , 7.0 ,2),
  (192,288 , 7.0 ,3),
  (193,290 , "-" ,1),
  (194,291 , "-" ,1),
  (195,292 , 7.0 ,1),
  (196,294 , "-" ,4),
  (197,296 , "-" ,2),
  (198,297 , "-" ,4),
  (199,298 , 5.0 ,1),
  (200,300 , "-" ,1)
]

data_300s_2x = [(100 , 200 , 3.0  , 4 ),
  (101 , 202 , 6.0  , 3 ),
  (102 , 204 , 8.0  , 5 ),
  (103 , 206 , 5.0  , 5 ),
  (104 , 208 , 4.0  , 2 ),
  (105 , 210 , 8.0  , 4 ),
  (106 , 212 , 5.0  , 5 ),
  (107 , 214 , 5.0  , 6 ),
  (108 , 216 , 6.0  , 3 ),
  (109 , 218 , 3.0  , 4 ),
  (110 , 220 , 6.0  , 6 ),
  (111 , 222 , 10.0 , 5 ),
  (112 , 224 , "-",  5),
  (113 , 226 ,"-"   ,  5),
  (114 , 228 , 8.0  , 5 ),
  (115 , 230 , 6.0  , 5 ),
  (116 , 232 , 3.0  , 3 ),
  (117 , 234 , 5.0  , 6 ),
  (118 , 236 , 8.0  , 2 ),
  (119 , 238 , 6.0  , 6 ),
  (120 , 240 , 5.0  , 6 ),
  (121 , 242 , 6.0  , 5 ),
  (122 , 244 , 8.0  , 4 ),
  (123 , 246 , 10.0 , 5 ),
  (124 , 248 , "-"    ,  3),
  (125 , 250 , "-"    ,  6),
  (126 , 252 , "-"    ,  5),
  (127 , 254 , "-"    ,  4),
  (128 , 256 , "-"    ,  6),
  (129 , 258 , "-"    ,  9),
  (130 , 260 , 10.0 , 7 ),
  (131 , 262 , 6.0  , 5 ),
  (132 , 264 , 10.0 , 8 ),
  (133 , 266 , 8.0  , 5 ),
  (134 , 268 , 6.0  , 5 ),
  (135 , 270 , 7.0  , 7 ),
  (136 , 272 , 11.0 , 8 ),
  (137 , 274 , 8.0  , 3 ),
  (138 , 276 , 8.0  , 10),
  (139 , 278 , 8.0  , 8 ),
  (140 , 280 , 10.0 , 6 ),
  (141 , 282 , 10.0 , 4 ),
  (142 , 284 , 13.0 , 5 ),
  (143 , 286 , 10.0 , 7 ),
  (144 , 288 , 11.0 , 5 ),
  (145 , 290 , 12.0 , 4 ),
  (146 , 292 , 8.0  , 7 ),
  (147 , 294 , 9.0  , 6 ),
  (148 , 296 , 9.0  , 7 ),
  (149 , 298 , 10.0 , 7 ),
  (150 , 300 , 9.0  , 2 ),
  (151 , 302 , 12.0 , 5 ),
  (152 , 304 , 11.0 , 7 ),
  (153 , 306 , 9.0  , 6 ),
  (154 , 308 , 9.0  , 7 ),
  (155 , 310 , 8.0  , 6 ),
  (156 , 312 , 12.0 , 4 ),
  (157 , 314 , 9.0  , 6 ),
  (158 , 316 , 11.0 , 4 ),
  (159 , 318 , 11.0 , 9 ),
  (160 , 320 , 14.0 , 6 ),
  (161 , 322 , 9.0  , 6 ),
  (162 , 324 , 11.0 , 8 ),
  (163 , 326 , 14.0 , 7 ),
  (164 , 328 , 16.0 , 4 ),
  (165 , 330 , 14.0 , 5 ),
  (166 , 332 , 9.0  , 5 ),
  (167 , 334 , 9.0  , 7 ),
  (168 , 336 , 13.02, 7 ),
  (169 , 338 , 12.0 , 9 ),
  (170 , 340 , 7.0  , 7 ),
  (171 , 342 , 16.0 , 6 ),
  (172 , 344 , 12.0 , 9 ),
  (173 , 346 , 14.0 , 11),
  (174 , 348 , 12.0 , 10),
  (175 , 350 , 11.0 , 8 ),
  (176 , 352 , 10.0 , 8 ),
  (177 , 354 , 15.0 , 6 ),
  (178 , 356 , 10.0 , 9 ),
  (179 , 358 , 12.0 , 10),
  (180 , 360 , 9.0  , 5 ),
  (181 , 362 , 15.0 , 8 ),
  (182 , 364 ,"-"   , 8 ),
  (183 , 366 , 10.0 , 9 ),
  (184 , 368 , 15.0 , 7 ),
  (185 , 370 , 10.0 , 9 ),
  (186 , 372 , "-" , 9 ),
  (187 , 374 , "-", 7 ),
  (188 , 376 , 8.0  , 8 ),
  (189 , 378 , 13.0 , 7 ),
  (190 , 380 , 14.0 , 8 ),
  (191 , 382 , 13.0 , 9 ),
  (192 , 384 , 13.0 , 8 ),
  (193 , 386 , "-"    , 9 ),
  (194 , 388 , "-"    , 10),
  (195 , 390 , 11.0 , 5 ),
  (196 , 392 , "-"   , 7 ),
  (197 , 394 , "-"    , 9 ),
  (198 , 396 , 20.0 , 7 ),
  (199 , 398 , 16.0 , 9 ),
  (200 , 400 , "-"    ,  9)] 

data = data_300s_15x

data_lst = [("60s","",data_60s), ("60s","1.5x ",data_60s_15x), ("60s","2x ",data_60s_2x), ("300s","",data_300s), ("300s","1.5x ",data_300s_15x), ("300s","2x ",data_300s_2x)]

def plot(time, data, data_15x, data_2x):
    ## baseline
    found = [i for (_,_,i,_) in data]
    optimal = [j for (_,_,_, j) in data]
    d = {'Found': found, 'Optimal': optimal}
    df = pd.DataFrame(data=d)  
    df['Found'] = df['Found'].replace('-', 1000)
    df['Difference'] = df['Found'] - df['Optimal']

    bins = [-float('inf'), 0, 1, 2, 3, 4, 5, 6, 7, 8, 9,10,11,12,13, float('inf')]
    labels = ['0', '1', '2', 
              '3', '4', '5', '6', '7', '8', '9', '10','11','12','13', 'None Found']

    df['Difference_Category'] = pd.cut(df['Difference'], bins=bins, labels=labels)

    category_counts = df['Difference_Category'].value_counts().reindex(labels, fill_value=0)
    
    ## 1.5x
    found_15x = [i for (_,_,i,_) in data_15x]
    optimal_15x = [j for (_,_,_, j) in data_15x]
    d = {'Found': found_15x, 'Optimal': optimal_15x}
    df_15x = pd.DataFrame(data=d)  
    df_15x['Found'] = df_15x['Found'].replace('-', 1000)
    df_15x['Difference'] = df_15x['Found'] - df_15x['Optimal']
    df_15x['Difference_Category'] = pd.cut(df_15x['Difference'], bins=bins, labels=labels)

    category_counts_15x = df_15x['Difference_Category'].value_counts().reindex(labels, fill_value=0)
    
    ## 2x
    found_2x = [i for (_,_,i,_) in data_2x]
    optimal_2x = [j for (_,_,_, j) in data_2x]
    d = {'Found': found_2x, 'Optimal': optimal_2x}
    df_2x = pd.DataFrame(data=d)  
    df_2x['Found'] = df_2x['Found'].replace('-', 1000)
    df_2x['Difference'] = df_2x['Found'] - df_2x['Optimal']
    df_2x['Difference_Category'] = pd.cut(df_2x['Difference'], bins=bins, labels=labels)

    category_counts_2x = df_2x['Difference_Category'].value_counts().reindex(labels, fill_value=0)
    
    width = 0.25  # Width of each bar

    # Create figure and axis
    fig, ax = plt.subplots(figsize=(10, 6))
    
    # Calculate positions for bars
    x = range(15)
    x_baseline = x
    x_15x = [i + width for i in x]
    x_2x = [i + 2*width for i in x]
    
    # Plot bars for each category
    ax.bar(x_baseline, category_counts, width=width, color='white', edgecolor='black', label='Baseline')
    ax.bar(x_15x, category_counts_15x, width=width, color='gray', edgecolor='black', label='1.5x')
    ax.bar(x_2x, category_counts_2x, width=width, color='black', edgecolor='black', label='2x')

    title = "Optimality of Solution Found in " + time 
    plt.title(title)
    plt.xlabel('Number of Unsatisfied Clauses')
    plt.ylabel('Number of Random Instances')
    
    for i, count in enumerate(category_counts):
        ax.text(i, count + 0.5, str(count), ha='center', va='bottom', fontsize=8, color='black')
    for i, count in enumerate(category_counts_15x):
        ax.text(i + width, count + 0.5, str(count), ha='center', va='bottom', fontsize=8, color='black')
    for i, count in enumerate(category_counts_2x):
        ax.text(i + 2*width, count + 0.5, str(count), ha='center', va='bottom', fontsize=8, color='black')
    
    plt.legend()
    plt.xticks(rotation=0)
    plt.tight_layout()  
    
    # Set x-tick labels
    ax.set_xticks([i + width for i in x])
    ax.set_xticklabels(labels)
    
    ax.set_xlim(left=-0.5)
    plt.show()

#plot("300 seconds", data_300s, data_300s_15x, data_300s_2x)

def plot_ratio(data, time, vars):
   ratios = []
   for row in data:
    (m,_,found,opt) = row
    if(found == "-"):
      continue
    ratio = (m-found)/(m-opt)
    ratios += [ratio]
   ratios = np.array(ratios)   
   plt.figure(figsize=(8, 6))
   sns.histplot(ratios, bins=30, kde=False)  
   title = "Distribution of Ratio Values Found in " + time + " " + vars + "Baseline"
   plt.title(title)
   plt.xlabel('Ratio')
   plt.ylabel('Number of Instances')
   plt.grid(True)
   plt.show()
 
#plot_ratio(data_60s_15x, "60s", "1.5x ")
#plot_ratio(data_60s_2x, "60s", "2x ")
#plot_ratio(data_300s_15x, "300s", "1.5x ")
#plot_ratio(data_300s_2x, "300s", "2x ")

# Plot ratio only of those instances that were found 60s
def plot_ratio_300s(data_300s, data_60s, time, vars):
   ratios = []
   m =100
   for i in range(len(data_60s)):
    if(data_60s[i][2] == '-' or data_300s[i][2] == '-' ):
      continue
    (m,_,found,opt) = data_300s[i]
    print(data_300s[i])
    ratio = (m-found)/(m-opt)
    ratios += [ratio]
    m = min(m,ratio)
   ratios = np.array(ratios)   
   print(m)
   plt.figure(figsize=(8, 6))
   sns.histplot(ratios, bins=30, kde=False)  
   title = "Distribution of Ratio Values Found in " + time + " " + vars + "Baseline"
   plt.title(title)
   plt.xlabel('Ratio')
   plt.ylabel('Number of Instances')
   plt.grid(True)
   plt.show()

#plot_ratio_300s(data_300s_2x, data_60s_2x, "300s", "2x ")

def frac_unsat(data):
  total = 0
  unsat = 0
  min_rat = 1000
  num_opt = 0
  for row in data:
    (m,_,found,opt) = row
    if(found == "-"):
      unsat +=1
    else:
      if(found == opt):
        num_opt+=1
      ratio = (m-found)/(m-opt)
      if(ratio < min_rat):
        min_rat = ratio
    total+=1
  return unsat / total, min_rat, num_opt/total

compet_300 =[(40 ,1132 , 238.0 , 238 ),
(40 ,1188 , 252.0 , 252 ),
(40 ,1178 , 249.0 , 249 ),
(64 ,1408 , 192.0 , 192 ),
(45 ,1836 , 422.0 , 422 ),
(42 ,1310 , 284.0 , 284 ),
(42 ,1690 , 404.0 , 404 ),
(41 ,1230 , 250.0 , 250 ),
(43 ,1270 , 269.0 , 269 ),
(40 ,1116 , 237.0 , 237 ),
(40 ,1126 , 236.0 , 236 ),
(41 ,1640 , 400.0 , 400 ),
(42, 840  , 200.0 , 200 ),
(64 ,3648 , 832.0 , 832 ),
(43 ,1806 , 441.0 , 441 ),
(41 ,1640 , 400.0 , 400 ),
(70 ,3710 , 770.0 , 770 ),
(45 ,1836 , 422.0 , 422 ),
(42 ,1690 , 404.0 , 404 ),
(42 ,1718 , 418.0 , 418 ),
(41 ,1638 , 399.0 , 399 ),
(40 ,1038 , 214.0 , 214 )]



compet_60=[(40 , 1132 , 238.0 , 238 ), 
(40 , 1188 , 252.0 , 252 ),
(40 , 1178 , 249.0 , 249 ),
(64 , 1408 , 192.0 , 192 ),
(45 , 1836 , 422.0 , 422 ),
(42 , 1310 , 284.0 , 284 ),
(42 , 1690 , 404.0 , 404 ),
(41 , 1230 , 250.0 , 250 ),
(43 , 1270 , 269.0 , 269 ),
(40 , 1116 , 237.0 , 237 ),
(40 , 1126 , 236.0 , 236 ),
(41 , 1640 , 400.0 , 400 ),
(42 , 840  , 200.0 , 200 ),
(64 , 3648 , 832.0 , 832 ),
(43 , 1806 , 441.0 , 441 ),
(41 , 1640 , 400.0 , 400 ),
(70 , 3710 , 770.0 , 770 ),
(45 , 1836 , 422.0 , 422 ),
(42 , 1690 , 404.0 , 404 ),
(42 , 1718 , 418.0 , 418 ),
(41 , 1638 , 399.0 , 399 ),
(40 , 1038 , 214.0 , 214 )]
#print(frac_unsat(compet_60))