function I = exp_imgread(f,classid,img)

st = [f.path f.prefix '_' num2fixstr(classid,f.dig_class) '_' num2fixstr(img,f.dig_img) '.' f.extension];
I = imread(st);