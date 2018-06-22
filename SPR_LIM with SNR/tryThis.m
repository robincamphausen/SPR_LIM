numCaptures = 20;
numSamples = 100000;
LOD = 1;

x = LOD*(rand(numCaptures, numSamples)-0.5);
noise = std(sum(x)/numCaptures)