NUM_RAYS = 400
CUBE_SIZE = 60
RAY_LENGTH = 700

def setup
  createCanvas(700, 700)
  colorMode(HSB, 360, 100, 100, 100)
  
  # Two light sources - positioned to cast interesting shadows
  @lights = [
    { x: 100, y: 150, hue: 200 },
    { x: 600, y: 150, hue: 320 }
  ]
  
  # Static cube at center with slight rotation for 3D look
  s = CUBE_SIZE
  cx = width / 2.0
  cy = height / 2.0
  
  rot_x = 0.4
  rot_y = 0.6
  
  base = [
    [-s, -s, -s], [s, -s, -s], [s, -s, s], [-s, -s, s],
    [-s, s, -s], [s, s, -s], [s, s, s], [-s, s, s]
  ]
  
  @cube_2d = base.map do |v|
    x1 = v[0] * cos(rot_y) - v[2] * sin(rot_y)
    z1 = v[0] * sin(rot_y) + v[2] * cos(rot_y)
    y1 = v[1]
    
    y2 = y1 * cos(rot_x) - z1 * sin(rot_x)
    
    { x: x1 + cx, y: y2 + cy }
  end
  
  @cube_edges = [
    [0, 1], [1, 2], [2, 3], [3, 0],
    [4, 5], [5, 6], [6, 7], [7, 4],
    [0, 4], [1, 5], [2, 6], [3, 7]
  ]
end

def draw
  background(230, 30, 8)
  
  @lights.each do |light|
    draw_rays(light[:x], light[:y], light[:hue])
  end
  
  @lights.each do |light|
    draw_light_indicator(light[:x], light[:y], light[:hue])
  end
end

def draw_rays(light_x, light_y, hue)
  NUM_RAYS.times do |i|
    ray_angle = i * TWO_PI / NUM_RAYS
    
    dx = cos(ray_angle)
    dy = sin(ray_angle)
    
    hit_t = nil
    
    @cube_edges.each do |edge|
      v1 = @cube_2d[edge[0]]
      v2 = @cube_2d[edge[1]]
      
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
    
    stroke(hue, 50, 80, 20)
    strokeWeight(1)
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
