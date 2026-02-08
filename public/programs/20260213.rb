def setup
  createCanvas(700, 700)
  noLoop
end

def draw
  background(233, 165, 158)

  push
  translate(350, 350)

  # --- 外形頂点（五角形）---
  tl_x, tl_y = -130, -165    # 上辺左(TL)
  tr_x, tr_y =  130, -165    # 上辺右(TR)
  r_x,  r_y  =  220,  -15    # 右肩(R)
  b_x,  b_y  =    0,  205    # 底点(B)
  l_x,  l_y  = -220,  -15    # 左肩(R)

  # --- 内部頂点 ---
  tc_x, tc_y =    0, -165    # 上辺中央(TC)
  cl_x, cl_y =  -80,  -15    # 中央左(CL)
  cr_x, cr_y =   80,  -15    # 中央右(CR)

  stroke(233, 165, 158)
  strokeWeight(5)

  # 1. 左上内: TL - TC - CL
  fill(210, 49, 6)
  triangle(tl_x, tl_y, tc_x, tc_y, cl_x, cl_y)

  # 2. 右上内: TC - TR - CR
  triangle(tc_x, tc_y, tr_x, tr_y, cr_x, cr_y)

  # 3. 左上外: TL - CL - L
  triangle(tl_x, tl_y, cl_x, cl_y, l_x, l_y)

  # 4. 右上外: TR - CR - R
  triangle(tr_x, tr_y, cr_x, cr_y, r_x, r_y)

  # 5. 中央逆三角: TC - CL - CR
  triangle(tc_x, tc_y, cl_x, cl_y, cr_x, cr_y)

  # 6. 左下: L - CL - B
  triangle(l_x, l_y, cl_x, cl_y, b_x, b_y)

  # 7. 中央下: CL - CR - B
  triangle(cl_x, cl_y, cr_x, cr_y, b_x, b_y)

  # 8. 右下: CR - R - B
  triangle(cr_x, cr_y, r_x, r_y, b_x, b_y)

  pop
end
