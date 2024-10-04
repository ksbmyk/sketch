use strict;
use warnings;

use Imager;

my $img_width = 400;
my $img_height = 400;
my $cell_size = 40;
my $line_width = 8;

my $img = Imager->new(
    xsize => $img_width,
    ysize => $img_height,
    channels => 3
);


my $background_color = Imager::Color->new('#004b6d');
$img->box( color => $background_color, filled => 1 );
my $line_color = Imager::Color->new('#0174a9');

for (my $x = 0; $x < $img_width; $x += $cell_size) {
    for (my $y = 0; $y < $img_height; $y += $cell_size) {
        my $draw_slash = int(rand(2));

        if ($draw_slash == 0) {
            # "\"
            my @points = (
                [$x - ($line_width / 2), $y + ($line_width / 2)],          # 左上
                [$x + ($line_width / 2), $y - ($line_width / 2)],          # 右上
                [$x + $cell_size + ($line_width / 2), $y + $cell_size - ($line_width / 2)], # 右下
                [$x + $cell_size - ($line_width / 2), $y + $cell_size + ($line_width / 2)]  # 左下
            );
            $img->polygon(points => \@points, color => $line_color, filled => 1);
        } else {
            # "/"
            my @points = (
                [$x + $cell_size + ($line_width / 2), $y + ($line_width / 2)], # 右上
                [$x + $cell_size - ($line_width / 2), $y - ($line_width / 2)], # 左上
                [$x - ($line_width / 2), $y + $cell_size - ($line_width / 2)], # 左下
                [$x + ($line_width / 2), $y + $cell_size + ($line_width / 2)]  # 右下
            );
            $img->polygon(points => \@points, color => $line_color, filled => 1);
        }
    }
}

$img->write( file => '10print.png' ) or die $img->errstr;
