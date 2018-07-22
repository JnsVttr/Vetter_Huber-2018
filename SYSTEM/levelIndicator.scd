//
//LevelIndicator



(
OSCdef(\test0, {|msg|
	{
        g.sliderMeter[0].value = msg[3].ampdb.linlin(-40, 0, 0, 1);
        g.sliderMeter[0].peakLevel = msg[4].ampdb.linlin(-40, 0, 0, 1);
    }.defer;
}, 'levels0', s.addr);
OSCdef(\test1, {|msg|
	{
        g.sliderMeter[1].value = msg[3].ampdb.linlin(-40, 0, 0, 1);
        g.sliderMeter[1].peakLevel = msg[4].ampdb.linlin(-40, 0, 0, 1);
    }.defer;
}, 'levels1', s.addr);
OSCdef(\test2, {|msg|
	{
        g.sliderMeter[2].value = msg[3].ampdb.linlin(-40, 0, 0, 1);
        g.sliderMeter[2].peakLevel = msg[4].ampdb.linlin(-40, 0, 0, 1);
    }.defer;
}, 'levels2', s.addr);
OSCdef(\test3, {|msg|
	{
        g.sliderMeter[3].value = msg[3].ampdb.linlin(-40, 0, 0, 1);
        g.sliderMeter[3].peakLevel = msg[4].ampdb.linlin(-40, 0, 0, 1);
    }.defer;
}, 'levels3', s.addr);
OSCdef(\test4, {|msg|
	{
        g.sliderMeter[4].value = msg[3].ampdb.linlin(-40, 0, 0, 1);
        g.sliderMeter[4].peakLevel = msg[4].ampdb.linlin(-40, 0, 0, 1);
    }.defer;
}, 'levels4', s.addr);
OSCdef(\test5, {|msg|
	{
        g.sliderMeter[5].value = msg[3].ampdb.linlin(-40, 0, 0, 1);
        g.sliderMeter[5].peakLevel = msg[4].ampdb.linlin(-40, 0, 0, 1);
    }.defer;
}, 'levels5', s.addr);
OSCdef(\test6, {|msg|
	{
        g.sliderMeter[6].value = msg[3].ampdb.linlin(-40, 0, 0, 1);
        g.sliderMeter[6].peakLevel = msg[4].ampdb.linlin(-40, 0, 0, 1);
    }.defer;
}, 'levels6', s.addr);
OSCdef(\test7, {|msg|
	{
        g.sliderMeter[7].value = msg[3].ampdb.linlin(-40, 0, 0, 1);
        g.sliderMeter[7].peakLevel = msg[4].ampdb.linlin(-40, 0, 0, 1);
    }.defer;
}, 'levels7', s.addr);

)






