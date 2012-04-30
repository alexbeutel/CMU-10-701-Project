function testRaster

x = rand(1,100)*2000;
y = rand(1,100)*1400;
score = rand(1,100);

buff = ConRasterSingleFrame(2000,1400,x,y,score)';

imagesc(buff);

end

