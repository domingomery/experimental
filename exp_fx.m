function [X,d] = exp_fx(fxname,f,opfx,ix,proc_name)

n = size(ix,1);

if ~isfield(opfx,'single')
    opfx.single = 0;
end

ftype = ischar(f);

if ftype == 1
    load(f)
end

if ~exist('proc_name','var')
    proc_name = 'feature extraction';
end

ft = Bio_statusbar(proc_name);
for i=1:n
    ft = Bio_statusbar(i/n,ft);
    if ftype == 1
        I  = imdb.images.data(:,:,ix(i,2));
    else
        Io = exp_imgread(f,ix(i,1),ix(i,2));
        I  = exp_imgpreproc(Io,opfx);
    end
    x = feval(fxname,I,opfx);
    if i==1
        [N,M]  = size(x);
        if opfx.single ==1
            X = zeros(n*N,M,'single');
            d = zeros(n*N,1);
        else
            X = zeros(n*N,M);
            d = zeros(n*N,1);
        end
    end
    if N==1
        X(i,:) = x;
        d(i,1)   = ix(i,1);
    else
        X(indices(i,N),:) = x;
        d(indices(i,N),1) = ix(i,1);
    end
end
delete(ft);
