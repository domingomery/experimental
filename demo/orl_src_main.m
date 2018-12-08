% Definition of images
f.path           = '/Users/domingomery/Dropbox/mingo/Matlab/images/faces/faces_orl/';
f.extension      = 'png';
f.prefix         = 'face';
f.dig_class      = 3;
f.dig_img        = 2;

% Definition of feature extraction
opfx.height      = 22;
opfx.width       = 18;

% Definition of classifier
opcl.clname      = 'src';
opcl.T           = 4;

% Definition of training and testing images
ix_train         = exp_imgix((1:40),(1:9));
ix_test          = [(1:40)' 10*ones(40,1)];

% Training
[Xtrain,dtrain]  = exp_fx('orl_src_fx',f,opfx,ix_train);
opts             = exp_train('orl_src_classifier',Xtrain,dtrain,opcl);

% Testing
[Xtest,dtest]    = exp_fx('orl_src_fx',f,opfx,ix_test);
ds               = exp_test('orl_src_test',Xtest,opts);

% Evaluation
p = Bev_performance(ds,dtest)
