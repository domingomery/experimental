function ix = exp_imgix(classes,images)

nim = length(images);
ncl = length(classes);

ix_img   = repmat(images',[1 ncl]);
ix_class = repmat(classes,[nim 1]);

ix       = [ix_class(:)  ix_img(:)];
