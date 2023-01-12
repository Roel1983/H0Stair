$fn = 64;

height = 15;
width  =  10.0;

step_size       = [2.7, 0.8];
step_overhang   = 0.3;
step_count      = 6;

BIAS= 0.01;
X_AXIS = [1, 0, 0];


rotate(90, X_AXIS) linear_extrude(width, center=true) {
    for (i = [1 : step_count - 1]) {
        step_height = (height - step_size[1]) / (step_count - 1);
        translate([
            i * (step_size[0] - step_overhang),
            i * step_height
        ]) {
            render() difference() {
                union() {
                    square(step_size);
                    translate([step_overhang - BIAS, -step_height]) {
                        square([step_size[0], step_height+BIAS]);
                    }
                }
                a = atan((step_size[0] - step_overhang) / step_height);
                translate([step_size[0] + .3, 0]) {
                    rotate(-90-a) translate([-1.4 * step_size[0],0]) {
                        square([
                            1.4 * step_size[0] * 2,
                            1.4 * step_height
                        ]);
                    }
                }
            }
        }
    }
}

handrail_tickness = [0.7, 0.5];

handrail_height = 8.0;

rotate(90, X_AXIS) translate([0,0,-width/2]) {
    translate([step_size[0] * .4, 0])linear_extrude(handrail_tickness[1]) {
       step_height = (height - step_size[1]) / (step_count - 1);
       for (i = [1 : 2 : step_count - 1]) {
            
            translate([
                i * (step_size[0] - step_overhang),
                i * step_height
            ]) {
                translate([-handrail_tickness[0]/2, 0]) {
                    square([handrail_tickness[0], handrail_height]);
                }
                translate([0, handrail_height]) {
                    circle(d=handrail_tickness[0]);
                }
            }
        }
        
        for (o=[0,3]) {
            translate([
                (step_size[0] - step_overhang),
                step_height + handrail_height - o
            ]) {
                l = sqrt(pow((step_size[0] - step_overhang),2) 
                       + pow(step_height,2)) * (step_count - 2);
                a = atan((step_size[0] - step_overhang)/step_height);
                echo(a);
                rotate(-a) translate([-handrail_tickness[0]/2, 0]) {
                    square([handrail_tickness[0], l]);
                }
            }
        }
    }
}
	
	
	
