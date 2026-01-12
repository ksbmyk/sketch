NUM_RAYS = 400
CUBE_SIZE = 60
RAY_LENGTH = 900

def setup
  createCanvas(700, 700)
  colorMode(HSB, 360, 100, 100, 100)
  
  # Left-top light pointing toward right-bottom
  # Right-top light pointing toward left-bottom
  @lights = [
    { x: 50, y: 50, hue: 200, angle_center: PI / 4 + PI / 8, angle_spread: PI / 2 },
    { x: 650, y: 50, hue: 320, angle_center: 3 * PI / 4 - PI / 8, angle_spread: PI / 2 }
  ]
  
  s = CUBE_SIZE
  cx = width / 2.0
  cy = height / 2.0
  
  rot_x = 0.4
  rot_y = 0.6
  
  base = [
    [-s, -s, -s], [s, -s, -s], [s, -s, s], [-s, -s, s],
    [-s, s, -s], [s, s, -s], [s, s, s], [-s, s, s]
  ]
  
  cube_2d = base.map do |v|
    x1 = v[0] * cos(rot_y) - v[2] * sin(rot_y)
    z1 = v[0] * sin(rot_y) + v[2] * cos(rot_y)
    y1 = v[1]
    
    y2 = y1 * cos(rot_x) - z1 * sin(rot_x)
    
    { x: x1 + cx, y: y2 + cy }
  end
  
  @silhouette = convex_hull(cube_2d)
end

def convex_hull(points)
  sorted = points.sort_by { |p| [p[:y], p[:x]] }
  start = sorted.first
  
  rest = sorted[1..-1].sort_by do |p|
    atan2(p[:y] - start[:y], p[:x] - start[:x])
  end
  
  hull = [start]
  
  rest.each do |p|
    while hull.length > 1 && cross(hull[-2], hull[-1], p) <= 0
      hull.pop
    end
    hull << p
  end
  
  hull
end

def cross(o, a, b)
  (a[:x] - o[:x]) * (b[:y] - o[:y]) - (a[:y] - o[:y]) * (b[:x] - o[:x])
end

def draw
  background(0)
  
  blendMode(ADD)
  
  @lights.each do |light|
    draw_rays(light)
  end
  
  blendMode(BLEND)
  
  @lights.each do |light|
    draw_light_indicator(light[:x], light[:y], light[:hue])
  end
end

def draw_rays(light)
  light_x = light[:x]
  light_y = light[:y]
  hue = light[:hue]
  angle_center = light[:angle_center]
  angle_spread = light[:angle_spread]
  
  start_angle = angle_center - angle_spread / 2
  
  NUM_RAYS.times do |i|
    ray_angle = start_angle + (i.to_f / NUM_RAYS) * angle_spread
    
    dx = cos(ray_angle)
    dy = sin(ray_angle)
    
    hit_t = nil
    
    @silhouette.length.times do |j|
      v1 = @silhouette[j]
      v2 = @silhouette[(j + 1) % @silhouette.length]
      
      t = ray_segment_intersection(light_x, light_y, dx, dy, v1[:x], v1[:y], v2[:x], v2[:y])
      if t && t > 5
        hit_t = t if hit_t.nil? || t < hit_t
      end
    end
    
    if hit_t
      end_x = light_x + dx * hit_t
      end_y = light_y + dy * hit_t
    else
      end_x = light_x + dx * RAY_LENGTH
      end_y = light_y + dy * RAY_LENGTH
    end
    
    stroke(hue, 80, 80, 35)
    strokeWeight(1.5)
    line(light_x, light_y, end_x, end_y)
  end
end

def ray_segment_intersection(rx, ry, dx, dy, x1, y1, x2, y2)
  seg_dx = x2 - x1
  seg_dy = y2 - y1
  
  denom = dx * seg_dy - dy * seg_dx
  return nil if denom.abs < 0.0001
  
  t = ((x1 - rx) * seg_dy - (y1 - ry) * seg_dx) / denom
  s = ((x1 - rx) * dy - (y1 - ry) * dx) / denom
  
  (t > 0 && s >= 0 && s <= 1) ? t : nil
end

def draw_light_indicator(x, y, hue)
  noStroke
  5.downto(1) do |i|
    fill(hue, 60, 95, 6 * i)
    circle(x, y, i * 14)
  end
  fill(hue, 40, 100, 95)
  circle(x, y, 8)
end