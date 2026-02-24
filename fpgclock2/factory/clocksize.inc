
const
  CImgWidth  = 400;
  CImgHeight = CImgWidth;
  
  CRadius1 = 7 * CImgWidth div 16;
  CRadius2 = 6 * CImgWidth div 16;
  CRadius3 = 5 * CImgWidth div 16;
  CRadius4 = 4 * CImgWidth div 16;
  
  CLineWidth = 10;
  CPointWidth: array[boolean] of integer = (CLineWidth div 2 + 1, CLineWidth div 2 + 2);
