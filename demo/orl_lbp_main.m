% Definition of images
f.path           = '/Users/domingomery/Dropbox/mingo/Matlab/images/faces/faces_orl/';
f.extension      = 'png';
f.prefix         = 'face';
f.dig_class      = 3;
f.dig_img        = 2;

% Definition of feature extraction
opfx.height      = 110;
opfx.width       = 90;
opfx.vdiv        = 3;
opfx.hdiv        = 3;
opfx.samples     = 8;
opfx.mappingtype = 'u2';

% Definition of classifier
opcl.clname      = 'knn';
opcl.k           = 1;
opcl.show        = 0;

% Definition of training and testing images
ix_train         = exp_imgix((1:40),(1:9));
ix_test          = [(1:40)' 10*ones(40,1)];

% Training
[Xtrain,dtrain]  = exp_fx('orl_lbp_fx',f,opfx,ix_train);
opts             = exp_train('orl_lbp_classifier',Xtrain,dtrain,opcl);

% Testing
[Xtest,dtest]    = exp_fx('orl_lbp_fx',f,opfx,ix_test);
ds               = exp_test('orl_lbp_test',Xtest,opts);

% Evaluation
p = Bev_performance(ds,dtest)
