NUM_RAYS = 400
CUBE_SIZE = 60
RAY_LENGTH = 900
ORBIT_RADIUS = 400

def setup
  createCanvas(700, 700)
  colorMode(HSB, 360, 100, 100, 100)
  
  @silhouette = build_cube_silhouette
  @center_x = width / 2.0
  @center_y = height / 2.0
end

def build_cube_silhouette
  s = CUBE_SIZE
  cx = width / 2.0
  cy = height / 2.0
  rot_x = 0.4
  rot_y = 0.6
  
  base = [
    [-s, -s, -s], [s, -s, -s], [s, -s, s], [-s, -s, s],
    [-s, s, -s], [s, s, -s], [s, s, s], [-s, s, s]
  ]
  
  cube_2d = base.map do |x, y, z|
    x1 = x * cos(rot_y) - z * sin(rot_y)
    z1 = x * sin(rot_y) + z * cos(rot_y)
    y2 = y * cos(rot_x) - z1 * sin(rot_x)
    
    { x: x1 + cx, y: y2 + cy }
  end
  
  convex_hull(cube_2d)
end

def convex_hull(points)
  sorted = points.sort_by { |p| [p[:y], p[:x]] }
  start = sorted.first
  
  rest = sorted.drop(1).sort_by do |p|
    atan2(p[:y] - start[:y], p[:x] - start[:x])
  end
  
  rest.each_with_object([start]) do |p, hull|
    hull.pop while hull.size > 1 && cross(hull[-2], hull[-1], p) <= 0
    hull << p
  end
end

def cross(o, a, b)
  (a[:x] - o[:x]) * (b[:y] - o[:y]) - (a[:y] - o[:y]) * (b[:x] - o[:x])
end

def silhouette_edges
  @silhouette.map.with_index do |v1, j|
    v2 = @silhouette[(j + 1) % @silhouette.size]
    [v1, v2]
  end
end

def draw
  background(0)
  
  angle1 = frameCount * 0.015
  angle2 = angle1 + PI
  
  lights = [
    build_light(angle1, 190),
    build_light(angle2, 240)
  ]
  
  blendMode(ADD)
  lights.each { |light| draw_rays(light) }
  
  blendMode(BLEND)
  lights.each { |light| draw_light_indicator(light) }
end

def build_light(orbit_angle, hue)
  x = @center_x + cos(orbit_angle) * ORBIT_RADIUS
  y = @center_y + sin(orbit_angle) * ORBIT_RADIUS
  angle_to_center = atan2(@center_y - y, @center_x - x)
  
  { x: x, y: y, hue: hue, angle_center: angle_to_center, angle_spread: PI / 2 }
end

def draw_rays(light)
  start_angle = light[:angle_center] - light[:angle_spread] / 2
  
  NUM_RAYS.times do |i|
    ray_angle = start_angle + (i.to_f / NUM_RAYS) * light[:angle_spread]
    draw_single_ray(light[:x], light[:y], ray_angle, light[:hue])
  end
end

def draw_single_ray(light_x, light_y, ray_angle, hue)
  dx = cos(ray_angle)
  dy = sin(ray_angle)

  hit_distances = silhouette_edges.map do |v1, v2|
    ray_segment_intersection(light_x, light_y, dx, dy, v1[:x], v1[:y], v2[:x], v2[:y])
  end

  hit_t = hit_distances.compact.select { |t| t > 5 }.min || RAY_LENGTH

  end_x = light_x + dx * hit_t
  end_y = light_y + dy * hit_t

  stroke(hue, 80, 80, 35)
  strokeWeight(1.5)
  line(light_x, light_y, end_x, end_y)
end

def ray_segment_intersection(rx, ry, dx, dy, x1, y1, x2, y2)
  seg_dx = x2 - x1
  seg_dy = y2 - y1
  
  denom = dx * seg_dy - dy * seg_dx
  return nil if denom.abs < 0.0001
  
  t = ((x1 - rx) * seg_dy - (y1 - ry) * seg_dx) / denom
  s = ((x1 - rx) * dy - (y1 - ry) * dx) / denom
  
  t > 0 && s >= 0 && s <= 1 ? t : nil
end

def draw_light_indicator(light)
  noStroke
  5.downto(1) do |i|
    fill(light[:hue], 60, 95, 6 * i)
    circle(light[:x], light[:y], i * 14)
  end
  fill(light[:hue], 40, 100, 95)
  circle(light[:x], light[:y], 8)
end
