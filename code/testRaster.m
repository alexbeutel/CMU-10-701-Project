function testRaster

x = rand(1,20)*200;
y = rand(1,20)*100;
score = rand(1,20);

buff = ConRasterSingleFrame(200,100,x,y,score)';

imagesc(buff);

end

