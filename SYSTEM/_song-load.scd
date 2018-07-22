
//////////////////////////////////////////////
// SONG LOAD
(
i.stopPattern.load;
"------>".postln;
"loading file ... ".post;
g.songFileName[g.currSong.value].postln;
~songLoaded = false;

// reset song functions to empty
7.do({|x| 5.do({|y|  	e[("in"++x++"Func"++y).asSymbol] = {};   })});

// load song
Pfuncn({
	Routine{
		if (~system==true, {
			(g.songDir++g.songFileName[g.currSong.value]).load;
		});
		0.05.wait;

		//////////////////////////////////////////////
		// Fill up text blocks

		// reset text
		[\first, \second, \third, \fourth].do({|name, c|
			8.do({|x|
				g.textBlockRef.value_(Ref([c, x, 0])).changed(\val);
			});
		});

		0.01.wait;
		// read textblocks
		if (~songEvents.size==8,{    // check if texts arrays are fitting, else SC throws errors
			"BLOCK TEXT available".postln;
			[\first, \second, \third, \fourth].do({|name, c|
				name = name.asSymbol;
				8.do({|x|
					if (~songEvents[x][c]!=nil, {
						g.text[name][x].string = ~songEvents[x][c];
					},{
						g.text[name][x].string = "";
					});
				});
			});
		}, {
			"NO or NOT ENOUGH Block-Texts available!".postln;
			g.textEmpty = ["No", "or", "not", "enough", "text", "..."];
			[\first, \second, \third, \fourth].do({|name, c|
				name = name.asSymbol;
				8.do({|x|
					g.text[name][x].string = "";
				});
			});
			6.do({|c|
				g.text[\first][c].string = g.textEmpty[c];
			});
		});




		//////////////////////////////////////////////
		// display tempo
		g.tempoVal = ~tempo*60;
		if (~tempo!=111, {
			defer { g.tempoText.string_((g.tempoVal.asString ++ " BPM").asString) }
		}, {
			defer { g.tempoText.string_("no BPM") }
		});


		TempoClock.default.tempo = ~tempo;
		//////////////////////////////////////////////
		// reset tempo
		~tempo = 111;
		// reset array
		~songEvents = ();
		0.01.wait;
		//////////////////////////////////////////////
		// read Presets
		~readFromPreset.value;


		if (~text!=nil, {g.notesText.string_(~text)}, {g.notesText.string_("..no notes..")});
		~text = nil;
		~songLoaded = true;

	}.play(AppClock);
	nil }, 1).play(quant: ( 4));
)








/*


*/



/*
g.text[0].string = g.songEvents[0][3];
g.songEvents[0][0];
g.text[1][1].background_(Color.green)
g.songEvents[3][0]
g.text[24].string = "w";
3-0
*/