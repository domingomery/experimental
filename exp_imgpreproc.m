function I = exp_imgpreproc(I,options)

if isfield(options,'height');
    I = imresize(I,[options.height options.width]);
end