// 参考元: https://note.com/sc3/n/n429b1ff7e461

s.boot
Server.killAll

SynthDef.new("synth1", {Out.ar(0, Saw.ar(220, 0.3)!2)}).add;


// TODO(zztkm): synth1 を Sonic Pi から呼び出せるようにしてみる
// 参考: https://qiita.com/yoppa/items/829d25addf499824d2f9
(
SynthDef.new("synth1", {
	// arg でこの functoon の引数を設定
	arg freq;
	var sig, env;
	env = EnvGen.kr(Env.perc, doneAction:2);
	sig = Saw.ar(freq, 0.3)!2;
	Out.ar(0, sig * env)
}).add;
)

// 簡易的に音を鳴らすために Synth クラスを利用する
// これを実行すると synth1 の音が鳴る(嬉しい
// freq の横の数字を変えると synth1 のピッチを変えることができる
Synth.new("synth1", ["freq", 440]);

// ここから下は後編
// https://note.com/sc3/n/ncfa9297ea01b

// Pbind.new(\instrument, "音色名", \note, 音符, \dur, 音長).play;
// instrument: 楽器、定義した Synth 名を指定する
// note: midinote で指定することもできる（なお、まだ midinote が何であるかは僕は知りません
// dur: duration の略、音符ごとの間隔を指定することができる
(
Pbind.new(
	\instrument, "synth1",
	\note, Pseq([0, 2, 4, 5], 2),
	\dur, 0.5
).play();
)

// dur にも Pseq を使って note の配列と対応して、note ごとに dur を設定することができる
// note の方が少ない場合は note に合わせて再生される
// dur の配列の個数が note より少ない場合、dur の配列の個数分しか note は再生されない
// 意図的に dur の個数を減らすことで、メロディーを途中で切ることもできる
(
Pbind.new(
	\instrument, "synth1",
	\note, Pseq([0, 2, 4, 5], 2),
	\dur, Pseq([1, 0.5, 0.5, 1], 2)
).play();
)

// 無限ループバージョン
// inf = infinite を指定する
(
Pbind.new(
	\instrument, "synth1",
	\note, Pseq([0, 2, 4, 5], inf),
	\dur, Pseq([1, 0.5, 0.5, 1], inf)
).play();
)

// bpm を変えたい場合
// bpm 100 の例 (defualt は 60/60
(
Pbind.new(
	\instrument, "synth1",
	\note, Pseq([0, 2, 4, 5], 2),
	\dur, Pseq([1, 0.5, 0.5, 1], 2)
).play(TempoClock.new(100/60));
)


// エンベロープのパラメーターも arg に加えてみる
(
SynthDef.new("synth2", {
	// arg でこの functoon の引数を設定
	// デフォルト値も設定できる
	arg freq=440, atk=0.01, rls=0.8;
	var sig, env;
	env = EnvGen.kr(Env.perc(atk, rls), doneAction:2);
	sig = Saw.ar(freq, 0.3)!2;
	Out.ar(0, sig * env)
}).add;
)

// デフォルト値が指定されているので、arg を指定しなくても良い
Synth.new("synth2");
// アタックタイムを長めに設定してみる
Synth.new("synth2", [\freq, 440, \atk, 1.0, \rls, 1.0]);
