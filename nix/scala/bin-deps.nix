{ mkBinPackage, mkMetadataPackage, genRepo }:
genRepo [

(mkBinPackage {
  name = "antlr_2_7_7";
  pname = "antlr";
  version = "2.7.7";
  org = "antlr";
  jarUrl = "https://repo1.maven.org/maven2/antlr/antlr/2.7.7/antlr-2.7.7.jar";
  jarSha256 = "0k6wav7w33z1sgfwyvkpa7xsqjwmrj0fa4lfdvsvk5i5j55xmyw8";
  jarDest = "maven/antlr/antlr/2.7.7/antlr-2.7.7.jar";
  metaUrl = "https://repo1.maven.org/maven2/antlr/antlr/2.7.7/antlr-2.7.7.pom";
  metaSha256 = "1dyf3yxs01zagx905z2cz7h58vpkxdqn3d7d0i14x2vzl8xpj3qh";
  metaDest = "maven/antlr/antlr/2.7.7/antlr-2.7.7.pom";
})

(mkBinPackage {
  name = "logback-classic_1_2_3";
  pname = "logback-classic";
  version = "1.2.3";
  org = "ch.qos.logback";
  jarUrl = "https://repo1.maven.org/maven2/ch/qos/logback/logback-classic/1.2.3/logback-classic-1.2.3.jar";
  jarSha256 = "1q1pmkmsadlaknsj1c7b1741vv2n408kiqan784qzjvzkr9zhlzv";
  jarDest = "maven/ch/qos/logback/logback-classic/1.2.3/logback-classic-1.2.3.jar";
  metaUrl = "https://repo1.maven.org/maven2/ch/qos/logback/logback-classic/1.2.3/logback-classic-1.2.3.pom";
  metaSha256 = "05ak3a8c8jqj901rd0k6jw3gzlkmbhfvg3namfckrfa84ldfnld0";
  metaDest = "maven/ch/qos/logback/logback-classic/1.2.3/logback-classic-1.2.3.pom";
})

(mkBinPackage {
  name = "logback-core_1_2_3";
  pname = "logback-core";
  version = "1.2.3";
  org = "ch.qos.logback";
  jarUrl = "https://repo1.maven.org/maven2/ch/qos/logback/logback-core/1.2.3/logback-core-1.2.3.jar";
  jarSha256 = "08kz45cghag47r2slsfxpdccghzc4rlpmniyll10r5kgzqvxhijr";
  jarDest = "maven/ch/qos/logback/logback-core/1.2.3/logback-core-1.2.3.jar";
  metaUrl = "https://repo1.maven.org/maven2/ch/qos/logback/logback-core/1.2.3/logback-core-1.2.3.pom";
  metaSha256 = "1q4p9shxny1h1jgi6x6jvm1ics6ph08rfrxhmam5nraixj0p2kfz";
  metaDest = "maven/ch/qos/logback/logback-core/1.2.3/logback-core-1.2.3.pom";
})

(mkBinPackage {
  name = "jcommander_1_35";
  pname = "jcommander";
  version = "1.35";
  org = "com.beust";
  jarUrl = "https://repo1.maven.org/maven2/com/beust/jcommander/1.35/jcommander-1.35.jar";
  jarSha256 = "0300cgl86wjkwm4sb2cwrh72mnc6iangcl5img5h4p6fq7z15701";
  jarDest = "maven/com/beust/jcommander/1.35/jcommander-1.35.jar";
  metaUrl = "https://repo1.maven.org/maven2/com/beust/jcommander/1.35/jcommander-1.35.pom";
  metaSha256 = "0dvnyv4gv9961m9kkwrz802xsg56vpskpm2x9qic3bd8v0x1pviw";
  metaDest = "maven/com/beust/jcommander/1.35/jcommander-1.35.pom";
})

(mkBinPackage {
  name = "gigahorse-core_2_12_0_3_0";
  pname = "gigahorse-core_2.12";
  version = "0.3.0";
  org = "com.eed3si9n";
  jarUrl = "https://repo1.maven.org/maven2/com/eed3si9n/gigahorse-core_2.12/0.3.0/gigahorse-core_2.12-0.3.0.jar";
  jarSha256 = "194acyydd99z39ajlpzjqgn1qqmfxlgckdflx6bmg4cac1vqw6cz";
  jarDest = "maven/com/eed3si9n/gigahorse-core_2.12/0.3.0/gigahorse-core_2.12-0.3.0.jar";
  metaUrl = "https://repo1.maven.org/maven2/com/eed3si9n/gigahorse-core_2.12/0.3.0/gigahorse-core_2.12-0.3.0.pom";
  metaSha256 = "1hhazgpfl8awd42wxyqjsx2px7h3rb6c8519dpjylzr2c98lm2rg";
  metaDest = "maven/com/eed3si9n/gigahorse-core_2.12/0.3.0/gigahorse-core_2.12-0.3.0.pom";
})

(mkBinPackage {
  name = "gigahorse-okhttp_2_12_0_3_0";
  pname = "gigahorse-okhttp_2.12";
  version = "0.3.0";
  org = "com.eed3si9n";
  jarUrl = "https://repo1.maven.org/maven2/com/eed3si9n/gigahorse-okhttp_2.12/0.3.0/gigahorse-okhttp_2.12-0.3.0.jar";
  jarSha256 = "1pxvpk724ky6gn1qyy1xhbvhlwc3iwvny1mca6l8m84hknxyiy2w";
  jarDest = "maven/com/eed3si9n/gigahorse-okhttp_2.12/0.3.0/gigahorse-okhttp_2.12-0.3.0.jar";
  metaUrl = "https://repo1.maven.org/maven2/com/eed3si9n/gigahorse-okhttp_2.12/0.3.0/gigahorse-okhttp_2.12-0.3.0.pom";
  metaSha256 = "0bwxklha2lqvgz1s4na7x3kfh6yinaciviqfxy14f8nk3asll66r";
  metaDest = "maven/com/eed3si9n/gigahorse-okhttp_2.12/0.3.0/gigahorse-okhttp_2.12-0.3.0.pom";
})

(mkBinPackage {
  name = "shaded-scalajson_2_12_1_0_0-M4";
  pname = "shaded-scalajson_2.12";
  version = "1.0.0-M4";
  org = "com.eed3si9n";
  jarUrl = "https://repo1.maven.org/maven2/com/eed3si9n/shaded-scalajson_2.12/1.0.0-M4/shaded-scalajson_2.12-1.0.0-M4.jar";
  jarSha256 = "0h2s0p3ja8c3c8szcy9zc2jmkcznq5kvfk2bgpjhz87w631m2h16";
  jarDest = "maven/com/eed3si9n/shaded-scalajson_2.12/1.0.0-M4/shaded-scalajson_2.12-1.0.0-M4.jar";
  metaUrl = "https://repo1.maven.org/maven2/com/eed3si9n/shaded-scalajson_2.12/1.0.0-M4/shaded-scalajson_2.12-1.0.0-M4.pom";
  metaSha256 = "1l0mfsrynxykl0f0b0i9d2nkz92d4075n2pql5bk9awc51a07yfa";
  metaDest = "maven/com/eed3si9n/shaded-scalajson_2.12/1.0.0-M4/shaded-scalajson_2.12-1.0.0-M4.pom";
})

(mkBinPackage {
  name = "sjson-new-core_2_12_0_8_2";
  pname = "sjson-new-core_2.12";
  version = "0.8.2";
  org = "com.eed3si9n";
  jarUrl = "https://repo1.maven.org/maven2/com/eed3si9n/sjson-new-core_2.12/0.8.2/sjson-new-core_2.12-0.8.2.jar";
  jarSha256 = "0c2q54clg70rpwk98qpm87sz04359sqblgbjkmah7rzj7y4alrqc";
  jarDest = "maven/com/eed3si9n/sjson-new-core_2.12/0.8.2/sjson-new-core_2.12-0.8.2.jar";
  metaUrl = "https://repo1.maven.org/maven2/com/eed3si9n/sjson-new-core_2.12/0.8.2/sjson-new-core_2.12-0.8.2.pom";
  metaSha256 = "0n79nz30rcv5j7qdwly6naw0cvqd331s7ys5ysfmrw75fjrlc29b";
  metaDest = "maven/com/eed3si9n/sjson-new-core_2.12/0.8.2/sjson-new-core_2.12-0.8.2.pom";
})

(mkBinPackage {
  name = "sjson-new-murmurhash_2_12_0_8_2";
  pname = "sjson-new-murmurhash_2.12";
  version = "0.8.2";
  org = "com.eed3si9n";
  jarUrl = "https://repo1.maven.org/maven2/com/eed3si9n/sjson-new-murmurhash_2.12/0.8.2/sjson-new-murmurhash_2.12-0.8.2.jar";
  jarSha256 = "14rvb4w34qdy98d2al7gibabxqc0zyxbm3jyv62b6j0wdg2j5rn8";
  jarDest = "maven/com/eed3si9n/sjson-new-murmurhash_2.12/0.8.2/sjson-new-murmurhash_2.12-0.8.2.jar";
  metaUrl = "https://repo1.maven.org/maven2/com/eed3si9n/sjson-new-murmurhash_2.12/0.8.2/sjson-new-murmurhash_2.12-0.8.2.pom";
  metaSha256 = "1hdlky1i1hw09fsfy77qi5syvq523zyzr113jblp5z2ki3allp1i";
  metaDest = "maven/com/eed3si9n/sjson-new-murmurhash_2.12/0.8.2/sjson-new-murmurhash_2.12-0.8.2.pom";
})

(mkBinPackage {
  name = "sjson-new-scalajson_2_12_0_8_2";
  pname = "sjson-new-scalajson_2.12";
  version = "0.8.2";
  org = "com.eed3si9n";
  jarUrl = "https://repo1.maven.org/maven2/com/eed3si9n/sjson-new-scalajson_2.12/0.8.2/sjson-new-scalajson_2.12-0.8.2.jar";
  jarSha256 = "17c4diw12qwfas3jnlg9800kv79i6fdspv8lzxd9ws0x6frs6bm7";
  jarDest = "maven/com/eed3si9n/sjson-new-scalajson_2.12/0.8.2/sjson-new-scalajson_2.12-0.8.2.jar";
  metaUrl = "https://repo1.maven.org/maven2/com/eed3si9n/sjson-new-scalajson_2.12/0.8.2/sjson-new-scalajson_2.12-0.8.2.pom";
  metaSha256 = "0fk4v1v75kf9cc0fxap1gwwn7zrammvbzr637536bkcll4jc95jd";
  metaDest = "maven/com/eed3si9n/sjson-new-scalajson_2.12/0.8.2/sjson-new-scalajson_2.12-0.8.2.pom";
})

(mkBinPackage {
  name = "jackson-core_2_7_3";
  pname = "jackson-core";
  version = "2.7.3";
  org = "com.fasterxml.jackson.core";
  jarUrl = "https://repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-core/2.7.3/jackson-core-2.7.3.jar";
  jarSha256 = "0j7drk927hn970zkmz1ymbp74wys5qsqqlzpr677infwc87yzmgn";
  jarDest = "maven/com/fasterxml/jackson/core/jackson-core/2.7.3/jackson-core-2.7.3.jar";
  metaUrl = "https://repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-core/2.7.3/jackson-core-2.7.3.pom";
  metaSha256 = "0k3jf6bvaizmc5j9dcbxxxi7sxb0gj4bkx9d208kv6pffzbjcfnq";
  metaDest = "maven/com/fasterxml/jackson/core/jackson-core/2.7.3/jackson-core-2.7.3.pom";
})

(mkBinPackage {
  name = "caffeine_2_5_6";
  pname = "caffeine";
  version = "2.5.6";
  org = "com.github.ben-manes.caffeine";
  jarUrl = "https://repo1.maven.org/maven2/com/github/ben-manes/caffeine/caffeine/2.5.6/caffeine-2.5.6.jar";
  jarSha256 = "190k38aa12qz2csa4v4z2llxaap7mf049fa2lv6cmw7anmvkmsvz";
  jarDest = "maven/com/github/ben-manes/caffeine/caffeine/2.5.6/caffeine-2.5.6.jar";
  metaUrl = "https://repo1.maven.org/maven2/com/github/ben-manes/caffeine/caffeine/2.5.6/caffeine-2.5.6.pom";
  metaSha256 = "1kp4dfs0gm31fiby2xbdn3k364wl7z0s04zqg2acq52xswbpxsaq";
  metaDest = "maven/com/github/ben-manes/caffeine/caffeine/2.5.6/caffeine-2.5.6.pom";
})

(mkBinPackage {
  name = "scalacache-caffeine_2_12_0_20_0";
  pname = "scalacache-caffeine_2.12";
  version = "0.20.0";
  org = "com.github.cb372";
  jarUrl = "https://repo1.maven.org/maven2/com/github/cb372/scalacache-caffeine_2.12/0.20.0/scalacache-caffeine_2.12-0.20.0.jar";
  jarSha256 = "15bzss3fbjfp2x7fqmwnby2d6agpsg19kf0n7ybpgav1s59sgp21";
  jarDest = "maven/com/github/cb372/scalacache-caffeine_2.12/0.20.0/scalacache-caffeine_2.12-0.20.0.jar";
  metaUrl = "https://repo1.maven.org/maven2/com/github/cb372/scalacache-caffeine_2.12/0.20.0/scalacache-caffeine_2.12-0.20.0.pom";
  metaSha256 = "05n4iy6li34150i6j3imd64hhww7bfsdi5pnkln5lw34pypj2lic";
  metaDest = "maven/com/github/cb372/scalacache-caffeine_2.12/0.20.0/scalacache-caffeine_2.12-0.20.0.pom";
})

(mkBinPackage {
  name = "scalacache-core_2_12_0_20_0";
  pname = "scalacache-core_2.12";
  version = "0.20.0";
  org = "com.github.cb372";
  jarUrl = "https://repo1.maven.org/maven2/com/github/cb372/scalacache-core_2.12/0.20.0/scalacache-core_2.12-0.20.0.jar";
  jarSha256 = "1zhpiaws8dzilw2rqw4gvs7sx8jhzk89yi25zrcxqirr0s1v9dmx";
  jarDest = "maven/com/github/cb372/scalacache-core_2.12/0.20.0/scalacache-core_2.12-0.20.0.jar";
  metaUrl = "https://repo1.maven.org/maven2/com/github/cb372/scalacache-core_2.12/0.20.0/scalacache-core_2.12-0.20.0.pom";
  metaSha256 = "0rgymg59hc6df64jl7ynr2zlqivw0sk68lh62wm3hcx3d7zalryk";
  metaDest = "maven/com/github/cb372/scalacache-core_2.12/0.20.0/scalacache-core_2.12-0.20.0.pom";
})

(mkBinPackage {
  name = "nscala-time_2_12_2_14_0";
  pname = "nscala-time_2.12";
  version = "2.14.0";
  org = "com.github.nscala-time";
  jarUrl = "https://repo1.maven.org/maven2/com/github/nscala-time/nscala-time_2.12/2.14.0/nscala-time_2.12-2.14.0.jar";
  jarSha256 = "19k4vg5fm2748w9anhig75as5fzz7fahn2zwqp4nnx2asg8mp5rl";
  jarDest = "maven/com/github/nscala-time/nscala-time_2.12/2.14.0/nscala-time_2.12-2.14.0.jar";
  metaUrl = "https://repo1.maven.org/maven2/com/github/nscala-time/nscala-time_2.12/2.14.0/nscala-time_2.12-2.14.0.pom";
  metaSha256 = "1va5kibavkidbd7kw4pg3k9wxvrng15p997ihx1yp10lypyvhrwj";
  metaDest = "maven/com/github/nscala-time/nscala-time_2.12/2.14.0/nscala-time_2.12-2.14.0.pom";
})

(mkBinPackage {
  name = "scopt_2_12_3_7_0";
  pname = "scopt_2.12";
  version = "3.7.0";
  org = "com.github.scopt";
  jarUrl = "https://repo1.maven.org/maven2/com/github/scopt/scopt_2.12/3.7.0/scopt_2.12-3.7.0.jar";
  jarSha256 = "0micrr3iwq6bcxqxdra9gj0njypxm4qk5144k9my0rzj34lgy18i";
  jarDest = "maven/com/github/scopt/scopt_2.12/3.7.0/scopt_2.12-3.7.0.jar";
  metaUrl = "https://repo1.maven.org/maven2/com/github/scopt/scopt_2.12/3.7.0/scopt_2.12-3.7.0.pom";
  metaSha256 = "1arq5jb8rn0g6w187za5gb11d12w3qng4ly0mgm2p1zadb83wsf5";
  metaDest = "maven/com/github/scopt/scopt_2.12/3.7.0/scopt_2.12-3.7.0.pom";
})

(mkBinPackage {
  name = "JavaEWAH_0_7_9";
  pname = "JavaEWAH";
  version = "0.7.9";
  org = "com.googlecode.javaewah";
  jarUrl = "https://repo1.maven.org/maven2/com/googlecode/javaewah/JavaEWAH/0.7.9/JavaEWAH-0.7.9.jar";
  jarSha256 = "1i5zbarzr744sgbh73m1jmxd4y3r2wf7z0bmbxrhyqakj7mrsjgw";
  jarDest = "maven/com/googlecode/javaewah/JavaEWAH/0.7.9/JavaEWAH-0.7.9.jar";
  metaUrl = "https://repo1.maven.org/maven2/com/googlecode/javaewah/JavaEWAH/0.7.9/JavaEWAH-0.7.9.pom";
  metaSha256 = "1dd0xv61klr4531ydlzqd0wmr1phpri5jsdr017zc9qz11dxl1db";
  metaDest = "maven/com/googlecode/javaewah/JavaEWAH/0.7.9/JavaEWAH-0.7.9.pom";
})

(mkBinPackage {
  name = "protobuf-java_3_3_1";
  pname = "protobuf-java";
  version = "3.3.1";
  org = "com.google.protobuf";
  jarUrl = "https://repo1.maven.org/maven2/com/google/protobuf/protobuf-java/3.3.1/protobuf-java-3.3.1.jar";
  jarSha256 = "0i3lv493myyn2aj77g66yj4d2gnsfcpx9hrw0pssdaz7jkmjxf4h";
  jarDest = "maven/com/google/protobuf/protobuf-java/3.3.1/protobuf-java-3.3.1.jar";
  metaUrl = "https://repo1.maven.org/maven2/com/google/protobuf/protobuf-java/3.3.1/protobuf-java-3.3.1.pom";
  metaSha256 = "14prsiaby62vxd41qjfgrq0civ2ds17lxqyrq8x3738dndx8y16z";
  metaDest = "maven/com/google/protobuf/protobuf-java/3.3.1/protobuf-java-3.3.1.pom";
})

(mkBinPackage {
  name = "protobuf-java_3_4_0";
  pname = "protobuf-java";
  version = "3.4.0";
  org = "com.google.protobuf";
  jarUrl = "https://repo1.maven.org/maven2/com/google/protobuf/protobuf-java/3.4.0/protobuf-java-3.4.0.jar";
  jarSha256 = "194hchg28sckqycfg4c3cm41bdxcm3rsy36sk08insj569mydryw";
  jarDest = "maven/com/google/protobuf/protobuf-java/3.4.0/protobuf-java-3.4.0.jar";
  metaUrl = "https://repo1.maven.org/maven2/com/google/protobuf/protobuf-java/3.4.0/protobuf-java-3.4.0.pom";
  metaSha256 = "01llqnrfxa04q1ndnrcvsg0j3vs2rva3101w79da38azdjl7pwc3";
  metaDest = "maven/com/google/protobuf/protobuf-java/3.4.0/protobuf-java-3.4.0.pom";
})

(mkBinPackage {
  name = "icu4j_58_2";
  pname = "icu4j";
  version = "58.2";
  org = "com.ibm.icu";
  jarUrl = "https://repo1.maven.org/maven2/com/ibm/icu/icu4j/58.2/icu4j-58.2.jar";
  jarSha256 = "0qirnrb7f63z3m9chy1m3pkyjisgc49nra4dz2i3wz5yna1iwglm";
  jarDest = "maven/com/ibm/icu/icu4j/58.2/icu4j-58.2.jar";
  metaUrl = "https://repo1.maven.org/maven2/com/ibm/icu/icu4j/58.2/icu4j-58.2.pom";
  metaSha256 = "0shl6klv7pqi338if5rjnzyp6v2z6c8qnyxy8jjrk93j5kbnmdj7";
  metaDest = "maven/com/ibm/icu/icu4j/58.2/icu4j-58.2.pom";
})

(mkBinPackage {
  name = "jsch_0_1_46";
  pname = "jsch";
  version = "0.1.46";
  org = "com.jcraft";
  jarUrl = "https://repo1.maven.org/maven2/com/jcraft/jsch/0.1.46/jsch-0.1.46.jar";
  jarSha256 = "04nr5cqy0c2wilcyi9y86m5yvi5wngps8zayqgcg9pw162f65ka8";
  jarDest = "maven/com/jcraft/jsch/0.1.46/jsch-0.1.46.jar";
  metaUrl = "https://repo1.maven.org/maven2/com/jcraft/jsch/0.1.46/jsch-0.1.46.pom";
  metaSha256 = "1i7gc2170pn0k6jhdhf38yga9nv3ny39mz8aflysvvvhwp0wwq7b";
  metaDest = "maven/com/jcraft/jsch/0.1.46/jsch-0.1.46.pom";
})

(mkBinPackage {
  name = "jsch_0_1_53";
  pname = "jsch";
  version = "0.1.53";
  org = "com.jcraft";
  jarUrl = "https://repo1.maven.org/maven2/com/jcraft/jsch/0.1.53/jsch-0.1.53.jar";
  jarSha256 = "0ch9806hvckqanpkrqr5kpsycnj1kg4fs010pzv8xabhknr5q3gh";
  jarDest = "maven/com/jcraft/jsch/0.1.53/jsch-0.1.53.jar";
  metaUrl = "https://repo1.maven.org/maven2/com/jcraft/jsch/0.1.53/jsch-0.1.53.pom";
  metaSha256 = "0jaxlwr58af13bk5psj5b0wplvn64n0d1gih6s9vgf907rk6j0sl";
  metaDest = "maven/com/jcraft/jsch/0.1.53/jsch-0.1.53.pom";
})

(mkBinPackage {
  name = "jsch_0_1_54";
  pname = "jsch";
  version = "0.1.54";
  org = "com.jcraft";
  jarUrl = "https://repo1.maven.org/maven2/com/jcraft/jsch/0.1.54/jsch-0.1.54.jar";
  jarSha256 = "1nqz1r2q1nrm2bz1573c95pwahhqrsh07znlzmw28xhn6cx2gswj";
  jarDest = "maven/com/jcraft/jsch/0.1.54/jsch-0.1.54.jar";
  metaUrl = "https://repo1.maven.org/maven2/com/jcraft/jsch/0.1.54/jsch-0.1.54.pom";
  metaSha256 = "0y1libpsmrcalmyr2ca495c0k8nqm6s47rqq1vi6lzxy74h533xb";
  metaDest = "maven/com/jcraft/jsch/0.1.54/jsch-0.1.54.pom";
})

(mkBinPackage {
  name = "paradox_2_12_0_3_0";
  pname = "paradox_2.12";
  version = "0.3.0";
  org = "com.lightbend.paradox";
  jarUrl = "https://repo1.maven.org/maven2/com/lightbend/paradox/paradox_2.12/0.3.0/paradox_2.12-0.3.0.jar";
  jarSha256 = "1m22zyn0rrgzkz0zhh0vk198l79kb3v322d6l1qrni4sr9yd9za8";
  jarDest = "maven/com/lightbend/paradox/paradox_2.12/0.3.0/paradox_2.12-0.3.0.jar";
  metaUrl = "https://repo1.maven.org/maven2/com/lightbend/paradox/paradox_2.12/0.3.0/paradox_2.12-0.3.0.pom";
  metaSha256 = "144r75jnggh3wjpdjwa9w2p19m10gpdgwh2473vlfvffghymgqkj";
  metaDest = "maven/com/lightbend/paradox/paradox_2.12/0.3.0/paradox_2.12-0.3.0.pom";
})

(mkBinPackage {
  name = "paradox-theme-generic_0_2_13";
  pname = "paradox-theme-generic";
  version = "0.2.13";
  org = "com.lightbend.paradox";
  jarUrl = "https://repo1.maven.org/maven2/com/lightbend/paradox/paradox-theme-generic/0.2.13/paradox-theme-generic-0.2.13.jar";
  jarSha256 = "1ipf42cl5nhbjms3v2mm4rqin5hjp2imjm8yf2vzx5abpa9dvpb9";
  jarDest = "maven/com/lightbend/paradox/paradox-theme-generic/0.2.13/paradox-theme-generic-0.2.13.jar";
  metaUrl = "https://repo1.maven.org/maven2/com/lightbend/paradox/paradox-theme-generic/0.2.13/paradox-theme-generic-0.2.13.pom";
  metaSha256 = "08q1zmfj6hd0lwn7liq65pnvji9rbqazwz0ym9m87fibzw7br550";
  metaDest = "maven/com/lightbend/paradox/paradox-theme-generic/0.2.13/paradox-theme-generic-0.2.13.pom";
})

(mkBinPackage {
  name = "fastparse_2_12_0_4_2";
  pname = "fastparse_2.12";
  version = "0.4.2";
  org = "com.lihaoyi";
  jarUrl = "https://repo1.maven.org/maven2/com/lihaoyi/fastparse_2.12/0.4.2/fastparse_2.12-0.4.2.jar";
  jarSha256 = "1a11bfnmpw9n452kznxdy5j0fai7cpk0g8bv2qvj344y2y3pgxa3";
  jarDest = "maven/com/lihaoyi/fastparse_2.12/0.4.2/fastparse_2.12-0.4.2.jar";
  metaUrl = "https://repo1.maven.org/maven2/com/lihaoyi/fastparse_2.12/0.4.2/fastparse_2.12-0.4.2.pom";
  metaSha256 = "04w66nrbb2xi5klrybsbihcwyyxykq9mm88mq3zlz19r4wh8xqwg";
  metaDest = "maven/com/lihaoyi/fastparse_2.12/0.4.2/fastparse_2.12-0.4.2.pom";
})

(mkBinPackage {
  name = "fastparse-utils_2_12_0_4_2";
  pname = "fastparse-utils_2.12";
  version = "0.4.2";
  org = "com.lihaoyi";
  jarUrl = "https://repo1.maven.org/maven2/com/lihaoyi/fastparse-utils_2.12/0.4.2/fastparse-utils_2.12-0.4.2.jar";
  jarSha256 = "00g1b3srailvcq4cw29g1as7klydv08jpqznqad01xyki4y0v90d";
  jarDest = "maven/com/lihaoyi/fastparse-utils_2.12/0.4.2/fastparse-utils_2.12-0.4.2.jar";
  metaUrl = "https://repo1.maven.org/maven2/com/lihaoyi/fastparse-utils_2.12/0.4.2/fastparse-utils_2.12-0.4.2.pom";
  metaSha256 = "18chdc95wxyg7q3i4ya38384x8vlqi8iwqanaaz8waf1h24ss5wg";
  metaDest = "maven/com/lihaoyi/fastparse-utils_2.12/0.4.2/fastparse-utils_2.12-0.4.2.pom";
})

(mkBinPackage {
  name = "sourcecode_2_12_0_1_3";
  pname = "sourcecode_2.12";
  version = "0.1.3";
  org = "com.lihaoyi";
  jarUrl = "https://repo1.maven.org/maven2/com/lihaoyi/sourcecode_2.12/0.1.3/sourcecode_2.12-0.1.3.jar";
  jarSha256 = "1jny10sc2z10cl58m63bhhlxznzfg66qrnwq8wqa75k4sjhar8rv";
  jarDest = "maven/com/lihaoyi/sourcecode_2.12/0.1.3/sourcecode_2.12-0.1.3.jar";
  metaUrl = "https://repo1.maven.org/maven2/com/lihaoyi/sourcecode_2.12/0.1.3/sourcecode_2.12-0.1.3.pom";
  metaSha256 = "1v0ngf12q2naf0dvkj6dgy9mlxlszkh4ljqwv42572vgzxgvnbn5";
  metaDest = "maven/com/lihaoyi/sourcecode_2.12/0.1.3/sourcecode_2.12-0.1.3.pom";
})

(mkBinPackage {
  name = "disruptor_3_3_6";
  pname = "disruptor";
  version = "3.3.6";
  org = "com.lmax";
  jarUrl = "https://repo1.maven.org/maven2/com/lmax/disruptor/3.3.6/disruptor-3.3.6.jar";
  jarSha256 = "0rnjbmymidz4rlafg23p9dlnxwg56m4pr6ycr964c57n2wmg2pcc";
  jarDest = "maven/com/lmax/disruptor/3.3.6/disruptor-3.3.6.jar";
  metaUrl = "https://repo1.maven.org/maven2/com/lmax/disruptor/3.3.6/disruptor-3.3.6.pom";
  metaSha256 = "1zcvixl10ra7cp0603rvyrk1pfbhgb4qp65q9y2q8aicvpmkrc7c";
  metaDest = "maven/com/lmax/disruptor/3.3.6/disruptor-3.3.6.pom";
})

(mkBinPackage {
  name = "disruptor_3_4_2";
  pname = "disruptor";
  version = "3.4.2";
  org = "com.lmax";
  jarUrl = "https://repo1.maven.org/maven2/com/lmax/disruptor/3.4.2/disruptor-3.4.2.jar";
  jarSha256 = "1h26hnx0rx9qzjdqriqrp2a8vsixf84l2n33bss6092w4fxyq4pl";
  jarDest = "maven/com/lmax/disruptor/3.4.2/disruptor-3.4.2.jar";
  metaUrl = "https://repo1.maven.org/maven2/com/lmax/disruptor/3.4.2/disruptor-3.4.2.pom";
  metaSha256 = "1npma26j5h6fsw7p66kk313scxg33ipnsknin9cz4qnac7ifa4bk";
  metaDest = "maven/com/lmax/disruptor/3.4.2/disruptor-3.4.2.pom";
})

(mkBinPackage {
  name = "commons-codec_1_10";
  pname = "commons-codec";
  version = "1.10";
  org = "commons-codec";
  jarUrl = "https://repo1.maven.org/maven2/commons-codec/commons-codec/1.10/commons-codec-1.10.jar";
  jarSha256 = "0scm6321zz76dc3bs8sy2qyami755lz4lq5455gl67bi9slxyha2";
  jarDest = "maven/commons-codec/commons-codec/1.10/commons-codec-1.10.jar";
  metaUrl = "https://repo1.maven.org/maven2/commons-codec/commons-codec/1.10/commons-codec-1.10.pom";
  metaSha256 = "1yscxabk7i59vgfjg7c1y3prj39h1d8prnwgxbisc4ni29qdpf5x";
  metaDest = "maven/commons-codec/commons-codec/1.10/commons-codec-1.10.pom";
})

(mkBinPackage {
  name = "commons-logging_1_1_3";
  pname = "commons-logging";
  version = "1.1.3";
  org = "commons-logging";
  jarUrl = "https://repo1.maven.org/maven2/commons-logging/commons-logging/1.1.3/commons-logging-1.1.3.jar";
  jarSha256 = "110p76ws0ql4zs8jjr0jldq0h3yrc4zl884zvb40i69fr1pkz43h";
  jarDest = "maven/commons-logging/commons-logging/1.1.3/commons-logging-1.1.3.jar";
  metaUrl = "https://repo1.maven.org/maven2/commons-logging/commons-logging/1.1.3/commons-logging-1.1.3.pom";
  metaSha256 = "0jaqhvjaf9sxaph6lnj07vb96a9b0csh7kgm643fsq5xqqxaql1j";
  metaDest = "maven/commons-logging/commons-logging/1.1.3/commons-logging-1.1.3.pom";
})

(mkBinPackage {
  name = "okhttp_3_7_0";
  pname = "okhttp";
  version = "3.7.0";
  org = "com.squareup.okhttp3";
  jarUrl = "https://repo1.maven.org/maven2/com/squareup/okhttp3/okhttp/3.7.0/okhttp-3.7.0.jar";
  jarSha256 = "0rc1g9cj2rkwd0wcpsavj283salvlzgvjhxx8npy2xfs6shbsnpm";
  jarDest = "maven/com/squareup/okhttp3/okhttp/3.7.0/okhttp-3.7.0.jar";
  metaUrl = "https://repo1.maven.org/maven2/com/squareup/okhttp3/okhttp/3.7.0/okhttp-3.7.0.pom";
  metaSha256 = "1yxabvdzyr2d232917vbyra8y61zm0zmxy2ak0sy2kgqhqyq16l1";
  metaDest = "maven/com/squareup/okhttp3/okhttp/3.7.0/okhttp-3.7.0.pom";
})

(mkBinPackage {
  name = "okhttp-urlconnection_3_7_0";
  pname = "okhttp-urlconnection";
  version = "3.7.0";
  org = "com.squareup.okhttp3";
  jarUrl = "https://repo1.maven.org/maven2/com/squareup/okhttp3/okhttp-urlconnection/3.7.0/okhttp-urlconnection-3.7.0.jar";
  jarSha256 = "1v73zlji4bwiyg896dnkd5wpili6l4xkp8dwn2ywidhqd0mmhca6";
  jarDest = "maven/com/squareup/okhttp3/okhttp-urlconnection/3.7.0/okhttp-urlconnection-3.7.0.jar";
  metaUrl = "https://repo1.maven.org/maven2/com/squareup/okhttp3/okhttp-urlconnection/3.7.0/okhttp-urlconnection-3.7.0.pom";
  metaSha256 = "0njggw47s23jdxjz3nxkfv14z4l6yxi379r2cbbdkr2kb7k8mla9";
  metaDest = "maven/com/squareup/okhttp3/okhttp-urlconnection/3.7.0/okhttp-urlconnection-3.7.0.pom";
})

(mkBinPackage {
  name = "okio_1_12_0";
  pname = "okio";
  version = "1.12.0";
  org = "com.squareup.okio";
  jarUrl = "https://repo1.maven.org/maven2/com/squareup/okio/okio/1.12.0/okio-1.12.0.jar";
  jarSha256 = "1bli6axdpzxa0b9gxh82g4hvlj5ls33z140ndab3fwf3hgjdzrxz";
  jarDest = "maven/com/squareup/okio/okio/1.12.0/okio-1.12.0.jar";
  metaUrl = "https://repo1.maven.org/maven2/com/squareup/okio/okio/1.12.0/okio-1.12.0.pom";
  metaSha256 = "0w24fd8k4q8m37ypcvnr85j706slzxlysiva1pgk2al72y1mcb7g";
  metaDest = "maven/com/squareup/okio/okio/1.12.0/okio-1.12.0.pom";
})

(mkBinPackage {
  name = "apple-file-events_1_3_2";
  pname = "apple-file-events";
  version = "1.3.2";
  org = "com.swoval";
  jarUrl = "https://repo1.maven.org/maven2/com/swoval/apple-file-events/1.3.2/apple-file-events-1.3.2.jar";
  jarSha256 = "12my0yfirasvz3j4nicczlld15jmp25cxgiy5ydgg59p666ij03p";
  jarDest = "maven/com/swoval/apple-file-events/1.3.2/apple-file-events-1.3.2.jar";
  metaUrl = "https://repo1.maven.org/maven2/com/swoval/apple-file-events/1.3.2/apple-file-events-1.3.2.pom";
  metaSha256 = "0ix6g6nhpr4yyarlz3pgsbcl4kn5dgy8qymvzvkwv2mjpp6s9fkc";
  metaDest = "maven/com/swoval/apple-file-events/1.3.2/apple-file-events-1.3.2.pom";
})

(mkBinPackage {
  name = "paranamer_2_8";
  pname = "paranamer";
  version = "2.8";
  org = "com.thoughtworks.paranamer";
  jarUrl = "https://repo1.maven.org/maven2/com/thoughtworks/paranamer/paranamer/2.8/paranamer-2.8.jar";
  jarSha256 = "01yzrqxcdv2vc6xj8ymlwj5nhcb0jn620mg8728q2782lqcb3338";
  jarDest = "maven/com/thoughtworks/paranamer/paranamer/2.8/paranamer-2.8.jar";
  metaUrl = "https://repo1.maven.org/maven2/com/thoughtworks/paranamer/paranamer/2.8/paranamer-2.8.pom";
  metaSha256 = "0miqv4k6b8a383nbyliibh9dafamllni688nck78sbamw16l1nym";
  metaDest = "maven/com/thoughtworks/paranamer/paranamer/2.8/paranamer-2.8.pom";
})

(mkBinPackage {
  name = "lenses_2_12_0_4_12";
  pname = "lenses_2.12";
  version = "0.4.12";
  org = "com.trueaccord.lenses";
  jarUrl = "https://repo1.maven.org/maven2/com/trueaccord/lenses/lenses_2.12/0.4.12/lenses_2.12-0.4.12.jar";
  jarSha256 = "072cv1na9d49l1p44jn5rma6kzmp4kn3lvvd8rbg3lss2b1wpvbw";
  jarDest = "maven/com/trueaccord/lenses/lenses_2.12/0.4.12/lenses_2.12-0.4.12.jar";
  metaUrl = "https://repo1.maven.org/maven2/com/trueaccord/lenses/lenses_2.12/0.4.12/lenses_2.12-0.4.12.pom";
  metaSha256 = "0yvh7953gnpp556za95xy9274pqjf4b0f51ny3da7siik88lhsjs";
  metaDest = "maven/com/trueaccord/lenses/lenses_2.12/0.4.12/lenses_2.12-0.4.12.pom";
})

(mkBinPackage {
  name = "scalapb-runtime_2_12_0_6_0";
  pname = "scalapb-runtime_2.12";
  version = "0.6.0";
  org = "com.trueaccord.scalapb";
  jarUrl = "https://repo1.maven.org/maven2/com/trueaccord/scalapb/scalapb-runtime_2.12/0.6.0/scalapb-runtime_2.12-0.6.0.jar";
  jarSha256 = "13bzs68gmlaqdg5xz032sgk8q53wyy675779dqnqbi6hlmbw28br";
  jarDest = "maven/com/trueaccord/scalapb/scalapb-runtime_2.12/0.6.0/scalapb-runtime_2.12-0.6.0.jar";
  metaUrl = "https://repo1.maven.org/maven2/com/trueaccord/scalapb/scalapb-runtime_2.12/0.6.0/scalapb-runtime_2.12-0.6.0.pom";
  metaSha256 = "0iy6yi24lq5r830hq499swjvdnm7gc2hh7pg4h4bq2r94k6nhf7c";
  metaDest = "maven/com/trueaccord/scalapb/scalapb-runtime_2.12/0.6.0/scalapb-runtime_2.12-0.6.0.pom";
})

(mkBinPackage {
  name = "akka-actor_2_12_2_5_4";
  pname = "akka-actor_2.12";
  version = "2.5.4";
  org = "com.typesafe.akka";
  jarUrl = "https://repo1.maven.org/maven2/com/typesafe/akka/akka-actor_2.12/2.5.4/akka-actor_2.12-2.5.4.jar";
  jarSha256 = "0x1s66wqcbvk8i3qg387dc5c4y0xnnbwv95w6gwwra6dxfl2hs1k";
  jarDest = "maven/com/typesafe/akka/akka-actor_2.12/2.5.4/akka-actor_2.12-2.5.4.jar";
  metaUrl = "https://repo1.maven.org/maven2/com/typesafe/akka/akka-actor_2.12/2.5.4/akka-actor_2.12-2.5.4.pom";
  metaSha256 = "14fq58j8xmzg52javwplkqh1x1z7gw7a8h53m3q54vf1s9xzx5nl";
  metaDest = "maven/com/typesafe/akka/akka-actor_2.12/2.5.4/akka-actor_2.12-2.5.4.pom";
})

(mkBinPackage {
  name = "config_1_2_0";
  pname = "config";
  version = "1.2.0";
  org = "com.typesafe";
  jarUrl = "https://repo1.maven.org/maven2/com/typesafe/config/1.2.0/config-1.2.0.jar";
  jarSha256 = "0q5xhyyyin4dmw0pnx18lp184msn5ppzmqxib3iv2pxrmklc5wjn";
  jarDest = "maven/com/typesafe/config/1.2.0/config-1.2.0.jar";
  metaUrl = "https://repo1.maven.org/maven2/com/typesafe/config/1.2.0/config-1.2.0.pom";
  metaSha256 = "08p5xrn5lkmhrrwfiswdfqjv914b1w11l2jbnywfw2ka9mgjqyh5";
  metaDest = "maven/com/typesafe/config/1.2.0/config-1.2.0.pom";
})

(mkBinPackage {
  name = "config_1_3_1";
  pname = "config";
  version = "1.3.1";
  org = "com.typesafe";
  jarUrl = "https://repo1.maven.org/maven2/com/typesafe/config/1.3.1/config-1.3.1.jar";
  jarSha256 = "1w2a4rr3kccb6235i5aqp9bvhywydkhy99vap2kd6842233dzyp6";
  jarDest = "maven/com/typesafe/config/1.3.1/config-1.3.1.jar";
  metaUrl = "https://repo1.maven.org/maven2/com/typesafe/config/1.3.1/config-1.3.1.pom";
  metaSha256 = "01bnkq7hfij4qsdsm42dlrihmk9a7a4iscn14wy2h1d6xzhbm5b8";
  metaDest = "maven/com/typesafe/config/1.3.1/config-1.3.1.pom";
})

(mkBinPackage {
  name = "scala-logging_2_12_3_7_2";
  pname = "scala-logging_2.12";
  version = "3.7.2";
  org = "com.typesafe.scala-logging";
  jarUrl = "https://repo1.maven.org/maven2/com/typesafe/scala-logging/scala-logging_2.12/3.7.2/scala-logging_2.12-3.7.2.jar";
  jarSha256 = "1x7dggy1wy05mbhayxban1vblpi6g6z7l54092jj254vjs2c1alb";
  jarDest = "maven/com/typesafe/scala-logging/scala-logging_2.12/3.7.2/scala-logging_2.12-3.7.2.jar";
  metaUrl = "https://repo1.maven.org/maven2/com/typesafe/scala-logging/scala-logging_2.12/3.7.2/scala-logging_2.12-3.7.2.pom";
  metaSha256 = "013y3nrd67zk3c8gwvk1ir5j7mn0lw65y4jalgvdhq0xfrkv422b";
  metaDest = "maven/com/typesafe/scala-logging/scala-logging_2.12/3.7.2/scala-logging_2.12-3.7.2.pom";
})

(mkBinPackage {
  name = "scala-logging_2_12_3_9_0";
  pname = "scala-logging_2.12";
  version = "3.9.0";
  org = "com.typesafe.scala-logging";
  jarUrl = "https://repo1.maven.org/maven2/com/typesafe/scala-logging/scala-logging_2.12/3.9.0/scala-logging_2.12-3.9.0.jar";
  jarSha256 = "1g08fhvycn2vfqvxsgq27s8rfy24v1a1fl0v5jhrjsz2j6c3q1sq";
  jarDest = "maven/com/typesafe/scala-logging/scala-logging_2.12/3.9.0/scala-logging_2.12-3.9.0.jar";
  metaUrl = "https://repo1.maven.org/maven2/com/typesafe/scala-logging/scala-logging_2.12/3.9.0/scala-logging_2.12-3.9.0.pom";
  metaSha256 = "1bwwhy0nz2m6wwbdkmsasqgxdc6p3xa3sgynz0yk5fa94w75vy65";
  metaDest = "maven/com/typesafe/scala-logging/scala-logging_2.12/3.9.0/scala-logging_2.12-3.9.0.pom";
})

(mkBinPackage {
  name = "ssl-config-core_2_12_0_2_2";
  pname = "ssl-config-core_2.12";
  version = "0.2.2";
  org = "com.typesafe";
  jarUrl = "https://repo1.maven.org/maven2/com/typesafe/ssl-config-core_2.12/0.2.2/ssl-config-core_2.12-0.2.2.jar";
  jarSha256 = "1r67al8hfzqvf6718x71wbyh67s733pi0aalb7d9fzzbmp04w56g";
  jarDest = "maven/com/typesafe/ssl-config-core_2.12/0.2.2/ssl-config-core_2.12-0.2.2.jar";
  metaUrl = "https://repo1.maven.org/maven2/com/typesafe/ssl-config-core_2.12/0.2.2/ssl-config-core_2.12-0.2.2.pom";
  metaSha256 = "13wkl4kp07z6sb4ipp8jjk51ngg56nwvprsg3lxwpwig6ns9c7jj";
  metaDest = "maven/com/typesafe/ssl-config-core_2.12/0.2.2/ssl-config-core_2.12-0.2.2.pom";
})

(mkBinPackage {
  name = "jsr250-api_1_0";
  pname = "jsr250-api";
  version = "1.0";
  org = "javax.annotation";
  jarUrl = "https://repo1.maven.org/maven2/javax/annotation/jsr250-api/1.0/jsr250-api-1.0.jar";
  jarSha256 = "07wl9bsxxh9id5rr8vwc1sgibsz1s40srpq073nq7ldnv7825ad1";
  jarDest = "maven/javax/annotation/jsr250-api/1.0/jsr250-api-1.0.jar";
  metaUrl = "https://repo1.maven.org/maven2/javax/annotation/jsr250-api/1.0/jsr250-api-1.0.pom";
  metaSha256 = "0kclcaa2zgvsadld82d5j4wgsf2g83cl0ldghcifymj3y3v0x2sl";
  metaDest = "maven/javax/annotation/jsr250-api/1.0/jsr250-api-1.0.pom";
})

(mkBinPackage {
  name = "cdi-api_1_0";
  pname = "cdi-api";
  version = "1.0";
  org = "javax.enterprise";
  jarUrl = "https://repo1.maven.org/maven2/javax/enterprise/cdi-api/1.0/cdi-api-1.0.jar";
  jarSha256 = "08yla547y4125lfbwj5idip1ppy3c42gj3zj069r2z679hhb440z";
  jarDest = "maven/javax/enterprise/cdi-api/1.0/cdi-api-1.0.jar";
  metaUrl = "https://repo1.maven.org/maven2/javax/enterprise/cdi-api/1.0/cdi-api-1.0.pom";
  metaSha256 = "038hcplrpgk6zmigpdn8517c6kxyffcchxpvhgx6b04jvm05h4j3";
  metaDest = "maven/javax/enterprise/cdi-api/1.0/cdi-api-1.0.pom";
})

(mkBinPackage {
  name = "javax_inject_1";
  pname = "javax.inject";
  version = "1";
  org = "javax.inject";
  jarUrl = "https://repo1.maven.org/maven2/javax/inject/javax.inject/1/javax.inject-1.jar";
  jarSha256 = "1zz7gnahy2352345411rjlhsf64ikkc6z49dqcv1cj0clm271iwi";
  jarDest = "maven/javax/inject/javax.inject/1/javax.inject-1.jar";
  metaUrl = "https://repo1.maven.org/maven2/javax/inject/javax.inject/1/javax.inject-1.pom";
  metaSha256 = "1ylb39if9gqyj98fccb54s0ad25p19d811d2ixih8y3202qi4gll";
  metaDest = "maven/javax/inject/javax.inject/1/javax.inject-1.pom";
})

(mkBinPackage {
  name = "javax_servlet-api_3_1_0";
  pname = "javax.servlet-api";
  version = "3.1.0";
  org = "javax.servlet";
  jarUrl = "https://repo1.maven.org/maven2/javax/servlet/javax.servlet-api/3.1.0/javax.servlet-api-3.1.0.jar";
  jarSha256 = "10l47crybiq5z9qk0kdx6pzdjww9cyy47rzkak7q4khwshnnnidg";
  jarDest = "maven/javax/servlet/javax.servlet-api/3.1.0/javax.servlet-api-3.1.0.jar";
  metaUrl = "https://repo1.maven.org/maven2/javax/servlet/javax.servlet-api/3.1.0/javax.servlet-api-3.1.0.pom";
  metaSha256 = "0schkv7s1a5g6j06j6bcmr8fypd333kk4m4mswddzwm35vi0j4dk";
  metaDest = "maven/javax/servlet/javax.servlet-api/3.1.0/javax.servlet-api-3.1.0.pom";
})

(mkBinPackage {
  name = "jline_2_14_4";
  pname = "jline";
  version = "2.14.4";
  org = "jline";
  jarUrl = "https://repo1.maven.org/maven2/jline/jline/2.14.4/jline-2.14.4.jar";
  jarSha256 = "10kryvsnhzafaagwcz32hqh1vvkmh7xx3jbs3gq12y7mravrwj6b";
  jarDest = "maven/jline/jline/2.14.4/jline-2.14.4.jar";
  metaUrl = "https://repo1.maven.org/maven2/jline/jline/2.14.4/jline-2.14.4.pom";
  metaSha256 = "008nbm3h3cyiim0aiwy9dcc03x9m5nai35vhs5hmnllppxmz9aaz";
  metaDest = "maven/jline/jline/2.14.4/jline-2.14.4.pom";
})

(mkBinPackage {
  name = "jline_2_14_5";
  pname = "jline";
  version = "2.14.5";
  org = "jline";
  jarUrl = "https://repo1.maven.org/maven2/jline/jline/2.14.5/jline-2.14.5.jar";
  jarSha256 = "1kh3a3frp2ji2ivj6zvxmb77aclrgd5d8a491wffcp3g1p4pnd2g";
  jarDest = "maven/jline/jline/2.14.5/jline-2.14.5.jar";
  metaUrl = "https://repo1.maven.org/maven2/jline/jline/2.14.5/jline-2.14.5.pom";
  metaSha256 = "1pk4ia5jzwqizfchpv8hhr9lk71x7zv5j24b87d2p20gqwqfnipx";
  metaDest = "maven/jline/jline/2.14.5/jline-2.14.5.pom";
})

(mkBinPackage {
  name = "jline_2_14_6";
  pname = "jline";
  version = "2.14.6";
  org = "jline";
  jarUrl = "https://repo1.maven.org/maven2/jline/jline/2.14.6/jline-2.14.6.jar";
  jarSha256 = "0bghq9812yd95cyymzdfx0bqbl79796sbmr2wr1bw294r2marlcp";
  jarDest = "maven/jline/jline/2.14.6/jline-2.14.6.jar";
  metaUrl = "https://repo1.maven.org/maven2/jline/jline/2.14.6/jline-2.14.6.pom";
  metaSha256 = "10p9lj1n9fiq89sz1g9jiifrqf4ydad6afxrsrla50gvipqbdxqx";
  metaDest = "maven/jline/jline/2.14.6/jline-2.14.6.pom";
})

(mkBinPackage {
  name = "joda-time_2_9_4";
  pname = "joda-time";
  version = "2.9.4";
  org = "joda-time";
  jarUrl = "https://repo1.maven.org/maven2/joda-time/joda-time/2.9.4/joda-time-2.9.4.jar";
  jarSha256 = "0cyi71jnm3ks3x6qg6d12dr8bmd0msjapn3gpx0gkcyhxbahdvyy";
  jarDest = "maven/joda-time/joda-time/2.9.4/joda-time-2.9.4.jar";
  metaUrl = "https://repo1.maven.org/maven2/joda-time/joda-time/2.9.4/joda-time-2.9.4.pom";
  metaSha256 = "10ahadp4pzf52bp8h4rcm31yvlvbicgbcils7d854hqr1xi0ayb9";
  metaDest = "maven/joda-time/joda-time/2.9.4/joda-time-2.9.4.pom";
})

(mkBinPackage {
  name = "junit_4_12";
  pname = "junit";
  version = "4.12";
  org = "junit";
  jarUrl = "https://repo1.maven.org/maven2/junit/junit/4.12/junit-4.12.jar";
  jarSha256 = "0shibkq1faqc7j8cl0n5swscazanzzcqfy37j15xh8z20l41ywjr";
  jarDest = "maven/junit/junit/4.12/junit-4.12.jar";
  metaUrl = "https://repo1.maven.org/maven2/junit/junit/4.12/junit-4.12.pom";
  metaSha256 = "1i29aji7rribs7b8a6ql0xca5vm4xgkyjzfrg8f6zyrzivvn7wch";
  metaDest = "maven/junit/junit/4.12/junit-4.12.pom";
})

(mkBinPackage {
  name = "jna_4_5_0";
  pname = "jna";
  version = "4.5.0";
  org = "net.java.dev.jna";
  jarUrl = "https://repo1.maven.org/maven2/net/java/dev/jna/jna/4.5.0/jna-4.5.0.jar";
  jarSha256 = "151yv93d0zi424i3avikch4jzxqhkylm8dm1ami2jmvayrsqsyk1";
  jarDest = "maven/net/java/dev/jna/jna/4.5.0/jna-4.5.0.jar";
  metaUrl = "https://repo1.maven.org/maven2/net/java/dev/jna/jna/4.5.0/jna-4.5.0.pom";
  metaSha256 = "0j1hxd329bvxgg78ywlp205ljvqwcg88a311yslls8dpwsbph2dg";
  metaDest = "maven/net/java/dev/jna/jna/4.5.0/jna-4.5.0.pom";
})

(mkBinPackage {
  name = "jna-platform_4_5_0";
  pname = "jna-platform";
  version = "4.5.0";
  org = "net.java.dev.jna";
  jarUrl = "https://repo1.maven.org/maven2/net/java/dev/jna/jna-platform/4.5.0/jna-platform-4.5.0.jar";
  jarSha256 = "023alykgf1iyk147izi7b7n0vspfdg2jf9mavr4dlzf0qqqn9vk8";
  jarDest = "maven/net/java/dev/jna/jna-platform/4.5.0/jna-platform-4.5.0.jar";
  metaUrl = "https://repo1.maven.org/maven2/net/java/dev/jna/jna-platform/4.5.0/jna-platform-4.5.0.pom";
  metaSha256 = "1w097jcp55jwrqllk1g1ap1cwjll5h0r6qnwbhn2lna04yjspxkc";
  metaDest = "maven/net/java/dev/jna/jna-platform/4.5.0/jna-platform-4.5.0.pom";
})

(mkBinPackage {
  name = "moultingyaml_2_12_0_4_0";
  pname = "moultingyaml_2.12";
  version = "0.4.0";
  org = "net.jcazevedo";
  jarUrl = "https://repo1.maven.org/maven2/net/jcazevedo/moultingyaml_2.12/0.4.0/moultingyaml_2.12-0.4.0.jar";
  jarSha256 = "1zg9z799pd9hs32x3f2190h58ldpdy6mj9xyma02wia6vb38x4b9";
  jarDest = "maven/net/jcazevedo/moultingyaml_2.12/0.4.0/moultingyaml_2.12-0.4.0.jar";
  metaUrl = "https://repo1.maven.org/maven2/net/jcazevedo/moultingyaml_2.12/0.4.0/moultingyaml_2.12-0.4.0.pom";
  metaSha256 = "1jblxzkhf3y9s0xyqr34x49mgyvbwc8inpzwdfjdfcb8m13pbli6";
  metaDest = "maven/net/jcazevedo/moultingyaml_2.12/0.4.0/moultingyaml_2.12-0.4.0.pom";
})

(mkBinPackage {
  name = "org_abego_treelayout_core_1_0_3";
  pname = "org.abego.treelayout.core";
  version = "1.0.3";
  org = "org.abego.treelayout";
  jarUrl = "https://repo1.maven.org/maven2/org/abego/treelayout/org.abego.treelayout.core/1.0.3/org.abego.treelayout.core-1.0.3.jar";
  jarSha256 = "09ikp5pwpclf0cvbshgsn83id4v043vq23yadbafghirbhwk2pps";
  jarDest = "maven/org/abego/treelayout/org.abego.treelayout.core/1.0.3/org.abego.treelayout.core-1.0.3.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/abego/treelayout/org.abego.treelayout.core/1.0.3/org.abego.treelayout.core-1.0.3.pom";
  metaSha256 = "032arsdc1nw4mnn2pgii0dy6d4y95w0sycr4g5g3aw23g4iv5cm3";
  metaDest = "maven/org/abego/treelayout/org.abego.treelayout.core/1.0.3/org.abego.treelayout.core-1.0.3.pom";
})

(mkBinPackage {
  name = "antlr4_4_7_1";
  pname = "antlr4";
  version = "4.7.1";
  org = "org.antlr";
  jarUrl = "https://repo1.maven.org/maven2/org/antlr/antlr4/4.7.1/antlr4-4.7.1.jar";
  jarSha256 = "11qd1ak24wdra5pbdczdjla5msw0s1adqs15hcl3g2gbz3rc5kd2";
  jarDest = "maven/org/antlr/antlr4/4.7.1/antlr4-4.7.1.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/antlr/antlr4/4.7.1/antlr4-4.7.1.pom";
  metaSha256 = "15j7d2fcms56vmmxcvjgpx0m90pcivwwisg90sniwhq7kigj9q4k";
  metaDest = "maven/org/antlr/antlr4/4.7.1/antlr4-4.7.1.pom";
})

(mkBinPackage {
  name = "antlr4-runtime_4_7_1";
  pname = "antlr4-runtime";
  version = "4.7.1";
  org = "org.antlr";
  jarUrl = "https://repo1.maven.org/maven2/org/antlr/antlr4-runtime/4.7.1/antlr4-runtime-4.7.1.jar";
  jarSha256 = "07f91mjclacrvkl8a307w2abq5wcqp0gcsnh0jg90ddfpqcnsla3";
  jarDest = "maven/org/antlr/antlr4-runtime/4.7.1/antlr4-runtime-4.7.1.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/antlr/antlr4-runtime/4.7.1/antlr4-runtime-4.7.1.pom";
  metaSha256 = "14gzb4mdyv6qrl0mj4lsvbzn24pi88fj5daqlavjql8fp6hqc4yf";
  metaDest = "maven/org/antlr/antlr4-runtime/4.7.1/antlr4-runtime-4.7.1.pom";
})

(mkBinPackage {
  name = "antlr-runtime_3_5_2";
  pname = "antlr-runtime";
  version = "3.5.2";
  org = "org.antlr";
  jarUrl = "https://repo1.maven.org/maven2/org/antlr/antlr-runtime/3.5.2/antlr-runtime-3.5.2.jar";
  jarSha256 = "0d47khwbkhvkzvk1h7hb7p6xjwnja3ijrfywrniyjf8gn7nchgyf";
  jarDest = "maven/org/antlr/antlr-runtime/3.5.2/antlr-runtime-3.5.2.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/antlr/antlr-runtime/3.5.2/antlr-runtime-3.5.2.pom";
  metaSha256 = "09bzm8h181dj9jh53j19hf89k47lgw4sb9sa2bbjpcdq1chc5aa6";
  metaDest = "maven/org/antlr/antlr-runtime/3.5.2/antlr-runtime-3.5.2.pom";
})

(mkBinPackage {
  name = "ST4_4_0_8";
  pname = "ST4";
  version = "4.0.8";
  org = "org.antlr";
  jarUrl = "https://repo1.maven.org/maven2/org/antlr/ST4/4.0.8/ST4-4.0.8.jar";
  jarSha256 = "0fvszknribdgm98s5rllj1sw0l2ayvh6in1zk6sv0x4z1k2apjjq";
  jarDest = "maven/org/antlr/ST4/4.0.8/ST4-4.0.8.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/antlr/ST4/4.0.8/ST4-4.0.8.pom";
  metaSha256 = "0z610q9vn39vf408p0110imzy08r6jgcl16llcxynx0iqzg9021w";
  metaDest = "maven/org/antlr/ST4/4.0.8/ST4-4.0.8.pom";
})

(mkBinPackage {
  name = "stringtemplate_3_2_1";
  pname = "stringtemplate";
  version = "3.2.1";
  org = "org.antlr";
  jarUrl = "https://repo1.maven.org/maven2/org/antlr/stringtemplate/3.2.1/stringtemplate-3.2.1.jar";
  jarSha256 = "1mzndmmc005zvcqgrjxkj7mnzmvapb9583h21z5h2lsyjqpffv7n";
  jarDest = "maven/org/antlr/stringtemplate/3.2.1/stringtemplate-3.2.1.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/antlr/stringtemplate/3.2.1/stringtemplate-3.2.1.pom";
  metaSha256 = "05kaq4iminqjx9d4pqimbcrmdc96ahsf8hrss4rqz955b9jq4pml";
  metaDest = "maven/org/antlr/stringtemplate/3.2.1/stringtemplate-3.2.1.pom";
})

(mkBinPackage {
  name = "ant_1_9_9";
  pname = "ant";
  version = "1.9.9";
  org = "org.apache.ant";
  jarUrl = "https://repo1.maven.org/maven2/org/apache/ant/ant/1.9.9/ant-1.9.9.jar";
  jarSha256 = "06wa1c59mnnxr0aj9840cdrs239lyd880hfd2vmcjw71nay584nq";
  jarDest = "maven/org/apache/ant/ant/1.9.9/ant-1.9.9.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/apache/ant/ant/1.9.9/ant-1.9.9.pom";
  metaSha256 = "140mzvg3plhscsb5s8n13parwmikh746lm9dbcx48fgk13fnz248";
  metaDest = "maven/org/apache/ant/ant/1.9.9/ant-1.9.9.pom";
})

(mkBinPackage {
  name = "ant-launcher_1_9_9";
  pname = "ant-launcher";
  version = "1.9.9";
  org = "org.apache.ant";
  jarUrl = "https://repo1.maven.org/maven2/org/apache/ant/ant-launcher/1.9.9/ant-launcher-1.9.9.jar";
  jarSha256 = "0i20iysclny7nyv6298g40qc9dy7dnhliymcb6qcljpcrq8f1jq2";
  jarDest = "maven/org/apache/ant/ant-launcher/1.9.9/ant-launcher-1.9.9.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/apache/ant/ant-launcher/1.9.9/ant-launcher-1.9.9.pom";
  metaSha256 = "1xn3rgcwb3qcchwg19ysc9isj2swc7ccb8h20hr00cr5vdwhj71p";
  metaDest = "maven/org/apache/ant/ant-launcher/1.9.9/ant-launcher-1.9.9.pom";
})

(mkBinPackage {
  name = "commons-compress_1_9";
  pname = "commons-compress";
  version = "1.9";
  org = "org.apache.commons";
  jarUrl = "https://repo1.maven.org/maven2/org/apache/commons/commons-compress/1.9/commons-compress-1.9.jar";
  jarSha256 = "1qmqvkrfwdr3h5wi1b7yyh0a56kvgllbj14z9lmrld9301qa3q5q";
  jarDest = "maven/org/apache/commons/commons-compress/1.9/commons-compress-1.9.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/apache/commons/commons-compress/1.9/commons-compress-1.9.pom";
  metaSha256 = "1k15i3gp13ph9h4lzairrkn9rc25w75klamfmrp9fi3cgpnmblbs";
  metaDest = "maven/org/apache/commons/commons-compress/1.9/commons-compress-1.9.pom";
})

(mkBinPackage {
  name = "commons-lang3_3_1";
  pname = "commons-lang3";
  version = "3.1";
  org = "org.apache.commons";
  jarUrl = "https://repo1.maven.org/maven2/org/apache/commons/commons-lang3/3.1/commons-lang3-3.1.jar";
  jarSha256 = "0rn1mzsx84dpznigj1vj59czbg1l11zgsjq2rx3jwq74m0cha7qk";
  jarDest = "maven/org/apache/commons/commons-lang3/3.1/commons-lang3-3.1.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/apache/commons/commons-lang3/3.1/commons-lang3-3.1.pom";
  metaSha256 = "1lnykx8bbi7syzri8f2kh9n82njdb2fjir60q1jsyc7nhf6vffh4";
  metaDest = "maven/org/apache/commons/commons-lang3/3.1/commons-lang3-3.1.pom";
})

(mkBinPackage {
  name = "commons-lang3_3_4";
  pname = "commons-lang3";
  version = "3.4";
  org = "org.apache.commons";
  jarUrl = "https://repo1.maven.org/maven2/org/apache/commons/commons-lang3/3.4/commons-lang3-3.4.jar";
  jarSha256 = "12yrqvxmhl9c4v1jqailj2fyli2xrlgzsr2xg46f7j0c89b86k3k";
  jarDest = "maven/org/apache/commons/commons-lang3/3.4/commons-lang3-3.4.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/apache/commons/commons-lang3/3.4/commons-lang3-3.4.pom";
  metaSha256 = "1l9zsw34pf978nn0w1b7ci2kxvg2cjilfxisshqi0g51c6spavk8";
  metaDest = "maven/org/apache/commons/commons-lang3/3.4/commons-lang3-3.4.pom";
})

(mkBinPackage {
  name = "commons-lang3_3_8_1";
  pname = "commons-lang3";
  version = "3.8.1";
  org = "org.apache.commons";
  jarUrl = "https://repo1.maven.org/maven2/org/apache/commons/commons-lang3/3.8.1/commons-lang3-3.8.1.jar";
  jarSha256 = "0s3gc4qsich2pjigifwidpa3zbl77ppvy1qvkgrqys87bgv0gj6s";
  jarDest = "maven/org/apache/commons/commons-lang3/3.8.1/commons-lang3-3.8.1.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/apache/commons/commons-lang3/3.8.1/commons-lang3-3.8.1.pom";
  metaSha256 = "1maq8jhbwy5j4yia0i6zfryfc8inrir7i78dpl2m4s0iakvhk3pc";
  metaDest = "maven/org/apache/commons/commons-lang3/3.8.1/commons-lang3-3.8.1.pom";
})

(mkBinPackage {
  name = "commons-text_1_6";
  pname = "commons-text";
  version = "1.6";
  org = "org.apache.commons";
  jarUrl = "https://repo1.maven.org/maven2/org/apache/commons/commons-text/1.6/commons-text-1.6.jar";
  jarSha256 = "02x702m3yzy1wyc09xms13q8p3qmri1rsg4m2vkhygmn95jyaifz";
  jarDest = "maven/org/apache/commons/commons-text/1.6/commons-text-1.6.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/apache/commons/commons-text/1.6/commons-text-1.6.pom";
  metaSha256 = "19kj7rb31zgr1fdbbzv0ykzidmjprnix5ncipdsx2r79fvhdygpw";
  metaDest = "maven/org/apache/commons/commons-text/1.6/commons-text-1.6.pom";
})

(mkBinPackage {
  name = "httpclient_4_3_6";
  pname = "httpclient";
  version = "4.3.6";
  org = "org.apache.httpcomponents";
  jarUrl = "https://repo1.maven.org/maven2/org/apache/httpcomponents/httpclient/4.3.6/httpclient-4.3.6.jar";
  jarSha256 = "0120f7j67528ba0sxcqa1xclnb9s1j1q19335j2lyggpmsg8v0vr";
  jarDest = "maven/org/apache/httpcomponents/httpclient/4.3.6/httpclient-4.3.6.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/apache/httpcomponents/httpclient/4.3.6/httpclient-4.3.6.pom";
  metaSha256 = "1hv43fdxifiv4aywa9kyn822gixs3rqkda1aq1hlk48y2gv389nh";
  metaDest = "maven/org/apache/httpcomponents/httpclient/4.3.6/httpclient-4.3.6.pom";
})

(mkBinPackage {
  name = "httpcore_4_3_3";
  pname = "httpcore";
  version = "4.3.3";
  org = "org.apache.httpcomponents";
  jarUrl = "https://repo1.maven.org/maven2/org/apache/httpcomponents/httpcore/4.3.3/httpcore-4.3.3.jar";
  jarSha256 = "14sska31d382ripp3pivdg5wv9351ksak49v664w8l8nmy0dx1aj";
  jarDest = "maven/org/apache/httpcomponents/httpcore/4.3.3/httpcore-4.3.3.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/apache/httpcomponents/httpcore/4.3.3/httpcore-4.3.3.pom";
  metaSha256 = "0r0jgbqwxyngmpy7iisy2hy5f0skyidx6211kqzlwnn7cz7zf9xl";
  metaDest = "maven/org/apache/httpcomponents/httpcore/4.3.3/httpcore-4.3.3.pom";
})

(mkBinPackage {
  name = "log4j-api_2_11_1";
  pname = "log4j-api";
  version = "2.11.1";
  org = "org.apache.logging.log4j";
  jarUrl = "https://repo1.maven.org/maven2/org/apache/logging/log4j/log4j-api/2.11.1/log4j-api-2.11.1.jar";
  jarSha256 = "0avls1hyiiqxra27an1nyhypihadbqvndf89nrglz764lsskffs9";
  jarDest = "maven/org/apache/logging/log4j/log4j-api/2.11.1/log4j-api-2.11.1.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/apache/logging/log4j/log4j-api/2.11.1/log4j-api-2.11.1.pom";
  metaSha256 = "1ka88y25bn0cpic5xfabfx7jjb5asyhfazzpv4qjsazr9hby6viy";
  metaDest = "maven/org/apache/logging/log4j/log4j-api/2.11.1/log4j-api-2.11.1.pom";
})

(mkBinPackage {
  name = "log4j-api_2_8_1";
  pname = "log4j-api";
  version = "2.8.1";
  org = "org.apache.logging.log4j";
  jarUrl = "https://repo1.maven.org/maven2/org/apache/logging/log4j/log4j-api/2.8.1/log4j-api-2.8.1.jar";
  jarSha256 = "18hza4bf33kl8w4pjdfpyfdmj516w6ja9flrdpczf9hk9dvan18j";
  jarDest = "maven/org/apache/logging/log4j/log4j-api/2.8.1/log4j-api-2.8.1.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/apache/logging/log4j/log4j-api/2.8.1/log4j-api-2.8.1.pom";
  metaSha256 = "151d3lpzgxi1mb69ni4mh8vihl3vx8fm2gmq4c3n4b5x3735k2dg";
  metaDest = "maven/org/apache/logging/log4j/log4j-api/2.8.1/log4j-api-2.8.1.pom";
})

(mkBinPackage {
  name = "log4j-core_2_11_1";
  pname = "log4j-core";
  version = "2.11.1";
  org = "org.apache.logging.log4j";
  jarUrl = "https://repo1.maven.org/maven2/org/apache/logging/log4j/log4j-core/2.11.1/log4j-core-2.11.1.jar";
  jarSha256 = "1v32f784bjrvg7sx62vagj0bs02nx5kdpl69zipbfy29mk6k8352";
  jarDest = "maven/org/apache/logging/log4j/log4j-core/2.11.1/log4j-core-2.11.1.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/apache/logging/log4j/log4j-core/2.11.1/log4j-core-2.11.1.pom";
  metaSha256 = "0qmmmzq0w0i2hjgmbszlz8ykn2r33nyzy4sl58rsap95vl2n86wp";
  metaDest = "maven/org/apache/logging/log4j/log4j-core/2.11.1/log4j-core-2.11.1.pom";
})

(mkBinPackage {
  name = "log4j-core_2_8_1";
  pname = "log4j-core";
  version = "2.8.1";
  org = "org.apache.logging.log4j";
  jarUrl = "https://repo1.maven.org/maven2/org/apache/logging/log4j/log4j-core/2.8.1/log4j-core-2.8.1.jar";
  jarSha256 = "0vk1cklax9g1f1hdgp1yfbaz6kb82i25ks7g5rk1794h1vi76nl1";
  jarDest = "maven/org/apache/logging/log4j/log4j-core/2.8.1/log4j-core-2.8.1.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/apache/logging/log4j/log4j-core/2.8.1/log4j-core-2.8.1.pom";
  metaSha256 = "0licp0vrgin12c44r96zhnfr07lg2c9s36dcj8iq3yw0kfhz7yvf";
  metaDest = "maven/org/apache/logging/log4j/log4j-core/2.8.1/log4j-core-2.8.1.pom";
})

(mkBinPackage {
  name = "log4j-slf4j-impl_2_11_1";
  pname = "log4j-slf4j-impl";
  version = "2.11.1";
  org = "org.apache.logging.log4j";
  jarUrl = "https://repo1.maven.org/maven2/org/apache/logging/log4j/log4j-slf4j-impl/2.11.1/log4j-slf4j-impl-2.11.1.jar";
  jarSha256 = "1rcsrraprjf5drxdj47jg868qb1d2kk2i16s6q063kpx3ni3r991";
  jarDest = "maven/org/apache/logging/log4j/log4j-slf4j-impl/2.11.1/log4j-slf4j-impl-2.11.1.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/apache/logging/log4j/log4j-slf4j-impl/2.11.1/log4j-slf4j-impl-2.11.1.pom";
  metaSha256 = "1qfcf52c9cpcr1yjlb3mzrw6pa3k68557x8dryvh94pp3pdb1bai";
  metaDest = "maven/org/apache/logging/log4j/log4j-slf4j-impl/2.11.1/log4j-slf4j-impl-2.11.1.pom";
})

(mkBinPackage {
  name = "log4j-slf4j-impl_2_8_1";
  pname = "log4j-slf4j-impl";
  version = "2.8.1";
  org = "org.apache.logging.log4j";
  jarUrl = "https://repo1.maven.org/maven2/org/apache/logging/log4j/log4j-slf4j-impl/2.8.1/log4j-slf4j-impl-2.8.1.jar";
  jarSha256 = "1dmkggbf6w1gii4v0vwh3i1r874l2y048agsaijpk4hmgfxjbws3";
  jarDest = "maven/org/apache/logging/log4j/log4j-slf4j-impl/2.8.1/log4j-slf4j-impl-2.8.1.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/apache/logging/log4j/log4j-slf4j-impl/2.8.1/log4j-slf4j-impl-2.8.1.pom";
  metaSha256 = "0dcpn6jgb4xxacnlxc1ix7dsmn0p9wcl597vq71mmc937q45x8x8";
  metaDest = "maven/org/apache/logging/log4j/log4j-slf4j-impl/2.8.1/log4j-slf4j-impl-2.8.1.pom";
})

(mkBinPackage {
  name = "maven-artifact_3_3_9";
  pname = "maven-artifact";
  version = "3.3.9";
  org = "org.apache.maven";
  jarUrl = "https://repo1.maven.org/maven2/org/apache/maven/maven-artifact/3.3.9/maven-artifact-3.3.9.jar";
  jarSha256 = "0pa4qklvf3ab6v4d70r10v3qg8ifjgrdiyq8yg6nwg13y8l2jw0z";
  jarDest = "maven/org/apache/maven/maven-artifact/3.3.9/maven-artifact-3.3.9.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/apache/maven/maven-artifact/3.3.9/maven-artifact-3.3.9.pom";
  metaSha256 = "05a455s964ayh59a0swvmyh7ifi4i2x0m8y5r8px7q92yz62kwiy";
  metaDest = "maven/org/apache/maven/maven-artifact/3.3.9/maven-artifact-3.3.9.pom";
})

(mkBinPackage {
  name = "maven-model_3_3_9";
  pname = "maven-model";
  version = "3.3.9";
  org = "org.apache.maven";
  jarUrl = "https://repo1.maven.org/maven2/org/apache/maven/maven-model/3.3.9/maven-model-3.3.9.jar";
  jarSha256 = "1kgg23sqys4hcywizbqs6mqhjpwr3s93937nw5ryb8byz9kxxaqm";
  jarDest = "maven/org/apache/maven/maven-model/3.3.9/maven-model-3.3.9.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/apache/maven/maven-model/3.3.9/maven-model-3.3.9.pom";
  metaSha256 = "0bs1nzmy9h2bmxl3j9rg4bbydwp4dfpx9294fd7z49cz2pd8k8lv";
  metaDest = "maven/org/apache/maven/maven-model/3.3.9/maven-model-3.3.9.pom";
})

(mkBinPackage {
  name = "maven-plugin-api_3_3_9";
  pname = "maven-plugin-api";
  version = "3.3.9";
  org = "org.apache.maven";
  jarUrl = "https://repo1.maven.org/maven2/org/apache/maven/maven-plugin-api/3.3.9/maven-plugin-api-3.3.9.jar";
  jarSha256 = "171cxxacginbixpdv6fkvd1vvnbal87f65695yqh2n8jsy7y3jhl";
  jarDest = "maven/org/apache/maven/maven-plugin-api/3.3.9/maven-plugin-api-3.3.9.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/apache/maven/maven-plugin-api/3.3.9/maven-plugin-api-3.3.9.pom";
  metaSha256 = "1ffkflf641kqml45cm14q2mym4ha6mmsyvvmpkr5i58nm7xx245b";
  metaDest = "maven/org/apache/maven/maven-plugin-api/3.3.9/maven-plugin-api-3.3.9.pom";
})

(mkBinPackage {
  name = "asciidoctorj_1_5_4";
  pname = "asciidoctorj";
  version = "1.5.4";
  org = "org.asciidoctor";
  jarUrl = "https://repo1.maven.org/maven2/org/asciidoctor/asciidoctorj/1.5.4/asciidoctorj-1.5.4.jar";
  jarSha256 = "117rlr3nfk08x1w3gbh3g3qq1i835sj61akv3543v72acgray8wl";
  jarDest = "maven/org/asciidoctor/asciidoctorj/1.5.4/asciidoctorj-1.5.4.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/asciidoctor/asciidoctorj/1.5.4/asciidoctorj-1.5.4.pom";
  metaSha256 = "01w11qhd2f10z2vj8i95lbnxg5af7fz6r06khxp2afqv98kajb3j";
  metaDest = "maven/org/asciidoctor/asciidoctorj/1.5.4/asciidoctorj-1.5.4.pom";
})

(mkBinPackage {
  name = "plexus-classworlds_2_5_2";
  pname = "plexus-classworlds";
  version = "2.5.2";
  org = "org.codehaus.plexus";
  jarUrl = "https://repo1.maven.org/maven2/org/codehaus/plexus/plexus-classworlds/2.5.2/plexus-classworlds-2.5.2.jar";
  jarSha256 = "1mwz9i9pybsjaagnfvk0r9nbdpi0mklwzq6b67csi404fi0iv4xj";
  jarDest = "maven/org/codehaus/plexus/plexus-classworlds/2.5.2/plexus-classworlds-2.5.2.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/codehaus/plexus/plexus-classworlds/2.5.2/plexus-classworlds-2.5.2.pom";
  metaSha256 = "09crca1r3caaj85xim9cd8kl437nwc1ld6y3jjhfzghmp2bii0c9";
  metaDest = "maven/org/codehaus/plexus/plexus-classworlds/2.5.2/plexus-classworlds-2.5.2.pom";
})

(mkBinPackage {
  name = "plexus-component-annotations_1_5_5";
  pname = "plexus-component-annotations";
  version = "1.5.5";
  org = "org.codehaus.plexus";
  jarUrl = "https://repo1.maven.org/maven2/org/codehaus/plexus/plexus-component-annotations/1.5.5/plexus-component-annotations-1.5.5.jar";
  jarSha256 = "07yazisy7p9mf7k4lrr23m1a77kzd4aw3db0ryy5pcv4psksdxsd";
  jarDest = "maven/org/codehaus/plexus/plexus-component-annotations/1.5.5/plexus-component-annotations-1.5.5.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/codehaus/plexus/plexus-component-annotations/1.5.5/plexus-component-annotations-1.5.5.pom";
  metaSha256 = "14p2sx90qwpy59p6m3qfg1yy0lgvkc0g9zc52dqgmidq2v1kwpw1";
  metaDest = "maven/org/codehaus/plexus/plexus-component-annotations/1.5.5/plexus-component-annotations-1.5.5.pom";
})

(mkBinPackage {
  name = "plexus-utils_3_0_22";
  pname = "plexus-utils";
  version = "3.0.22";
  org = "org.codehaus.plexus";
  jarUrl = "https://repo1.maven.org/maven2/org/codehaus/plexus/plexus-utils/3.0.22/plexus-utils-3.0.22.jar";
  jarSha256 = "1axy8v83lkdkd3ic91yg8jrjm7ivs2bcx0m58rnyb1sz4x5w8c8g";
  jarDest = "maven/org/codehaus/plexus/plexus-utils/3.0.22/plexus-utils-3.0.22.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/codehaus/plexus/plexus-utils/3.0.22/plexus-utils-3.0.22.pom";
  metaSha256 = "0mrg0ph232ldfi139m17hsdni5fpaai5h74s8zmbzsy2m4cv43gj";
  metaDest = "maven/org/codehaus/plexus/plexus-utils/3.0.22/plexus-utils-3.0.22.pom";
})

(mkBinPackage {
  name = "jetty-http_9_2_21_v20170120";
  pname = "jetty-http";
  version = "9.2.21.v20170120";
  org = "org.eclipse.jetty";
  jarUrl = "https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-http/9.2.21.v20170120/jetty-http-9.2.21.v20170120.jar";
  jarSha256 = "025nmz8fqcfzwk9v5jjz5513xfn55r3wcyr6l8fzixw98wk9lvda";
  jarDest = "maven/org/eclipse/jetty/jetty-http/9.2.21.v20170120/jetty-http-9.2.21.v20170120.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-http/9.2.21.v20170120/jetty-http-9.2.21.v20170120.pom";
  metaSha256 = "0wnnh1crlmk1nkn8bphzk0zd9dir2lgyl5r2kw0ylfb70py0yh79";
  metaDest = "maven/org/eclipse/jetty/jetty-http/9.2.21.v20170120/jetty-http-9.2.21.v20170120.pom";
})

(mkBinPackage {
  name = "jetty-io_9_2_21_v20170120";
  pname = "jetty-io";
  version = "9.2.21.v20170120";
  org = "org.eclipse.jetty";
  jarUrl = "https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-io/9.2.21.v20170120/jetty-io-9.2.21.v20170120.jar";
  jarSha256 = "1sms1raap22iiriyl44k5idwh0z7kfmzv9fcc7bsc3lyjrhd0xl8";
  jarDest = "maven/org/eclipse/jetty/jetty-io/9.2.21.v20170120/jetty-io-9.2.21.v20170120.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-io/9.2.21.v20170120/jetty-io-9.2.21.v20170120.pom";
  metaSha256 = "1hihm2g82h9018j1qmpg31dyg0a6nsg7wy1ribsdnyrwx17jzy4h";
  metaDest = "maven/org/eclipse/jetty/jetty-io/9.2.21.v20170120/jetty-io-9.2.21.v20170120.pom";
})

(mkBinPackage {
  name = "jetty-security_9_2_21_v20170120";
  pname = "jetty-security";
  version = "9.2.21.v20170120";
  org = "org.eclipse.jetty";
  jarUrl = "https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-security/9.2.21.v20170120/jetty-security-9.2.21.v20170120.jar";
  jarSha256 = "0grzqbfqziscai1r3qzjh0071rmvrawi867hcb5n047546vpnz9r";
  jarDest = "maven/org/eclipse/jetty/jetty-security/9.2.21.v20170120/jetty-security-9.2.21.v20170120.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-security/9.2.21.v20170120/jetty-security-9.2.21.v20170120.pom";
  metaSha256 = "0ssq05rkq9mmylx28m6bfgkvdzzxxx5bcr8k4ladrmmaixy6s8lv";
  metaDest = "maven/org/eclipse/jetty/jetty-security/9.2.21.v20170120/jetty-security-9.2.21.v20170120.pom";
})

(mkBinPackage {
  name = "jetty-server_9_2_21_v20170120";
  pname = "jetty-server";
  version = "9.2.21.v20170120";
  org = "org.eclipse.jetty";
  jarUrl = "https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-server/9.2.21.v20170120/jetty-server-9.2.21.v20170120.jar";
  jarSha256 = "0zpssn7skfvh9ccvs0k1084aiwl0h3qfd2pw63ypsghkfbgpnzxl";
  jarDest = "maven/org/eclipse/jetty/jetty-server/9.2.21.v20170120/jetty-server-9.2.21.v20170120.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-server/9.2.21.v20170120/jetty-server-9.2.21.v20170120.pom";
  metaSha256 = "0vxhphywknybl8arxa3fcfzdba59g1ka9112rs43chlqmy894svn";
  metaDest = "maven/org/eclipse/jetty/jetty-server/9.2.21.v20170120/jetty-server-9.2.21.v20170120.pom";
})

(mkBinPackage {
  name = "jetty-servlet_9_2_21_v20170120";
  pname = "jetty-servlet";
  version = "9.2.21.v20170120";
  org = "org.eclipse.jetty";
  jarUrl = "https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-servlet/9.2.21.v20170120/jetty-servlet-9.2.21.v20170120.jar";
  jarSha256 = "1mpgdr9b0qxg3lm8sl57y6gyhyc13ddv2hahvgv6ka13lazghaj6";
  jarDest = "maven/org/eclipse/jetty/jetty-servlet/9.2.21.v20170120/jetty-servlet-9.2.21.v20170120.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-servlet/9.2.21.v20170120/jetty-servlet-9.2.21.v20170120.pom";
  metaSha256 = "0wyz5fp80g24k7m8cs0n0j0mk8rkjrsrpnh34awic29ahhmkq1dh";
  metaDest = "maven/org/eclipse/jetty/jetty-servlet/9.2.21.v20170120/jetty-servlet-9.2.21.v20170120.pom";
})

(mkBinPackage {
  name = "jetty-util_9_2_21_v20170120";
  pname = "jetty-util";
  version = "9.2.21.v20170120";
  org = "org.eclipse.jetty";
  jarUrl = "https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-util/9.2.21.v20170120/jetty-util-9.2.21.v20170120.jar";
  jarSha256 = "1ab4qmzhy78sdfa9sldhvwhl2z978zbwpw5ii4gfknwqbq12h8ql";
  jarDest = "maven/org/eclipse/jetty/jetty-util/9.2.21.v20170120/jetty-util-9.2.21.v20170120.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-util/9.2.21.v20170120/jetty-util-9.2.21.v20170120.pom";
  metaSha256 = "1fclssaxz7xqlw55ff9hm76m80cd9igvca976p2zj65xfaad7a9n";
  metaDest = "maven/org/eclipse/jetty/jetty-util/9.2.21.v20170120/jetty-util-9.2.21.v20170120.pom";
})

(mkBinPackage {
  name = "jetty-webapp_9_2_21_v20170120";
  pname = "jetty-webapp";
  version = "9.2.21.v20170120";
  org = "org.eclipse.jetty";
  jarUrl = "https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-webapp/9.2.21.v20170120/jetty-webapp-9.2.21.v20170120.jar";
  jarSha256 = "157lkwb7jw7cfsnhkxwnpmjhbbxirmg2kg3as48plqfqz24xa4s7";
  jarDest = "maven/org/eclipse/jetty/jetty-webapp/9.2.21.v20170120/jetty-webapp-9.2.21.v20170120.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-webapp/9.2.21.v20170120/jetty-webapp-9.2.21.v20170120.pom";
  metaSha256 = "154f838c72i4m97vc7jls0xqy090znkpl0rkj42wcy194qan0gfg";
  metaDest = "maven/org/eclipse/jetty/jetty-webapp/9.2.21.v20170120/jetty-webapp-9.2.21.v20170120.pom";
})

(mkBinPackage {
  name = "jetty-xml_9_2_21_v20170120";
  pname = "jetty-xml";
  version = "9.2.21.v20170120";
  org = "org.eclipse.jetty";
  jarUrl = "https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-xml/9.2.21.v20170120/jetty-xml-9.2.21.v20170120.jar";
  jarSha256 = "0vhbnw4lzi05yd3b5iq7lpcwagw8bgm2n57sapjiz83r71ncy3zp";
  jarDest = "maven/org/eclipse/jetty/jetty-xml/9.2.21.v20170120/jetty-xml-9.2.21.v20170120.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-xml/9.2.21.v20170120/jetty-xml-9.2.21.v20170120.pom";
  metaSha256 = "1iqy10z17mcppxdfa01pwc4fgsydncq5lr55grfs6g479g3b2pc9";
  metaDest = "maven/org/eclipse/jetty/jetty-xml/9.2.21.v20170120/jetty-xml-9.2.21.v20170120.pom";
})

(mkBinPackage {
  name = "org_eclipse_jgit_4_5_0_201609210915-r";
  pname = "org.eclipse.jgit";
  version = "4.5.0.201609210915-r";
  org = "org.eclipse.jgit";
  jarUrl = "https://repo1.maven.org/maven2/org/eclipse/jgit/org.eclipse.jgit/4.5.0.201609210915-r/org.eclipse.jgit-4.5.0.201609210915-r.jar";
  jarSha256 = "1r6fys1n74id3y5v603iwhlmwhwqganf4dyn2yfd0b8633r9nwz6";
  jarDest = "maven/org/eclipse/jgit/org.eclipse.jgit/4.5.0.201609210915-r/org.eclipse.jgit-4.5.0.201609210915-r.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/eclipse/jgit/org.eclipse.jgit/4.5.0.201609210915-r/org.eclipse.jgit-4.5.0.201609210915-r.pom";
  metaSha256 = "103qfnwibld9d4c5hgvw46rxw50gpbxkl2a9mqlcff5hk6w3vzij";
  metaDest = "maven/org/eclipse/jgit/org.eclipse.jgit/4.5.0.201609210915-r/org.eclipse.jgit-4.5.0.201609210915-r.pom";
})

(mkBinPackage {
  name = "org_eclipse_sisu_inject_0_3_2";
  pname = "org.eclipse.sisu.inject";
  version = "0.3.2";
  org = "org.eclipse.sisu";
  jarUrl = "https://repo1.maven.org/maven2/org/eclipse/sisu/org.eclipse.sisu.inject/0.3.2/org.eclipse.sisu.inject-0.3.2.jar";
  jarSha256 = "03flfz3bz4crys2sm4jg9dsqgs8x8gyb2yqa13ml9nhqm02pgs36";
  jarDest = "maven/org/eclipse/sisu/org.eclipse.sisu.inject/0.3.2/org.eclipse.sisu.inject-0.3.2.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/eclipse/sisu/org.eclipse.sisu.inject/0.3.2/org.eclipse.sisu.inject-0.3.2.pom";
  metaSha256 = "0g7d7d3p4ij9305bmxpv6gx6pjgs90hn1060jk817cni6f9zslc9";
  metaDest = "maven/org/eclipse/sisu/org.eclipse.sisu.inject/0.3.2/org.eclipse.sisu.inject-0.3.2.pom";
})

(mkBinPackage {
  name = "org_eclipse_sisu_plexus_0_3_2";
  pname = "org.eclipse.sisu.plexus";
  version = "0.3.2";
  org = "org.eclipse.sisu";
  jarUrl = "https://repo1.maven.org/maven2/org/eclipse/sisu/org.eclipse.sisu.plexus/0.3.2/org.eclipse.sisu.plexus-0.3.2.jar";
  jarSha256 = "1cmq7ssc9zaryg1bhsqvvdgyrwnmhr0hxzzcnhfrfxl2ivcf1kzm";
  jarDest = "maven/org/eclipse/sisu/org.eclipse.sisu.plexus/0.3.2/org.eclipse.sisu.plexus-0.3.2.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/eclipse/sisu/org.eclipse.sisu.plexus/0.3.2/org.eclipse.sisu.plexus-0.3.2.pom";
  metaSha256 = "0jjdvrwmn6fng9ig0aclg7q9ji66zvpcaamd55wmzam3svc0kwk3";
  metaDest = "maven/org/eclipse/sisu/org.eclipse.sisu.plexus/0.3.2/org.eclipse.sisu.plexus-0.3.2.pom";
})

(mkBinPackage {
  name = "knockoff_2_12_0_8_6";
  pname = "knockoff_2.12";
  version = "0.8.6";
  org = "org.foundweekends";
  jarUrl = "https://repo1.maven.org/maven2/org/foundweekends/knockoff_2.12/0.8.6/knockoff_2.12-0.8.6.jar";
  jarSha256 = "0sm0d46yrv8pfdgadrrlx66488b6as9g8dhv1f7jmqi6w3mblp4y";
  jarDest = "maven/org/foundweekends/knockoff_2.12/0.8.6/knockoff_2.12-0.8.6.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/foundweekends/knockoff_2.12/0.8.6/knockoff_2.12-0.8.6.pom";
  metaSha256 = "1q87qdfq31hi4g6a9xd24zgmaancr98c2kl5r263w43g513xh1sq";
  metaDest = "maven/org/foundweekends/knockoff_2.12/0.8.6/knockoff_2.12-0.8.6.pom";
})

(mkBinPackage {
  name = "pamflet-knockoff_2_12_0_7_1";
  pname = "pamflet-knockoff_2.12";
  version = "0.7.1";
  org = "org.foundweekends";
  jarUrl = "https://repo1.maven.org/maven2/org/foundweekends/pamflet-knockoff_2.12/0.7.1/pamflet-knockoff_2.12-0.7.1.jar";
  jarSha256 = "1p85hgmf6vnf2n9pbl2brjn632wzrvqnwqgp810fmy1dsnghl375";
  jarDest = "maven/org/foundweekends/pamflet-knockoff_2.12/0.7.1/pamflet-knockoff_2.12-0.7.1.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/foundweekends/pamflet-knockoff_2.12/0.7.1/pamflet-knockoff_2.12-0.7.1.pom";
  metaSha256 = "05xvfr9mj1zibf0sjr10s8yizg4v8i7qk5spgwxdx5vl2rnwi8ws";
  metaDest = "maven/org/foundweekends/pamflet-knockoff_2.12/0.7.1/pamflet-knockoff_2.12-0.7.1.pom";
})

(mkBinPackage {
  name = "pamflet-library_2_12_0_7_1";
  pname = "pamflet-library_2.12";
  version = "0.7.1";
  org = "org.foundweekends";
  jarUrl = "https://repo1.maven.org/maven2/org/foundweekends/pamflet-library_2.12/0.7.1/pamflet-library_2.12-0.7.1.jar";
  jarSha256 = "04vfi0ap0diybwfcvn2hy0skk21fxph3w60qrmm8jphjkdwgf1h2";
  jarDest = "maven/org/foundweekends/pamflet-library_2.12/0.7.1/pamflet-library_2.12-0.7.1.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/foundweekends/pamflet-library_2.12/0.7.1/pamflet-library_2.12-0.7.1.pom";
  metaSha256 = "13w3mqd22yxs12c0777dlx46458dsrwrhjxz8fhrqigz4f4sqxpk";
  metaDest = "maven/org/foundweekends/pamflet-library_2.12/0.7.1/pamflet-library_2.12-0.7.1.pom";
})

(mkBinPackage {
  name = "javax_json_1_0_4";
  pname = "javax.json";
  version = "1.0.4";
  org = "org.glassfish";
  jarUrl = "https://repo1.maven.org/maven2/org/glassfish/javax.json/1.0.4/javax.json-1.0.4.jar";
  jarSha256 = "1d5ypmcq33n4dhqvqy03yp22q1gfmrlakvai2aa6bsgdl50fq78f";
  jarDest = "maven/org/glassfish/javax.json/1.0.4/javax.json-1.0.4.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/glassfish/javax.json/1.0.4/javax.json-1.0.4.pom";
  metaSha256 = "0m1d47123cb4542rib4qpdir9mzjqwggqnydjvm6d2x9zy1q7bvb";
  metaDest = "maven/org/glassfish/javax.json/1.0.4/javax.json-1.0.4.pom";
})

(mkBinPackage {
  name = "hamcrest-core_1_3";
  pname = "hamcrest-core";
  version = "1.3";
  org = "org.hamcrest";
  jarUrl = "https://repo1.maven.org/maven2/org/hamcrest/hamcrest-core/1.3/hamcrest-core-1.3.jar";
  jarSha256 = "1sfqqi8p5957hs9yik44an3lwpv8ln2a6sh9gbgli4vkx68yzzb6";
  jarDest = "maven/org/hamcrest/hamcrest-core/1.3/hamcrest-core-1.3.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/hamcrest/hamcrest-core/1.3/hamcrest-core-1.3.pom";
  metaSha256 = "14zs9yk20z3qjwkjwa1j1q6vb13mf8hbhsny0fqs2wsij2kqdqzx";
  metaDest = "maven/org/hamcrest/hamcrest-core/1.3/hamcrest-core-1.3.pom";
})

(mkBinPackage {
  name = "joda-convert_1_2";
  pname = "joda-convert";
  version = "1.2";
  org = "org.joda";
  jarUrl = "https://repo1.maven.org/maven2/org/joda/joda-convert/1.2/joda-convert-1.2.jar";
  jarSha256 = "1a41bi9x1rl6kham50llv0qvy8k82gqw2xkhz28gws8rmjif20sp";
  jarDest = "maven/org/joda/joda-convert/1.2/joda-convert-1.2.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/joda/joda-convert/1.2/joda-convert-1.2.pom";
  metaSha256 = "1hgxd6gcr132ahiv55fnq1id1girkq4bsq4g6rrjs84sqrqvyzbb";
  metaDest = "maven/org/joda/joda-convert/1.2/joda-convert-1.2.pom";
})

(mkBinPackage {
  name = "jruby-complete_1_7_21";
  pname = "jruby-complete";
  version = "1.7.21";
  org = "org.jruby";
  jarUrl = "https://repo1.maven.org/maven2/org/jruby/jruby-complete/1.7.21/jruby-complete-1.7.21.jar";
  jarSha256 = "0qg725szc96yhzxbszfd81vq2qf70i7wv7gk01bp6ywidm2g1c5n";
  jarDest = "maven/org/jruby/jruby-complete/1.7.21/jruby-complete-1.7.21.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/jruby/jruby-complete/1.7.21/jruby-complete-1.7.21.pom";
  metaSha256 = "1z4mh6x0lmfrii2zm5b4f3qqr4fpl09wsd3566jg9x7j3964lnk3";
  metaDest = "maven/org/jruby/jruby-complete/1.7.21/jruby-complete-1.7.21.pom";
})

(mkBinPackage {
  name = "json4s-ast_2_12_3_5_3";
  pname = "json4s-ast_2.12";
  version = "3.5.3";
  org = "org.json4s";
  jarUrl = "https://repo1.maven.org/maven2/org/json4s/json4s-ast_2.12/3.5.3/json4s-ast_2.12-3.5.3.jar";
  jarSha256 = "0bvh37san3nm6vd19b08alilnny2r5skpr91c4vh076jr8iqisfk";
  jarDest = "maven/org/json4s/json4s-ast_2.12/3.5.3/json4s-ast_2.12-3.5.3.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/json4s/json4s-ast_2.12/3.5.3/json4s-ast_2.12-3.5.3.pom";
  metaSha256 = "0y262vlnxgvrix3cp2v4bwhjzxs9wfllvhbi1hjdi5vnwmfwq3fj";
  metaDest = "maven/org/json4s/json4s-ast_2.12/3.5.3/json4s-ast_2.12-3.5.3.pom";
})

(mkBinPackage {
  name = "json4s-ast_2_12_3_6_1";
  pname = "json4s-ast_2.12";
  version = "3.6.1";
  org = "org.json4s";
  jarUrl = "https://repo1.maven.org/maven2/org/json4s/json4s-ast_2.12/3.6.1/json4s-ast_2.12-3.6.1.jar";
  jarSha256 = "0ikpdxwqss0jva60iil3mxcjxgsvqr76hgaf1kmk53pj3mhdxirr";
  jarDest = "maven/org/json4s/json4s-ast_2.12/3.6.1/json4s-ast_2.12-3.6.1.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/json4s/json4s-ast_2.12/3.6.1/json4s-ast_2.12-3.6.1.pom";
  metaSha256 = "0r90c9pwfwbm8cmzmcm0i42c60fkw7q8hgzw8whm63rrczqkjz4k";
  metaDest = "maven/org/json4s/json4s-ast_2.12/3.6.1/json4s-ast_2.12-3.6.1.pom";
})

(mkBinPackage {
  name = "json4s-core_2_12_3_5_3";
  pname = "json4s-core_2.12";
  version = "3.5.3";
  org = "org.json4s";
  jarUrl = "https://repo1.maven.org/maven2/org/json4s/json4s-core_2.12/3.5.3/json4s-core_2.12-3.5.3.jar";
  jarSha256 = "1qzi9n4g0lq4hv4qs5j1xn9yrz7jzdp2g711jwprry2rlzzrsbgj";
  jarDest = "maven/org/json4s/json4s-core_2.12/3.5.3/json4s-core_2.12-3.5.3.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/json4s/json4s-core_2.12/3.5.3/json4s-core_2.12-3.5.3.pom";
  metaSha256 = "0r6pmlv420qfb1lgpmyfyxwkvrxpihjq4w4kxikdrdrbz5wc9mhn";
  metaDest = "maven/org/json4s/json4s-core_2.12/3.5.3/json4s-core_2.12-3.5.3.pom";
})

(mkBinPackage {
  name = "json4s-core_2_12_3_6_1";
  pname = "json4s-core_2.12";
  version = "3.6.1";
  org = "org.json4s";
  jarUrl = "https://repo1.maven.org/maven2/org/json4s/json4s-core_2.12/3.6.1/json4s-core_2.12-3.6.1.jar";
  jarSha256 = "1h6szj8v5np6fkn8424djy6mxndsczsn9fihbcllx8i9ji883x70";
  jarDest = "maven/org/json4s/json4s-core_2.12/3.6.1/json4s-core_2.12-3.6.1.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/json4s/json4s-core_2.12/3.6.1/json4s-core_2.12-3.6.1.pom";
  metaSha256 = "1p4s95n4fi2a5p01517y0sbgy3am69yr9wl8id2gj39nqmgyradg";
  metaDest = "maven/org/json4s/json4s-core_2.12/3.6.1/json4s-core_2.12-3.6.1.pom";
})

(mkBinPackage {
  name = "json4s-native_2_12_3_5_3";
  pname = "json4s-native_2.12";
  version = "3.5.3";
  org = "org.json4s";
  jarUrl = "https://repo1.maven.org/maven2/org/json4s/json4s-native_2.12/3.5.3/json4s-native_2.12-3.5.3.jar";
  jarSha256 = "0w6nkx61y6aks48969iw5ch1sp0br5cf6f2p09nfmcg52ks20l0w";
  jarDest = "maven/org/json4s/json4s-native_2.12/3.5.3/json4s-native_2.12-3.5.3.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/json4s/json4s-native_2.12/3.5.3/json4s-native_2.12-3.5.3.pom";
  metaSha256 = "1751j6j6igmx56h4f996f44g3yzszlqaxcrjk7hhq419yaafjgzn";
  metaDest = "maven/org/json4s/json4s-native_2.12/3.5.3/json4s-native_2.12-3.5.3.pom";
})

(mkBinPackage {
  name = "json4s-native_2_12_3_6_1";
  pname = "json4s-native_2.12";
  version = "3.6.1";
  org = "org.json4s";
  jarUrl = "https://repo1.maven.org/maven2/org/json4s/json4s-native_2.12/3.6.1/json4s-native_2.12-3.6.1.jar";
  jarSha256 = "0zkkg4b1n3bv8i7w5alv0h1dfarcmdk94lrvlw37sq90p3d6niva";
  jarDest = "maven/org/json4s/json4s-native_2.12/3.6.1/json4s-native_2.12-3.6.1.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/json4s/json4s-native_2.12/3.6.1/json4s-native_2.12-3.6.1.pom";
  metaSha256 = "1c662qwc34w0923kag4lml729l8gmci05nwhj11rn7njmj7k31ax";
  metaDest = "maven/org/json4s/json4s-native_2.12/3.6.1/json4s-native_2.12-3.6.1.pom";
})

(mkBinPackage {
  name = "json4s-scalap_2_12_3_5_3";
  pname = "json4s-scalap_2.12";
  version = "3.5.3";
  org = "org.json4s";
  jarUrl = "https://repo1.maven.org/maven2/org/json4s/json4s-scalap_2.12/3.5.3/json4s-scalap_2.12-3.5.3.jar";
  jarSha256 = "1lfk548xxsvmxqq35swqh1qs74wxzhs0cg5gphwy5sb2p54d6rjq";
  jarDest = "maven/org/json4s/json4s-scalap_2.12/3.5.3/json4s-scalap_2.12-3.5.3.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/json4s/json4s-scalap_2.12/3.5.3/json4s-scalap_2.12-3.5.3.pom";
  metaSha256 = "1p340j3g6ldi3x5pmy5r9ad3la7gnipmw5lbb5lcx48gwnw0lx50";
  metaDest = "maven/org/json4s/json4s-scalap_2.12/3.5.3/json4s-scalap_2.12-3.5.3.pom";
})

(mkBinPackage {
  name = "json4s-scalap_2_12_3_6_1";
  pname = "json4s-scalap_2.12";
  version = "3.6.1";
  org = "org.json4s";
  jarUrl = "https://repo1.maven.org/maven2/org/json4s/json4s-scalap_2.12/3.6.1/json4s-scalap_2.12-3.6.1.jar";
  jarSha256 = "1iffd92gdchgnyjwbszymh9jqvmkd6dbbx7f8jf71ivngiwzcd0c";
  jarDest = "maven/org/json4s/json4s-scalap_2.12/3.6.1/json4s-scalap_2.12-3.6.1.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/json4s/json4s-scalap_2.12/3.6.1/json4s-scalap_2.12-3.6.1.pom";
  metaSha256 = "11x3h1iqbpyhhqdd4365m8lavd7920rwl6d5kgj6h0vlai5k36dl";
  metaDest = "maven/org/json4s/json4s-scalap_2.12/3.6.1/json4s-scalap_2.12-3.6.1.pom";
})

(mkBinPackage {
  name = "asm_5_0_3";
  pname = "asm";
  version = "5.0.3";
  org = "org.ow2.asm";
  jarUrl = "https://repo1.maven.org/maven2/org/ow2/asm/asm/5.0.3/asm-5.0.3.jar";
  jarSha256 = "1k265g2nq810yg7sb9h5f1kyp2f0m2z2mz8drkcxr3vv8f7ggi3i";
  jarDest = "maven/org/ow2/asm/asm/5.0.3/asm-5.0.3.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/ow2/asm/asm/5.0.3/asm-5.0.3.pom";
  metaSha256 = "18565g4264fv0d7hq9fq34dyrybxl5h9d5pis8a7ggk2zqznad3x";
  metaDest = "maven/org/ow2/asm/asm/5.0.3/asm-5.0.3.pom";
})

(mkBinPackage {
  name = "asm_6_0";
  pname = "asm";
  version = "6.0";
  org = "org.ow2.asm";
  jarUrl = "https://repo1.maven.org/maven2/org/ow2/asm/asm/6.0/asm-6.0.jar";
  jarSha256 = "0q8489h5grwm2xxvkikd91nflq47xbjalp79m2cphsaf9b3p32fx";
  jarDest = "maven/org/ow2/asm/asm/6.0/asm-6.0.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/ow2/asm/asm/6.0/asm-6.0.pom";
  metaSha256 = "0bn3281hli8z7dx2cs6s0a0bxc0sbfsbn9jl12cyc4ki35z4kg62";
  metaDest = "maven/org/ow2/asm/asm/6.0/asm-6.0.pom";
})

(mkBinPackage {
  name = "asm-analysis_5_0_3";
  pname = "asm-analysis";
  version = "5.0.3";
  org = "org.ow2.asm";
  jarUrl = "https://repo1.maven.org/maven2/org/ow2/asm/asm-analysis/5.0.3/asm-analysis-5.0.3.jar";
  jarSha256 = "17c4j2r94xgbjh5wylgqdwv7fjr6w4jmbhinrmymb5ic8rijmyp8";
  jarDest = "maven/org/ow2/asm/asm-analysis/5.0.3/asm-analysis-5.0.3.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/ow2/asm/asm-analysis/5.0.3/asm-analysis-5.0.3.pom";
  metaSha256 = "1l570la07zr6ay1c9i5caglj029dyjwrv24zmn9n511xpjhh5z4z";
  metaDest = "maven/org/ow2/asm/asm-analysis/5.0.3/asm-analysis-5.0.3.pom";
})

(mkBinPackage {
  name = "asm-commons_6_0";
  pname = "asm-commons";
  version = "6.0";
  org = "org.ow2.asm";
  jarUrl = "https://repo1.maven.org/maven2/org/ow2/asm/asm-commons/6.0/asm-commons-6.0.jar";
  jarSha256 = "1gwsf7cvnvss04fbhybvznbm517rkbaya7yhvixh2sm9933fbg7i";
  jarDest = "maven/org/ow2/asm/asm-commons/6.0/asm-commons-6.0.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/ow2/asm/asm-commons/6.0/asm-commons-6.0.pom";
  metaSha256 = "1pawmm9ydlf0h4wrn15wcwdwqxj9jm0mgsqnj0i5gfdgffag5x4h";
  metaDest = "maven/org/ow2/asm/asm-commons/6.0/asm-commons-6.0.pom";
})

(mkBinPackage {
  name = "asm-tree_5_0_3";
  pname = "asm-tree";
  version = "5.0.3";
  org = "org.ow2.asm";
  jarUrl = "https://repo1.maven.org/maven2/org/ow2/asm/asm-tree/5.0.3/asm-tree-5.0.3.jar";
  jarSha256 = "0755acl6d70q49znzcy39c18vp7bivj80f8xr63lx5pr02a7lyil";
  jarDest = "maven/org/ow2/asm/asm-tree/5.0.3/asm-tree-5.0.3.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/ow2/asm/asm-tree/5.0.3/asm-tree-5.0.3.pom";
  metaSha256 = "0djjrxa10ny1mv0sq5yh6zqq371174xjzrzbz14zy652qnkrr0b5";
  metaDest = "maven/org/ow2/asm/asm-tree/5.0.3/asm-tree-5.0.3.pom";
})

(mkBinPackage {
  name = "asm-tree_6_0";
  pname = "asm-tree";
  version = "6.0";
  org = "org.ow2.asm";
  jarUrl = "https://repo1.maven.org/maven2/org/ow2/asm/asm-tree/6.0/asm-tree-6.0.jar";
  jarSha256 = "05b2229fwn5cndkabjnlkwzy6098h9bghlyjwicqfz3jd7xrhyc8";
  jarDest = "maven/org/ow2/asm/asm-tree/6.0/asm-tree-6.0.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/ow2/asm/asm-tree/6.0/asm-tree-6.0.pom";
  metaSha256 = "1d01wx74alk2xd8d1ic5yc87zacnwm2ylf4a6y95l66vgw6px21n";
  metaDest = "maven/org/ow2/asm/asm-tree/6.0/asm-tree-6.0.pom";
})

(mkBinPackage {
  name = "asm-util_5_0_3";
  pname = "asm-util";
  version = "5.0.3";
  org = "org.ow2.asm";
  jarUrl = "https://repo1.maven.org/maven2/org/ow2/asm/asm-util/5.0.3/asm-util-5.0.3.jar";
  jarSha256 = "0qi3iyp432z5jyr3mniwf0bbjrkdd9cdwlc1y1vm06v8lazyss17";
  jarDest = "maven/org/ow2/asm/asm-util/5.0.3/asm-util-5.0.3.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/ow2/asm/asm-util/5.0.3/asm-util-5.0.3.pom";
  metaSha256 = "0m9p9rz1f9j5xc3i742idyn2qjj5yqjlg0whw3nrr6slvy7hxqjs";
  metaDest = "maven/org/ow2/asm/asm-util/5.0.3/asm-util-5.0.3.pom";
})

(mkBinPackage {
  name = "jarjar_1_6_5";
  pname = "jarjar";
  version = "1.6.5";
  org = "org.pantsbuild";
  jarUrl = "https://repo1.maven.org/maven2/org/pantsbuild/jarjar/1.6.5/jarjar-1.6.5.jar";
  jarSha256 = "02xic53z9k1l41wx1kfp9rr53yc4qh88ha41xa3lpkpmy7aaa9a4";
  jarDest = "maven/org/pantsbuild/jarjar/1.6.5/jarjar-1.6.5.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/pantsbuild/jarjar/1.6.5/jarjar-1.6.5.pom";
  metaSha256 = "0spbakdzz8kxlfm9s5d7klv7sk1i0dayrnvr85qll3mqkz1s0vh4";
  metaDest = "maven/org/pantsbuild/jarjar/1.6.5/jarjar-1.6.5.pom";
})

(mkBinPackage {
  name = "parboiled-core_1_1_7";
  pname = "parboiled-core";
  version = "1.1.7";
  org = "org.parboiled";
  jarUrl = "https://repo1.maven.org/maven2/org/parboiled/parboiled-core/1.1.7/parboiled-core-1.1.7.jar";
  jarSha256 = "158m1db2ybvh7wix9whywrl2sqvd9kb9qanpgjy0pl6jqrxksh1c";
  jarDest = "maven/org/parboiled/parboiled-core/1.1.7/parboiled-core-1.1.7.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/parboiled/parboiled-core/1.1.7/parboiled-core-1.1.7.pom";
  metaSha256 = "13ivlsm44cdfla8jl43ln4qkvzv91k0z0p688p72x5bzd85m0n9i";
  metaDest = "maven/org/parboiled/parboiled-core/1.1.7/parboiled-core-1.1.7.pom";
})

(mkBinPackage {
  name = "parboiled-java_1_1_7";
  pname = "parboiled-java";
  version = "1.1.7";
  org = "org.parboiled";
  jarUrl = "https://repo1.maven.org/maven2/org/parboiled/parboiled-java/1.1.7/parboiled-java-1.1.7.jar";
  jarSha256 = "17ky1fxm4qkx6sjphm0ydhbzfjm64a6rx7m8fz001r9iaz6fgi4c";
  jarDest = "maven/org/parboiled/parboiled-java/1.1.7/parboiled-java-1.1.7.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/parboiled/parboiled-java/1.1.7/parboiled-java-1.1.7.pom";
  metaSha256 = "1wijinqbvz1rv0i32gwx55fxabggf205n3l38kc8hp5jd3vxabfv";
  metaDest = "maven/org/parboiled/parboiled-java/1.1.7/parboiled-java-1.1.7.pom";
})

(mkBinPackage {
  name = "pegdown_1_6_0";
  pname = "pegdown";
  version = "1.6.0";
  org = "org.pegdown";
  jarUrl = "https://repo1.maven.org/maven2/org/pegdown/pegdown/1.6.0/pegdown-1.6.0.jar";
  jarSha256 = "07r4chbs9hpblj1lwv9w42la1jc762ncpz6b31swnxij3hilaln1";
  jarDest = "maven/org/pegdown/pegdown/1.6.0/pegdown-1.6.0.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/pegdown/pegdown/1.6.0/pegdown-1.6.0.pom";
  metaSha256 = "0s9k89wd14r01588695qsjq0zhcy74j2iakl7lz19bn8dwx364gh";
  metaDest = "maven/org/pegdown/pegdown/1.6.0/pegdown-1.6.0.pom";
})

(mkBinPackage {
  name = "reactive-streams_1_0_0";
  pname = "reactive-streams";
  version = "1.0.0";
  org = "org.reactivestreams";
  jarUrl = "https://repo1.maven.org/maven2/org/reactivestreams/reactive-streams/1.0.0/reactive-streams-1.0.0.jar";
  jarSha256 = "1sx0kjvzfhqnibvmdq0spjmzrg8lbs7mmdjgqsv6xf8llq17g1pg";
  jarDest = "maven/org/reactivestreams/reactive-streams/1.0.0/reactive-streams-1.0.0.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/reactivestreams/reactive-streams/1.0.0/reactive-streams-1.0.0.pom";
  metaSha256 = "065r7nlj7fwckzh0f1g0nnwkw50xbfhixdjzr4ij9wzbc31symd0";
  metaDest = "maven/org/reactivestreams/reactive-streams/1.0.0/reactive-streams-1.0.0.pom";
})

(mkBinPackage {
  name = "scalacheck_2_12_1_13_4";
  pname = "scalacheck_2.12";
  version = "1.13.4";
  org = "org.scalacheck";
  jarUrl = "https://repo1.maven.org/maven2/org/scalacheck/scalacheck_2.12/1.13.4/scalacheck_2.12-1.13.4.jar";
  jarSha256 = "11q1vzx5xz97yxdpqqpdwc9pzbyavw1zi7d11xwrs3d11xjfc9j5";
  jarDest = "maven/org/scalacheck/scalacheck_2.12/1.13.4/scalacheck_2.12-1.13.4.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scalacheck/scalacheck_2.12/1.13.4/scalacheck_2.12-1.13.4.pom";
  metaSha256 = "1nljksd6j5qnjlwlj2v33wr6gv43zzicjzw92bh2c3s68gfssv3x";
  metaDest = "maven/org/scalacheck/scalacheck_2.12/1.13.4/scalacheck_2.12-1.13.4.pom";
})

(mkBinPackage {
  name = "scalacheck_2_12_1_14_0";
  pname = "scalacheck_2.12";
  version = "1.14.0";
  org = "org.scalacheck";
  jarUrl = "https://repo1.maven.org/maven2/org/scalacheck/scalacheck_2.12/1.14.0/scalacheck_2.12-1.14.0.jar";
  jarSha256 = "0bp6xkzbllrcblyw3yg781gdkdrjcs0lfl0rfjz06jxp5clmnvqy";
  jarDest = "maven/org/scalacheck/scalacheck_2.12/1.14.0/scalacheck_2.12-1.14.0.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scalacheck/scalacheck_2.12/1.14.0/scalacheck_2.12-1.14.0.pom";
  metaSha256 = "09rr88qjp6x23zvbjv01z24cbzjp0ah17wyf50pjxwb5ywibikds";
  metaDest = "maven/org/scalacheck/scalacheck_2.12/1.14.0/scalacheck_2.12-1.14.0.pom";
})

(mkBinPackage {
  name = "scalactic_2_12_3_0_1";
  pname = "scalactic_2.12";
  version = "3.0.1";
  org = "org.scalactic";
  jarUrl = "https://repo1.maven.org/maven2/org/scalactic/scalactic_2.12/3.0.1/scalactic_2.12-3.0.1.jar";
  jarSha256 = "1cwc026n8vsicd0c7aixp3574j2p1jazkpcq0vwkmwa2a188zcp4";
  jarDest = "maven/org/scalactic/scalactic_2.12/3.0.1/scalactic_2.12-3.0.1.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scalactic/scalactic_2.12/3.0.1/scalactic_2.12-3.0.1.pom";
  metaSha256 = "0ipbsj5j638c0hs9if8ii1r5ll37lcccj0rgsa45n9liqd2xm4j2";
  metaDest = "maven/org/scalactic/scalactic_2.12/3.0.1/scalactic_2.12-3.0.1.pom";
})

(mkBinPackage {
  name = "scalactic_2_12_3_0_5";
  pname = "scalactic_2.12";
  version = "3.0.5";
  org = "org.scalactic";
  jarUrl = "https://repo1.maven.org/maven2/org/scalactic/scalactic_2.12/3.0.5/scalactic_2.12-3.0.5.jar";
  jarSha256 = "0h8c59vkib07pvp4ik55vjcympvlr0952na2w27pbcb9v57mpqjp";
  jarDest = "maven/org/scalactic/scalactic_2.12/3.0.5/scalactic_2.12-3.0.5.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scalactic/scalactic_2.12/3.0.5/scalactic_2.12-3.0.5.pom";
  metaSha256 = "1plq67dfya9h5il4zl72jcz4575d3ra4j4lfrllcbv2h28gk5pm7";
  metaDest = "maven/org/scalactic/scalactic_2.12/3.0.5/scalactic_2.12-3.0.5.pom";
})

(mkBinPackage {
  name = "scala-java8-compat_2_12_0_8_0";
  pname = "scala-java8-compat_2.12";
  version = "0.8.0";
  org = "org.scala-lang.modules";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-lang/modules/scala-java8-compat_2.12/0.8.0/scala-java8-compat_2.12-0.8.0.jar";
  jarSha256 = "13pghdz5alzcdkqhmh0mv222jq7s13nv540ads71ba29pk8xzmfr";
  jarDest = "maven/org/scala-lang/modules/scala-java8-compat_2.12/0.8.0/scala-java8-compat_2.12-0.8.0.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-lang/modules/scala-java8-compat_2.12/0.8.0/scala-java8-compat_2.12-0.8.0.pom";
  metaSha256 = "03lmq7b6l3iskklx1iigkv6r1f6hlvwg8hz0c9lsg6yfah8p3qj9";
  metaDest = "maven/org/scala-lang/modules/scala-java8-compat_2.12/0.8.0/scala-java8-compat_2.12-0.8.0.pom";
})

(mkBinPackage {
  name = "scala-parser-combinators_2_12_1_0_4";
  pname = "scala-parser-combinators_2.12";
  version = "1.0.4";
  org = "org.scala-lang.modules";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-lang/modules/scala-parser-combinators_2.12/1.0.4/scala-parser-combinators_2.12-1.0.4.jar";
  jarSha256 = "04b1v62476gyjics03bbv6vhnpmqjja0s6b36sdz1s6kck87hb18";
  jarDest = "maven/org/scala-lang/modules/scala-parser-combinators_2.12/1.0.4/scala-parser-combinators_2.12-1.0.4.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-lang/modules/scala-parser-combinators_2.12/1.0.4/scala-parser-combinators_2.12-1.0.4.pom";
  metaSha256 = "0apgnkq4ndhr36nbbk1n0sxzjy7y7na99vcd53b47xzf497704mm";
  metaDest = "maven/org/scala-lang/modules/scala-parser-combinators_2.12/1.0.4/scala-parser-combinators_2.12-1.0.4.pom";
})

(mkBinPackage {
  name = "scala-parser-combinators_2_12_1_0_5";
  pname = "scala-parser-combinators_2.12";
  version = "1.0.5";
  org = "org.scala-lang.modules";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-lang/modules/scala-parser-combinators_2.12/1.0.5/scala-parser-combinators_2.12-1.0.5.jar";
  jarSha256 = "0xcaln1fivzq8p0vc4akavb8xw7zqdxdq89hbn5fnhl0zlyg9wpi";
  jarDest = "maven/org/scala-lang/modules/scala-parser-combinators_2.12/1.0.5/scala-parser-combinators_2.12-1.0.5.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-lang/modules/scala-parser-combinators_2.12/1.0.5/scala-parser-combinators_2.12-1.0.5.pom";
  metaSha256 = "0hzkqsfclp02pqw5nzclcdh7ki39rb5y9knyqrrx016znfvjm5pg";
  metaDest = "maven/org/scala-lang/modules/scala-parser-combinators_2.12/1.0.5/scala-parser-combinators_2.12-1.0.5.pom";
})

(mkBinPackage {
  name = "scala-parser-combinators_2_12_1_0_6";
  pname = "scala-parser-combinators_2.12";
  version = "1.0.6";
  org = "org.scala-lang.modules";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-lang/modules/scala-parser-combinators_2.12/1.0.6/scala-parser-combinators_2.12-1.0.6.jar";
  jarSha256 = "179ljh1cw8k79l85l3acv0y5k7jgbsfbv1aq84m3xdri4bpmkpf9";
  jarDest = "maven/org/scala-lang/modules/scala-parser-combinators_2.12/1.0.6/scala-parser-combinators_2.12-1.0.6.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-lang/modules/scala-parser-combinators_2.12/1.0.6/scala-parser-combinators_2.12-1.0.6.pom";
  metaSha256 = "18066mdq5pq3fkgrpv58my7lgvimh3q4xg4qcjsqvzkkb6lsrncv";
  metaDest = "maven/org/scala-lang/modules/scala-parser-combinators_2.12/1.0.6/scala-parser-combinators_2.12-1.0.6.pom";
})

(mkBinPackage {
  name = "scala-xml_2_12_1_0_6";
  pname = "scala-xml_2.12";
  version = "1.0.6";
  org = "org.scala-lang.modules";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-lang/modules/scala-xml_2.12/1.0.6/scala-xml_2.12-1.0.6.jar";
  jarSha256 = "02i3ncy011czl3pxgvwmhzvn5q72pzs47q78fywrr1vfnp7bdhvw";
  jarDest = "maven/org/scala-lang/modules/scala-xml_2.12/1.0.6/scala-xml_2.12-1.0.6.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-lang/modules/scala-xml_2.12/1.0.6/scala-xml_2.12-1.0.6.pom";
  metaSha256 = "02wssb8anm6i4bffdkw77zrkymzqw3qq7qnby91d8crkbv3vkzd8";
  metaDest = "maven/org/scala-lang/modules/scala-xml_2.12/1.0.6/scala-xml_2.12-1.0.6.pom";
})

(mkBinPackage {
  name = "scala-compiler_2_12_4";
  pname = "scala-compiler";
  version = "2.12.4";
  org = "org.scala-lang";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-lang/scala-compiler/2.12.4/scala-compiler-2.12.4.jar";
  jarSha256 = "00baj3k3p520kpi208h3017lmszf5d6x1vj78lizg165m8116s4b";
  jarDest = "maven/org/scala-lang/scala-compiler/2.12.4/scala-compiler-2.12.4.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-lang/scala-compiler/2.12.4/scala-compiler-2.12.4.pom";
  metaSha256 = "1qlqbgm4pcqbarp1jj0cf9mcv6zjvqgxgczmg7ngkb867bhvd40j";
  metaDest = "maven/org/scala-lang/scala-compiler/2.12.4/scala-compiler-2.12.4.pom";
})

(mkBinPackage {
  name = "scala-library_2_12_4";
  pname = "scala-library";
  version = "2.12.4";
  org = "org.scala-lang";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-lang/scala-library/2.12.4/scala-library-2.12.4.jar";
  jarSha256 = "0pbxcqxb4al13ws9xg5rq8k68jaq9ynyp16slkx6rx6kwk74z0hp";
  jarDest = "maven/org/scala-lang/scala-library/2.12.4/scala-library-2.12.4.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-lang/scala-library/2.12.4/scala-library-2.12.4.pom";
  metaSha256 = "16d0andp42wfil3p5h0pwf3a555v23vdmz4dqc1jzmykrr3cvgb3";
  metaDest = "maven/org/scala-lang/scala-library/2.12.4/scala-library-2.12.4.pom";
})

(mkBinPackage {
  name = "scala-reflect_2_12_4";
  pname = "scala-reflect";
  version = "2.12.4";
  org = "org.scala-lang";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-lang/scala-reflect/2.12.4/scala-reflect-2.12.4.jar";
  jarSha256 = "1k37cms75sr7hfwiijzlhd1b5hz95cxrc61aqlzx490fal7gww7a";
  jarDest = "maven/org/scala-lang/scala-reflect/2.12.4/scala-reflect-2.12.4.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-lang/scala-reflect/2.12.4/scala-reflect-2.12.4.pom";
  metaSha256 = "1q4w6fawf2gin7726ymx79d6agdx111jv81jbsa1mv67fjl7rc4v";
  metaDest = "maven/org/scala-lang/scala-reflect/2.12.4/scala-reflect-2.12.4.pom";
})

(mkBinPackage {
  name = "paradise_2_12_4_2_1_0";
  pname = "paradise_2.12.4";
  version = "2.1.0";
  org = "org.scalamacros";
  jarUrl = "https://repo1.maven.org/maven2/org/scalamacros/paradise_2.12.4/2.1.0/paradise_2.12.4-2.1.0.jar";
  jarSha256 = "12q04dszv3xj0djkmkayqyvlcnq5b3phdy6fgx4z4nwhxcfrpjgh";
  jarDest = "maven/org/scalamacros/paradise_2.12.4/2.1.0/paradise_2.12.4-2.1.0.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scalamacros/paradise_2.12.4/2.1.0/paradise_2.12.4-2.1.0.pom";
  metaSha256 = "10crsm0xzx404934728wy563pzdslb57820ps8p80bdnlm5l39qq";
  metaDest = "maven/org/scalamacros/paradise_2.12.4/2.1.0/paradise_2.12.4-2.1.0.pom";
})

(mkBinPackage {
  name = "scalariform_2_12_0_2_0";
  pname = "scalariform_2.12";
  version = "0.2.0";
  org = "org.scalariform";
  jarUrl = "https://repo1.maven.org/maven2/org/scalariform/scalariform_2.12/0.2.0/scalariform_2.12-0.2.0.jar";
  jarSha256 = "05zw7acimksn45cwvgsjqdh7zvxip7fyhm32b4k3yfvrlysr955c";
  jarDest = "maven/org/scalariform/scalariform_2.12/0.2.0/scalariform_2.12-0.2.0.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scalariform/scalariform_2.12/0.2.0/scalariform_2.12-0.2.0.pom";
  metaSha256 = "1cawrbifg6jq9yjnxd22lz5kwilq1jnwwrjpdjak3w2gybzhnp26";
  metaDest = "maven/org/scalariform/scalariform_2.12/0.2.0/scalariform_2.12-0.2.0.pom";
})

(mkBinPackage {
  name = "actions_2_12_1_1_1";
  pname = "actions_2.12";
  version = "1.1.1";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/actions_2.12/1.1.1/actions_2.12-1.1.1.jar";
  jarSha256 = "0fkqi1qz6bacrqb8y0s76q9ablzmjqsvi703yz2i8q78h17b30wc";
  jarDest = "maven/org/scala-sbt/actions_2.12/1.1.1/actions_2.12-1.1.1.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/actions_2.12/1.1.1/actions_2.12-1.1.1.pom";
  metaSha256 = "1skka61913k364h1vdppbqvrcvkkm2amvf44ji3gqjmxh2i1m8zv";
  metaDest = "maven/org/scala-sbt/actions_2.12/1.1.1/actions_2.12-1.1.1.pom";
})

(mkBinPackage {
  name = "actions_2_12_1_2_7";
  pname = "actions_2.12";
  version = "1.2.7";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/actions_2.12/1.2.7/actions_2.12-1.2.7.jar";
  jarSha256 = "1mbgy50drc3sabhdjdy7chmp4hbij7dzmpzgmyqrpm7b81nqambc";
  jarDest = "maven/org/scala-sbt/actions_2.12/1.2.7/actions_2.12-1.2.7.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/actions_2.12/1.2.7/actions_2.12-1.2.7.pom";
  metaSha256 = "07pyjdas11rkprg4a2bxkxbanhma7d9k46s8km1m5lgvw2f8m6bx";
  metaDest = "maven/org/scala-sbt/actions_2.12/1.2.7/actions_2.12-1.2.7.pom";
})

(mkBinPackage {
  name = "collections_2_12_1_1_1";
  pname = "collections_2.12";
  version = "1.1.1";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/collections_2.12/1.1.1/collections_2.12-1.1.1.jar";
  jarSha256 = "0v3laa46lnhsphfsq1zi21rbc5jv5swy7lc2ih5z9z33jqsyaagz";
  jarDest = "maven/org/scala-sbt/collections_2.12/1.1.1/collections_2.12-1.1.1.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/collections_2.12/1.1.1/collections_2.12-1.1.1.pom";
  metaSha256 = "1rx3wcg4dcnfzgv55x0fb8ac20hbyb329cnz3k9afxk36h45if7b";
  metaDest = "maven/org/scala-sbt/collections_2.12/1.1.1/collections_2.12-1.1.1.pom";
})

(mkBinPackage {
  name = "collections_2_12_1_2_7";
  pname = "collections_2.12";
  version = "1.2.7";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/collections_2.12/1.2.7/collections_2.12-1.2.7.jar";
  jarSha256 = "1gdzifbac9h90wncnvsa67qwjy6b9qf71cc9wx99yssri72zw1di";
  jarDest = "maven/org/scala-sbt/collections_2.12/1.2.7/collections_2.12-1.2.7.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/collections_2.12/1.2.7/collections_2.12-1.2.7.pom";
  metaSha256 = "1qqq00fwvsjhfnjhr44h1w9lkssvy70h27fh44ccnb1jxlsyq9r6";
  metaDest = "maven/org/scala-sbt/collections_2.12/1.2.7/collections_2.12-1.2.7.pom";
})

(mkBinPackage {
  name = "command_2_12_1_1_1";
  pname = "command_2.12";
  version = "1.1.1";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/command_2.12/1.1.1/command_2.12-1.1.1.jar";
  jarSha256 = "1cyppa1z6r9jax2hr1yxfd63an3hra9dqxxk8pq3czsd60735xsx";
  jarDest = "maven/org/scala-sbt/command_2.12/1.1.1/command_2.12-1.1.1.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/command_2.12/1.1.1/command_2.12-1.1.1.pom";
  metaSha256 = "1ihvm1b4qcsa2zkdrpg6m5idlgkx1yp1wyyzz83ax1ng3mwgwxsk";
  metaDest = "maven/org/scala-sbt/command_2.12/1.1.1/command_2.12-1.1.1.pom";
})

(mkBinPackage {
  name = "command_2_12_1_2_7";
  pname = "command_2.12";
  version = "1.2.7";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/command_2.12/1.2.7/command_2.12-1.2.7.jar";
  jarSha256 = "1svp4ib7hb4fp7n9n73jfcnnrn68jh2ws6wvn907ik1hqf5a1d1b";
  jarDest = "maven/org/scala-sbt/command_2.12/1.2.7/command_2.12-1.2.7.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/command_2.12/1.2.7/command_2.12-1.2.7.pom";
  metaSha256 = "0jcjf6w7fw625xi3zs55c5jn97sma59s2l8imfb54pgk27gyl3b1";
  metaDest = "maven/org/scala-sbt/command_2.12/1.2.7/command_2.12-1.2.7.pom";
})

(mkBinPackage {
  name = "compiler-bridge_2_12_1_2_5";
  pname = "compiler-bridge_2.12";
  version = "1.2.5";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/compiler-bridge_2.12/1.2.5/compiler-bridge_2.12-1.2.5.jar";
  jarSha256 = "00ff6mcc5zz71chssfa6lrwa91r27g7c605cncjx255kf6qflhn3";
  jarDest = "maven/org/scala-sbt/compiler-bridge_2.12/1.2.5/compiler-bridge_2.12-1.2.5.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/compiler-bridge_2.12/1.2.5/compiler-bridge_2.12-1.2.5.pom";
  metaSha256 = "15wcybpq9lbiqr9a3l1cq5vb4cifv5h1qh04i5flpwff7knviygb";
  metaDest = "maven/org/scala-sbt/compiler-bridge_2.12/1.2.5/compiler-bridge_2.12-1.2.5.pom";
})

(mkBinPackage {
  name = "compiler-interface_1_1_1";
  pname = "compiler-interface";
  version = "1.1.1";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/compiler-interface/1.1.1/compiler-interface-1.1.1.jar";
  jarSha256 = "0c6yiss23fwvnwxdl9awv8dsizhib1q1ads9qr0l3dmffahc174m";
  jarDest = "maven/org/scala-sbt/compiler-interface/1.1.1/compiler-interface-1.1.1.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/compiler-interface/1.1.1/compiler-interface-1.1.1.pom";
  metaSha256 = "17f12qrwfljd77m2fna2kj23s103msknkqwp7mxqa2gkkaj3f9kj";
  metaDest = "maven/org/scala-sbt/compiler-interface/1.1.1/compiler-interface-1.1.1.pom";
})

(mkBinPackage {
  name = "compiler-interface_1_2_5";
  pname = "compiler-interface";
  version = "1.2.5";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/compiler-interface/1.2.5/compiler-interface-1.2.5.jar";
  jarSha256 = "1ga2fhxxv9jcq9jw5fwpr4j1mwxa05k4ayjk4nqyg68zzw17yb2h";
  jarDest = "maven/org/scala-sbt/compiler-interface/1.2.5/compiler-interface-1.2.5.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/compiler-interface/1.2.5/compiler-interface-1.2.5.pom";
  metaSha256 = "14jsmr3q93lwxfw0k2mm3hsjpq9y9pdrcvs1k90zk28lms3hmghx";
  metaDest = "maven/org/scala-sbt/compiler-interface/1.2.5/compiler-interface-1.2.5.pom";
})

(mkBinPackage {
  name = "completion_2_12_1_1_1";
  pname = "completion_2.12";
  version = "1.1.1";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/completion_2.12/1.1.1/completion_2.12-1.1.1.jar";
  jarSha256 = "1dg1h1qyrphrg23l15qz764sgvrap94ag80ckrhds78qcn7p3p1i";
  jarDest = "maven/org/scala-sbt/completion_2.12/1.1.1/completion_2.12-1.1.1.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/completion_2.12/1.1.1/completion_2.12-1.1.1.pom";
  metaSha256 = "07ndqp05c56713n2ln0fj19dax0w6fbvcxihha9bxxs4rkh1xfpj";
  metaDest = "maven/org/scala-sbt/completion_2.12/1.1.1/completion_2.12-1.1.1.pom";
})

(mkBinPackage {
  name = "completion_2_12_1_2_7";
  pname = "completion_2.12";
  version = "1.2.7";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/completion_2.12/1.2.7/completion_2.12-1.2.7.jar";
  jarSha256 = "1x07kfjk21i8wzc5sl3fxdczz3nqzvi0v0app59aq316jryk45rs";
  jarDest = "maven/org/scala-sbt/completion_2.12/1.2.7/completion_2.12-1.2.7.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/completion_2.12/1.2.7/completion_2.12-1.2.7.pom";
  metaSha256 = "1cpfr6sysvlpcwl3jwb3jwpngyski873vsjn6lap52lxfrl8k9gi";
  metaDest = "maven/org/scala-sbt/completion_2.12/1.2.7/completion_2.12-1.2.7.pom";
})

(mkBinPackage {
  name = "core-macros_2_12_1_1_1";
  pname = "core-macros_2.12";
  version = "1.1.1";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/core-macros_2.12/1.1.1/core-macros_2.12-1.1.1.jar";
  jarSha256 = "1dqb4ryff4y3xyv8nnffl13ipp92zjr4q0q88gm67c1nzfmfbi8h";
  jarDest = "maven/org/scala-sbt/core-macros_2.12/1.1.1/core-macros_2.12-1.1.1.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/core-macros_2.12/1.1.1/core-macros_2.12-1.1.1.pom";
  metaSha256 = "0qskx2jpfix27kvpjawnw9jmgmhwfyk1rfxnwr4jz0sc6zqnrm80";
  metaDest = "maven/org/scala-sbt/core-macros_2.12/1.1.1/core-macros_2.12-1.1.1.pom";
})

(mkBinPackage {
  name = "core-macros_2_12_1_2_7";
  pname = "core-macros_2.12";
  version = "1.2.7";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/core-macros_2.12/1.2.7/core-macros_2.12-1.2.7.jar";
  jarSha256 = "1s6vf0n2kndya8gfkvxn6xsil9l37298r63rr6knz747pkagkism";
  jarDest = "maven/org/scala-sbt/core-macros_2.12/1.2.7/core-macros_2.12-1.2.7.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/core-macros_2.12/1.2.7/core-macros_2.12-1.2.7.pom";
  metaSha256 = "027szkq1cnnpflh460i93z1hzmxfs3dqvikz6fgdsdlj66bqsyla";
  metaDest = "maven/org/scala-sbt/core-macros_2.12/1.2.7/core-macros_2.12-1.2.7.pom";
})

(mkBinPackage {
  name = "io_2_12_1_1_4";
  pname = "io_2.12";
  version = "1.1.4";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/io_2.12/1.1.4/io_2.12-1.1.4.jar";
  jarSha256 = "0zm8nxqz36j9g92kyr0qgl71wvn0528pc50v9afss9j19fsi9xgi";
  jarDest = "maven/org/scala-sbt/io_2.12/1.1.4/io_2.12-1.1.4.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/io_2.12/1.1.4/io_2.12-1.1.4.pom";
  metaSha256 = "0hrfz8ghk1swb0sm88yk68shraryhxfpmjavc2vizb0vil3c4i41";
  metaDest = "maven/org/scala-sbt/io_2.12/1.1.4/io_2.12-1.1.4.pom";
})

(mkBinPackage {
  name = "io_2_12_1_2_2";
  pname = "io_2.12";
  version = "1.2.2";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/io_2.12/1.2.2/io_2.12-1.2.2.jar";
  jarSha256 = "0qfnb8cdhrsg5fjx6ndiy7hasmqik34qwpqw6c8kz0hqxizbq0r7";
  jarDest = "maven/org/scala-sbt/io_2.12/1.2.2/io_2.12-1.2.2.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/io_2.12/1.2.2/io_2.12-1.2.2.pom";
  metaSha256 = "1572k556ma123vg7s2b74vpvg03ix2vbkbmxcmdgjjhivjvxnvh0";
  metaDest = "maven/org/scala-sbt/io_2.12/1.2.2/io_2.12-1.2.2.pom";
})

(mkBinPackage {
  name = "ipcsocket_1_0_0";
  pname = "ipcsocket";
  version = "1.0.0";
  org = "org.scala-sbt.ipcsocket";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/ipcsocket/ipcsocket/1.0.0/ipcsocket-1.0.0.jar";
  jarSha256 = "1v75rqf92nwsldd5056r73j20idwnzsvirpvkgsfwhlgyp4l58gr";
  jarDest = "maven/org/scala-sbt/ipcsocket/ipcsocket/1.0.0/ipcsocket-1.0.0.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/ipcsocket/ipcsocket/1.0.0/ipcsocket-1.0.0.pom";
  metaSha256 = "0nwwdl5143lnhqvn4qghrxgr0ql9l7y839qp5pazpf6lfjqpnz0w";
  metaDest = "maven/org/scala-sbt/ipcsocket/ipcsocket/1.0.0/ipcsocket-1.0.0.pom";
})

(mkBinPackage {
  name = "ivy_2_3_0-sbt-b18f59ea3bc914a297bb6f1a4f7fb0ace399e310";
  pname = "ivy";
  version = "2.3.0-sbt-b18f59ea3bc914a297bb6f1a4f7fb0ace399e310";
  org = "org.scala-sbt.ivy";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/ivy/ivy/2.3.0-sbt-b18f59ea3bc914a297bb6f1a4f7fb0ace399e310/ivy-2.3.0-sbt-b18f59ea3bc914a297bb6f1a4f7fb0ace399e310.jar";
  jarSha256 = "05fpmzig1abwgz12g6g84qcm38p0pwnwa8vfw55jrrab0ai5fi3d";
  jarDest = "maven/org/scala-sbt/ivy/ivy/2.3.0-sbt-b18f59ea3bc914a297bb6f1a4f7fb0ace399e310/ivy-2.3.0-sbt-b18f59ea3bc914a297bb6f1a4f7fb0ace399e310.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/ivy/ivy/2.3.0-sbt-b18f59ea3bc914a297bb6f1a4f7fb0ace399e310/ivy-2.3.0-sbt-b18f59ea3bc914a297bb6f1a4f7fb0ace399e310.pom";
  metaSha256 = "08l2cpgjx7kd0b64d5cpr3psihggvl8nd29b3wdllg4aydnyxwns";
  metaDest = "maven/org/scala-sbt/ivy/ivy/2.3.0-sbt-b18f59ea3bc914a297bb6f1a4f7fb0ace399e310/ivy-2.3.0-sbt-b18f59ea3bc914a297bb6f1a4f7fb0ace399e310.pom";
})

(mkBinPackage {
  name = "launcher-interface_1_0_2";
  pname = "launcher-interface";
  version = "1.0.2";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/launcher-interface/1.0.2/launcher-interface-1.0.2.jar";
  jarSha256 = "00axpgx0imf8bddls8cnlw32ix08kfk0zqpjnpmx0sk2rnjdm4jf";
  jarDest = "maven/org/scala-sbt/launcher-interface/1.0.2/launcher-interface-1.0.2.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/launcher-interface/1.0.2/launcher-interface-1.0.2.pom";
  metaSha256 = "11273h4ls5v52qzp5pngfg9drsnhncs4ygrqxwq11ax8pdndriqm";
  metaDest = "maven/org/scala-sbt/launcher-interface/1.0.2/launcher-interface-1.0.2.pom";
})

(mkBinPackage {
  name = "launcher-interface_1_0_4";
  pname = "launcher-interface";
  version = "1.0.4";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/launcher-interface/1.0.4/launcher-interface-1.0.4.jar";
  jarSha256 = "025vqhq9vipnz0qwx6nbrfmm79vqfjmag0j9imnbrgcyqyp3daca";
  jarDest = "maven/org/scala-sbt/launcher-interface/1.0.4/launcher-interface-1.0.4.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/launcher-interface/1.0.4/launcher-interface-1.0.4.pom";
  metaSha256 = "0wxanndgplry2cfzhphl6idq56lsfx2rv6xk11xrh5znpln9bnm9";
  metaDest = "maven/org/scala-sbt/launcher-interface/1.0.4/launcher-interface-1.0.4.pom";
})

(mkBinPackage {
  name = "librarymanagement-core_2_12_1_1_3";
  pname = "librarymanagement-core_2.12";
  version = "1.1.3";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/librarymanagement-core_2.12/1.1.3/librarymanagement-core_2.12-1.1.3.jar";
  jarSha256 = "1r324ks22sf3k328kk4l59rfcvmi5a8faw88qa8w7d80bm9v7gag";
  jarDest = "maven/org/scala-sbt/librarymanagement-core_2.12/1.1.3/librarymanagement-core_2.12-1.1.3.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/librarymanagement-core_2.12/1.1.3/librarymanagement-core_2.12-1.1.3.pom";
  metaSha256 = "0afywibphlq35378z1494p9m6d8xsasf7v5bdi4d0wh9l7h44fzv";
  metaDest = "maven/org/scala-sbt/librarymanagement-core_2.12/1.1.3/librarymanagement-core_2.12-1.1.3.pom";
})

(mkBinPackage {
  name = "librarymanagement-core_2_12_1_2_3";
  pname = "librarymanagement-core_2.12";
  version = "1.2.3";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/librarymanagement-core_2.12/1.2.3/librarymanagement-core_2.12-1.2.3.jar";
  jarSha256 = "1g6ilxikqj6zj665xxhifpqdh3hgfcxy9bjl2phqhhrqz1kxhpqg";
  jarDest = "maven/org/scala-sbt/librarymanagement-core_2.12/1.2.3/librarymanagement-core_2.12-1.2.3.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/librarymanagement-core_2.12/1.2.3/librarymanagement-core_2.12-1.2.3.pom";
  metaSha256 = "1s6hjmvs2g8k7g7n9gj45yjh8bavrxkm8szpjm356f75fnwcpix8";
  metaDest = "maven/org/scala-sbt/librarymanagement-core_2.12/1.2.3/librarymanagement-core_2.12-1.2.3.pom";
})

(mkBinPackage {
  name = "librarymanagement-ivy_2_12_1_1_3";
  pname = "librarymanagement-ivy_2.12";
  version = "1.1.3";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/librarymanagement-ivy_2.12/1.1.3/librarymanagement-ivy_2.12-1.1.3.jar";
  jarSha256 = "11wf32jgsvbb81gyzqxb360bh7gdyhm69pgabhyjafx3291msk7d";
  jarDest = "maven/org/scala-sbt/librarymanagement-ivy_2.12/1.1.3/librarymanagement-ivy_2.12-1.1.3.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/librarymanagement-ivy_2.12/1.1.3/librarymanagement-ivy_2.12-1.1.3.pom";
  metaSha256 = "0vyn0jhj14m31c9c52ljgfhzx1px9d46l9phxr6j0xapbqi183mn";
  metaDest = "maven/org/scala-sbt/librarymanagement-ivy_2.12/1.1.3/librarymanagement-ivy_2.12-1.1.3.pom";
})

(mkBinPackage {
  name = "librarymanagement-ivy_2_12_1_2_3";
  pname = "librarymanagement-ivy_2.12";
  version = "1.2.3";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/librarymanagement-ivy_2.12/1.2.3/librarymanagement-ivy_2.12-1.2.3.jar";
  jarSha256 = "1fm4mq3czryx33715k0cims3ggi18drkyivig2n6vhdylv659zj3";
  jarDest = "maven/org/scala-sbt/librarymanagement-ivy_2.12/1.2.3/librarymanagement-ivy_2.12-1.2.3.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/librarymanagement-ivy_2.12/1.2.3/librarymanagement-ivy_2.12-1.2.3.pom";
  metaSha256 = "1hqg4nmlby5p70j3pisijvql5llb9iqqc9v0avfysjch4rsi5mr8";
  metaDest = "maven/org/scala-sbt/librarymanagement-ivy_2.12/1.2.3/librarymanagement-ivy_2.12-1.2.3.pom";
})

(mkBinPackage {
  name = "logic_2_12_1_1_1";
  pname = "logic_2.12";
  version = "1.1.1";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/logic_2.12/1.1.1/logic_2.12-1.1.1.jar";
  jarSha256 = "0sclzm1xbi199isa9jc1cn9frl080znvs437fvgjfrjjcs2fz10y";
  jarDest = "maven/org/scala-sbt/logic_2.12/1.1.1/logic_2.12-1.1.1.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/logic_2.12/1.1.1/logic_2.12-1.1.1.pom";
  metaSha256 = "03brnc1bm7m7cyh2svdmq9y8ac6mv1blikvkr514n57jy975x2ab";
  metaDest = "maven/org/scala-sbt/logic_2.12/1.1.1/logic_2.12-1.1.1.pom";
})

(mkBinPackage {
  name = "logic_2_12_1_2_7";
  pname = "logic_2.12";
  version = "1.2.7";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/logic_2.12/1.2.7/logic_2.12-1.2.7.jar";
  jarSha256 = "0r25yydwrjqa452b6wm36spvyqp96lmbm54w0yj4bbsba08aq97r";
  jarDest = "maven/org/scala-sbt/logic_2.12/1.2.7/logic_2.12-1.2.7.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/logic_2.12/1.2.7/logic_2.12-1.2.7.pom";
  metaSha256 = "0pc8z9xqzd5gwsvx5k9wgnvf2d1dg2mwws9hr0pjmf834af59syz";
  metaDest = "maven/org/scala-sbt/logic_2.12/1.2.7/logic_2.12-1.2.7.pom";
})

(mkBinPackage {
  name = "main_2_12_1_1_1";
  pname = "main_2.12";
  version = "1.1.1";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/main_2.12/1.1.1/main_2.12-1.1.1.jar";
  jarSha256 = "1ckjzw7pls1f933f4krc4lf3fdpfxwkq306pb7vgqjykc0jcqqa4";
  jarDest = "maven/org/scala-sbt/main_2.12/1.1.1/main_2.12-1.1.1.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/main_2.12/1.1.1/main_2.12-1.1.1.pom";
  metaSha256 = "0yy7fgq22wn0gd2z172d0mszhiy93fr3g4ikn4hd0iiwmc2dlmxl";
  metaDest = "maven/org/scala-sbt/main_2.12/1.1.1/main_2.12-1.1.1.pom";
})

(mkBinPackage {
  name = "main_2_12_1_2_7";
  pname = "main_2.12";
  version = "1.2.7";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/main_2.12/1.2.7/main_2.12-1.2.7.jar";
  jarSha256 = "1ffa3y0bivyq76wjz668g1rdnkch24vcb64lsyzrpyxmwshlmkv0";
  jarDest = "maven/org/scala-sbt/main_2.12/1.2.7/main_2.12-1.2.7.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/main_2.12/1.2.7/main_2.12-1.2.7.pom";
  metaSha256 = "1ck6x8s33w6a0kvsj5r6gfg0rnk943sm598663f2hbs6lxyvr6cz";
  metaDest = "maven/org/scala-sbt/main_2.12/1.2.7/main_2.12-1.2.7.pom";
})

(mkBinPackage {
  name = "main-settings_2_12_1_1_1";
  pname = "main-settings_2.12";
  version = "1.1.1";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/main-settings_2.12/1.1.1/main-settings_2.12-1.1.1.jar";
  jarSha256 = "19fcv57pxi0rhdr52hh37hzm3rvb4adrmxp7vkg0ww5m9bjxcy7r";
  jarDest = "maven/org/scala-sbt/main-settings_2.12/1.1.1/main-settings_2.12-1.1.1.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/main-settings_2.12/1.1.1/main-settings_2.12-1.1.1.pom";
  metaSha256 = "0fcz0ig5irq4c64gyafkpcqcww7nsk3wjificj7gkay346hqg4a5";
  metaDest = "maven/org/scala-sbt/main-settings_2.12/1.1.1/main-settings_2.12-1.1.1.pom";
})

(mkBinPackage {
  name = "main-settings_2_12_1_2_7";
  pname = "main-settings_2.12";
  version = "1.2.7";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/main-settings_2.12/1.2.7/main-settings_2.12-1.2.7.jar";
  jarSha256 = "0q09dyq7zlhcbnqvn0dsgspc319j7m54nllrp9zqpbjyfvd6fbqb";
  jarDest = "maven/org/scala-sbt/main-settings_2.12/1.2.7/main-settings_2.12-1.2.7.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/main-settings_2.12/1.2.7/main-settings_2.12-1.2.7.pom";
  metaSha256 = "0csz1l3g89nd2649nkdxk1yvvdjr6hiwp5qqqywgmmzwby7d1fvs";
  metaDest = "maven/org/scala-sbt/main-settings_2.12/1.2.7/main-settings_2.12-1.2.7.pom";
})

(mkBinPackage {
  name = "protocol_2_12_1_1_1";
  pname = "protocol_2.12";
  version = "1.1.1";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/protocol_2.12/1.1.1/protocol_2.12-1.1.1.jar";
  jarSha256 = "06iaib6xw6ccmfcib38yx2k5bp20rl4mvjnrh079vkrm3xcx7c68";
  jarDest = "maven/org/scala-sbt/protocol_2.12/1.1.1/protocol_2.12-1.1.1.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/protocol_2.12/1.1.1/protocol_2.12-1.1.1.pom";
  metaSha256 = "0p5x2qhm876cbrl5x48kgg0cabycygqhkbn05xzrc2gf4z0iaj7k";
  metaDest = "maven/org/scala-sbt/protocol_2.12/1.1.1/protocol_2.12-1.1.1.pom";
})

(mkBinPackage {
  name = "protocol_2_12_1_2_7";
  pname = "protocol_2.12";
  version = "1.2.7";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/protocol_2.12/1.2.7/protocol_2.12-1.2.7.jar";
  jarSha256 = "1r420x3y4db5lfnlr31b36bsbpf7sw9hfw87fg9ws7snmlv7p7p2";
  jarDest = "maven/org/scala-sbt/protocol_2.12/1.2.7/protocol_2.12-1.2.7.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/protocol_2.12/1.2.7/protocol_2.12-1.2.7.pom";
  metaSha256 = "1r5r87hag3jnc7qp6kbk2r60lsp39g8lbscawzf05s2gbyg5a2ap";
  metaDest = "maven/org/scala-sbt/protocol_2.12/1.2.7/protocol_2.12-1.2.7.pom";
})

(mkBinPackage {
  name = "run_2_12_1_1_1";
  pname = "run_2.12";
  version = "1.1.1";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/run_2.12/1.1.1/run_2.12-1.1.1.jar";
  jarSha256 = "1w7g5kfdi43lbanymq5hfadygd7xrvnwc69lggix2az33m6w6bb1";
  jarDest = "maven/org/scala-sbt/run_2.12/1.1.1/run_2.12-1.1.1.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/run_2.12/1.1.1/run_2.12-1.1.1.pom";
  metaSha256 = "1gq77a5y3zs2l8dks47jih7ylgnsxiz54xk74gz81khkgr56y02k";
  metaDest = "maven/org/scala-sbt/run_2.12/1.1.1/run_2.12-1.1.1.pom";
})

(mkBinPackage {
  name = "run_2_12_1_2_7";
  pname = "run_2.12";
  version = "1.2.7";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/run_2.12/1.2.7/run_2.12-1.2.7.jar";
  jarSha256 = "1l6r3k1zmnpwv1xqfim9lbz29jqfgcj1fgrv3gjlxqhbl86jxz6z";
  jarDest = "maven/org/scala-sbt/run_2.12/1.2.7/run_2.12-1.2.7.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/run_2.12/1.2.7/run_2.12-1.2.7.pom";
  metaSha256 = "16ia8qk676k2nvkmpxzd5dqpam4a5sc9g4sfiykj02fnjjh493hw";
  metaDest = "maven/org/scala-sbt/run_2.12/1.2.7/run_2.12-1.2.7.pom";
})

(mkBinPackage {
  name = "sbinary_2_12_0_4_4";
  pname = "sbinary_2.12";
  version = "0.4.4";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/sbinary_2.12/0.4.4/sbinary_2.12-0.4.4.jar";
  jarSha256 = "0al0zb6b476l3y2qinnsx89yy0mwbw7ig2z7v2s6lawrls4a99r4";
  jarDest = "maven/org/scala-sbt/sbinary_2.12/0.4.4/sbinary_2.12-0.4.4.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/sbinary_2.12/0.4.4/sbinary_2.12-0.4.4.pom";
  metaSha256 = "1r3lslbw8zf3bzsv11nlhjk5sqb138qy8xp4djyvcfz4wr5p7n32";
  metaDest = "maven/org/scala-sbt/sbinary_2.12/0.4.4/sbinary_2.12-0.4.4.pom";
})

(mkBinPackage {
  name = "sbinary_2_12_0_5_0";
  pname = "sbinary_2.12";
  version = "0.5.0";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/sbinary_2.12/0.5.0/sbinary_2.12-0.5.0.jar";
  jarSha256 = "0kdnlfkm9p5vl05sqf61byq3xzrkxr56c26004hivb3k1sgz5vq3";
  jarDest = "maven/org/scala-sbt/sbinary_2.12/0.5.0/sbinary_2.12-0.5.0.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/sbinary_2.12/0.5.0/sbinary_2.12-0.5.0.pom";
  metaSha256 = "038wkfmd2farpfwcghn4jbvmd4qyvdzjw0m8aywbm0fc13k18ggl";
  metaDest = "maven/org/scala-sbt/sbinary_2.12/0.5.0/sbinary_2.12-0.5.0.pom";
})

(mkBinPackage {
  name = "sbt_1_1_1";
  pname = "sbt";
  version = "1.1.1";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/sbt/1.1.1/sbt-1.1.1.jar";
  jarSha256 = "16s6dicbjb6yhz4a3bw6840hm08w0xjbffjx6qgbng8fwq12q6m2";
  jarDest = "maven/org/scala-sbt/sbt/1.1.1/sbt-1.1.1.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/sbt/1.1.1/sbt-1.1.1.pom";
  metaSha256 = "13d5c1lkmimil7cnybg4lrlf0c6v6rrg48m43j3gmdfwg7dsa35b";
  metaDest = "maven/org/scala-sbt/sbt/1.1.1/sbt-1.1.1.pom";
})

(mkBinPackage {
  name = "sbt_1_2_7";
  pname = "sbt";
  version = "1.2.7";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/sbt/1.2.7/sbt-1.2.7.jar";
  jarSha256 = "1fpnfwg5iq96jh6mvmalavl2b9q1l61izrw15c19wr6lf3l7nbf1";
  jarDest = "maven/org/scala-sbt/sbt/1.2.7/sbt-1.2.7.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/sbt/1.2.7/sbt-1.2.7.pom";
  metaSha256 = "1cs0ryx9m1ch23mbdfbdardgjlchyx70abbj0fdr5qqfg9cc2r5b";
  metaDest = "maven/org/scala-sbt/sbt/1.2.7/sbt-1.2.7.pom";
})

(mkBinPackage {
  name = "scripted-plugin_2_12_1_2_7";
  pname = "scripted-plugin_2.12";
  version = "1.2.7";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/scripted-plugin_2.12/1.2.7/scripted-plugin_2.12-1.2.7.jar";
  jarSha256 = "1imqffx26g0d2kwlw6zf869m8ggb1gzgsgiibcyk0syfqmb098q5";
  jarDest = "maven/org/scala-sbt/scripted-plugin_2.12/1.2.7/scripted-plugin_2.12-1.2.7.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/scripted-plugin_2.12/1.2.7/scripted-plugin_2.12-1.2.7.pom";
  metaSha256 = "1k891jwpbhmaicvb6122a5ncfkvm05q9az8zhfhaqvpqxry4d2f1";
  metaDest = "maven/org/scala-sbt/scripted-plugin_2.12/1.2.7/scripted-plugin_2.12-1.2.7.pom";
})

(mkBinPackage {
  name = "scripted-sbt-redux_2_12_1_2_7";
  pname = "scripted-sbt-redux_2.12";
  version = "1.2.7";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/scripted-sbt-redux_2.12/1.2.7/scripted-sbt-redux_2.12-1.2.7.jar";
  jarSha256 = "1zd4qwdb4q3z5d3gfg81k676jv6995jhyn57804dn8kya1dlyynz";
  jarDest = "maven/org/scala-sbt/scripted-sbt-redux_2.12/1.2.7/scripted-sbt-redux_2.12-1.2.7.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/scripted-sbt-redux_2.12/1.2.7/scripted-sbt-redux_2.12-1.2.7.pom";
  metaSha256 = "02pzyh3mmh9vm1bw75fsprnq3rrmxrfb24y84z2z23l4nc1zr9i1";
  metaDest = "maven/org/scala-sbt/scripted-sbt-redux_2.12/1.2.7/scripted-sbt-redux_2.12-1.2.7.pom";
})

(mkBinPackage {
  name = "tasks_2_12_1_1_1";
  pname = "tasks_2.12";
  version = "1.1.1";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/tasks_2.12/1.1.1/tasks_2.12-1.1.1.jar";
  jarSha256 = "0q21prqakdqmnfahmprb0j1d28mzlabw8x3j2rvcxs70x0xfl94f";
  jarDest = "maven/org/scala-sbt/tasks_2.12/1.1.1/tasks_2.12-1.1.1.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/tasks_2.12/1.1.1/tasks_2.12-1.1.1.pom";
  metaSha256 = "1c4gw6gzgx4h2jjvh4ishrm4i8q3mgifdwrvad3dzvif5ah27p2y";
  metaDest = "maven/org/scala-sbt/tasks_2.12/1.1.1/tasks_2.12-1.1.1.pom";
})

(mkBinPackage {
  name = "tasks_2_12_1_2_7";
  pname = "tasks_2.12";
  version = "1.2.7";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/tasks_2.12/1.2.7/tasks_2.12-1.2.7.jar";
  jarSha256 = "040f4vzgjdrwbrv5ghpn5ikljhpibmgdxp8p5a5k89ydd2jccs8s";
  jarDest = "maven/org/scala-sbt/tasks_2.12/1.2.7/tasks_2.12-1.2.7.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/tasks_2.12/1.2.7/tasks_2.12-1.2.7.pom";
  metaSha256 = "1yva6b7brn35h2p76i3r2qddpczph964l1552rwks0dvxggjxhwq";
  metaDest = "maven/org/scala-sbt/tasks_2.12/1.2.7/tasks_2.12-1.2.7.pom";
})

(mkBinPackage {
  name = "task-system_2_12_1_1_1";
  pname = "task-system_2.12";
  version = "1.1.1";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/task-system_2.12/1.1.1/task-system_2.12-1.1.1.jar";
  jarSha256 = "1y6hfx9dxmyp2h3vxig83ml31zmn9sxv0jpr9f7df0vahlqpkcr5";
  jarDest = "maven/org/scala-sbt/task-system_2.12/1.1.1/task-system_2.12-1.1.1.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/task-system_2.12/1.1.1/task-system_2.12-1.1.1.pom";
  metaSha256 = "1xviilw2jjdqnpkba2vf622j3ii8qj7vypd6bqphxlii6a0hjq8j";
  metaDest = "maven/org/scala-sbt/task-system_2.12/1.1.1/task-system_2.12-1.1.1.pom";
})

(mkBinPackage {
  name = "task-system_2_12_1_2_7";
  pname = "task-system_2.12";
  version = "1.2.7";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/task-system_2.12/1.2.7/task-system_2.12-1.2.7.jar";
  jarSha256 = "1ymph2b87fiv8ixc77imvghzxnh4li3yyb48l9l9qjscaimvmhkp";
  jarDest = "maven/org/scala-sbt/task-system_2.12/1.2.7/task-system_2.12-1.2.7.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/task-system_2.12/1.2.7/task-system_2.12-1.2.7.pom";
  metaSha256 = "0k8ydlnymvg5gilg81cbjc6c7pkwprb027lqdm7v38cs3hfvli1y";
  metaDest = "maven/org/scala-sbt/task-system_2.12/1.2.7/task-system_2.12-1.2.7.pom";
})

(mkBinPackage {
  name = "template-resolver_0_1";
  pname = "template-resolver";
  version = "0.1";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/template-resolver/0.1/template-resolver-0.1.jar";
  jarSha256 = "0mkw92467i4jip5kbzvl5v1zwzv05alb3hb97l6z9bp641mxbf0b";
  jarDest = "maven/org/scala-sbt/template-resolver/0.1/template-resolver-0.1.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/template-resolver/0.1/template-resolver-0.1.pom";
  metaSha256 = "0nsx88y1b3nqpd6r80bb1rpaaskfhcxdbfaqngykrxz8gvq3i2q3";
  metaDest = "maven/org/scala-sbt/template-resolver/0.1/template-resolver-0.1.pom";
})

(mkBinPackage {
  name = "test-agent_1_1_1";
  pname = "test-agent";
  version = "1.1.1";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/test-agent/1.1.1/test-agent-1.1.1.jar";
  jarSha256 = "0gc6mg993wwj65pj4c82i7myc47lshvjmmw3kwm0vfqas8qhrs69";
  jarDest = "maven/org/scala-sbt/test-agent/1.1.1/test-agent-1.1.1.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/test-agent/1.1.1/test-agent-1.1.1.pom";
  metaSha256 = "11yjj96cxhrabqzrvlnlvsknpnafdirpa64k8p0swdcggwbikj14";
  metaDest = "maven/org/scala-sbt/test-agent/1.1.1/test-agent-1.1.1.pom";
})

(mkBinPackage {
  name = "test-agent_1_2_7";
  pname = "test-agent";
  version = "1.2.7";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/test-agent/1.2.7/test-agent-1.2.7.jar";
  jarSha256 = "06bf0bc5jygvb9zqkqvck8c06ldrqr9k77gbp1lr1sragcb2mmhp";
  jarDest = "maven/org/scala-sbt/test-agent/1.2.7/test-agent-1.2.7.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/test-agent/1.2.7/test-agent-1.2.7.pom";
  metaSha256 = "0dd5xrd23f2v7yfn8snxqbjrzzqv5kd6q9fy5ifj82ha4anpmbzn";
  metaDest = "maven/org/scala-sbt/test-agent/1.2.7/test-agent-1.2.7.pom";
})

(mkBinPackage {
  name = "testing_2_12_1_1_1";
  pname = "testing_2.12";
  version = "1.1.1";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/testing_2.12/1.1.1/testing_2.12-1.1.1.jar";
  jarSha256 = "1nkkzgx2dn9nai5yzfkgixsf49aafv8l9aqp42lz5y412g76l74m";
  jarDest = "maven/org/scala-sbt/testing_2.12/1.1.1/testing_2.12-1.1.1.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/testing_2.12/1.1.1/testing_2.12-1.1.1.pom";
  metaSha256 = "1rra83x5w1gp18aq54a301j77z3g4nn61zq1ljw9x68rmgjq9p72";
  metaDest = "maven/org/scala-sbt/testing_2.12/1.1.1/testing_2.12-1.1.1.pom";
})

(mkBinPackage {
  name = "testing_2_12_1_2_7";
  pname = "testing_2.12";
  version = "1.2.7";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/testing_2.12/1.2.7/testing_2.12-1.2.7.jar";
  jarSha256 = "1c8aix3f74kmwsia6mp25d5lqybdd4xndnw2inmhdwy4f4cjia05";
  jarDest = "maven/org/scala-sbt/testing_2.12/1.2.7/testing_2.12-1.2.7.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/testing_2.12/1.2.7/testing_2.12-1.2.7.pom";
  metaSha256 = "1zf9rdn39kp15zmn20zqdwf1n80rnmbqm0rbwmq04nhhapln6ydk";
  metaDest = "maven/org/scala-sbt/testing_2.12/1.2.7/testing_2.12-1.2.7.pom";
})

(mkBinPackage {
  name = "test-interface_1_0";
  pname = "test-interface";
  version = "1.0";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/test-interface/1.0/test-interface-1.0.jar";
  jarSha256 = "17klrl4ylpsy9d16fk6npb7lxfqr1w1m9slsxhph1wwmpcw0pxqm";
  jarDest = "maven/org/scala-sbt/test-interface/1.0/test-interface-1.0.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/test-interface/1.0/test-interface-1.0.pom";
  metaSha256 = "0bknid634xcq5r8fs1bx0ydxs3rhzgmzq1400h7y29n2s2lhdfk1";
  metaDest = "maven/org/scala-sbt/test-interface/1.0/test-interface-1.0.pom";
})

(mkBinPackage {
  name = "util-cache_2_12_1_1_2";
  pname = "util-cache_2.12";
  version = "1.1.2";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/util-cache_2.12/1.1.2/util-cache_2.12-1.1.2.jar";
  jarSha256 = "0k2jgwkj7jv3dml1igl1lyl5qqcigvk0nslkg4bb8db354kgv468";
  jarDest = "maven/org/scala-sbt/util-cache_2.12/1.1.2/util-cache_2.12-1.1.2.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/util-cache_2.12/1.1.2/util-cache_2.12-1.1.2.pom";
  metaSha256 = "1n8i834lry3iaj7snvb5hc6dy6zy1kg7v7cglscgwpw8s3cvm6ip";
  metaDest = "maven/org/scala-sbt/util-cache_2.12/1.1.2/util-cache_2.12-1.1.2.pom";
})

(mkBinPackage {
  name = "util-cache_2_12_1_2_4";
  pname = "util-cache_2.12";
  version = "1.2.4";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/util-cache_2.12/1.2.4/util-cache_2.12-1.2.4.jar";
  jarSha256 = "0wcbmivw254dr9fmfz500ybm77qigarpgi02ykx7zxik8dphs5vd";
  jarDest = "maven/org/scala-sbt/util-cache_2.12/1.2.4/util-cache_2.12-1.2.4.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/util-cache_2.12/1.2.4/util-cache_2.12-1.2.4.pom";
  metaSha256 = "0a2q4kyf97gr3amv0rfqra0fi3skm0gb2i111zvw4676qd7ydfvn";
  metaDest = "maven/org/scala-sbt/util-cache_2.12/1.2.4/util-cache_2.12-1.2.4.pom";
})

(mkBinPackage {
  name = "util-control_2_12_1_1_2";
  pname = "util-control_2.12";
  version = "1.1.2";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/util-control_2.12/1.1.2/util-control_2.12-1.1.2.jar";
  jarSha256 = "19bx20v3xw3kxmlak25lcdhz6ibkkqsq652krpqb2xw45clnrclh";
  jarDest = "maven/org/scala-sbt/util-control_2.12/1.1.2/util-control_2.12-1.1.2.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/util-control_2.12/1.1.2/util-control_2.12-1.1.2.pom";
  metaSha256 = "1s42fjih15rfpa60b0r0r9l29135qlaqgh1vw2kr87xz5anz7ybf";
  metaDest = "maven/org/scala-sbt/util-control_2.12/1.1.2/util-control_2.12-1.1.2.pom";
})

(mkBinPackage {
  name = "util-control_2_12_1_2_4";
  pname = "util-control_2.12";
  version = "1.2.4";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/util-control_2.12/1.2.4/util-control_2.12-1.2.4.jar";
  jarSha256 = "13a8j6hda5099glrv21ccxhw73a7i4zimz4asa9k1wijdwr89fpf";
  jarDest = "maven/org/scala-sbt/util-control_2.12/1.2.4/util-control_2.12-1.2.4.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/util-control_2.12/1.2.4/util-control_2.12-1.2.4.pom";
  metaSha256 = "0q190c12n3sky0q1krxsi66582sqc3jrzgrdl957fvkizmqdqmbl";
  metaDest = "maven/org/scala-sbt/util-control_2.12/1.2.4/util-control_2.12-1.2.4.pom";
})

(mkBinPackage {
  name = "util-interface_1_1_2";
  pname = "util-interface";
  version = "1.1.2";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/util-interface/1.1.2/util-interface-1.1.2.jar";
  jarSha256 = "0xkivb1qc4522qdcx91fjad2ppkx44r7c0fshiv08d1shmk9zlkc";
  jarDest = "maven/org/scala-sbt/util-interface/1.1.2/util-interface-1.1.2.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/util-interface/1.1.2/util-interface-1.1.2.pom";
  metaSha256 = "12dwhm54cw5awnqzzs2zgdb3mv0mn1j6ml1mpmk15n43drwflmvs";
  metaDest = "maven/org/scala-sbt/util-interface/1.1.2/util-interface-1.1.2.pom";
})

(mkBinPackage {
  name = "util-interface_1_2_4";
  pname = "util-interface";
  version = "1.2.4";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/util-interface/1.2.4/util-interface-1.2.4.jar";
  jarSha256 = "1pfb55004c3przmi19jgsarala5j5cxya8blllmbk5z0n2v4nci2";
  jarDest = "maven/org/scala-sbt/util-interface/1.2.4/util-interface-1.2.4.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/util-interface/1.2.4/util-interface-1.2.4.pom";
  metaSha256 = "12p8yyyflgpsjf78822g6s1pvmc5iq1h3l89yj0wmhgv8is0vgrl";
  metaDest = "maven/org/scala-sbt/util-interface/1.2.4/util-interface-1.2.4.pom";
})

(mkBinPackage {
  name = "util-logging_2_12_1_1_2";
  pname = "util-logging_2.12";
  version = "1.1.2";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/util-logging_2.12/1.1.2/util-logging_2.12-1.1.2.jar";
  jarSha256 = "19d62azjz2bsmg6v9i3p2h6pgq7ibqi8l036r2a2z46qwnvkmk4x";
  jarDest = "maven/org/scala-sbt/util-logging_2.12/1.1.2/util-logging_2.12-1.1.2.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/util-logging_2.12/1.1.2/util-logging_2.12-1.1.2.pom";
  metaSha256 = "069ka4kh1xlc43bigzcs0a5jc1ri8s7s82npmgjz3lm77ssyc7qx";
  metaDest = "maven/org/scala-sbt/util-logging_2.12/1.1.2/util-logging_2.12-1.1.2.pom";
})

(mkBinPackage {
  name = "util-logging_2_12_1_2_4";
  pname = "util-logging_2.12";
  version = "1.2.4";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/util-logging_2.12/1.2.4/util-logging_2.12-1.2.4.jar";
  jarSha256 = "0jg5n5y2kgzc5vlnnzhlm1nz1vwdlh3kndy1pj7xryws7hb7qiqr";
  jarDest = "maven/org/scala-sbt/util-logging_2.12/1.2.4/util-logging_2.12-1.2.4.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/util-logging_2.12/1.2.4/util-logging_2.12-1.2.4.pom";
  metaSha256 = "0spbb1sbfns24l6zg3xjcvicby2dsa0d9mssxr4lhy7h0p6x0ns2";
  metaDest = "maven/org/scala-sbt/util-logging_2.12/1.2.4/util-logging_2.12-1.2.4.pom";
})

(mkBinPackage {
  name = "util-position_2_12_1_1_2";
  pname = "util-position_2.12";
  version = "1.1.2";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/util-position_2.12/1.1.2/util-position_2.12-1.1.2.jar";
  jarSha256 = "1bv5izd38s2r6xyn11lnlnvd3zw8gplx6ylampv964anb9mqbqya";
  jarDest = "maven/org/scala-sbt/util-position_2.12/1.1.2/util-position_2.12-1.1.2.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/util-position_2.12/1.1.2/util-position_2.12-1.1.2.pom";
  metaSha256 = "161syznbvb88y72jjwz9aykaxxfv2l99g7ms52sphwyvxx5kdiwk";
  metaDest = "maven/org/scala-sbt/util-position_2.12/1.1.2/util-position_2.12-1.1.2.pom";
})

(mkBinPackage {
  name = "util-position_2_12_1_2_4";
  pname = "util-position_2.12";
  version = "1.2.4";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/util-position_2.12/1.2.4/util-position_2.12-1.2.4.jar";
  jarSha256 = "121r0h4wpv8g1i8b229kzybw45wmfzm5g122fl7d086zhnv73j1a";
  jarDest = "maven/org/scala-sbt/util-position_2.12/1.2.4/util-position_2.12-1.2.4.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/util-position_2.12/1.2.4/util-position_2.12-1.2.4.pom";
  metaSha256 = "1zvfhf9qkjr6rh1q1ws0qxjw282qqbil4n9ni6zlkxix95az3gc9";
  metaDest = "maven/org/scala-sbt/util-position_2.12/1.2.4/util-position_2.12-1.2.4.pom";
})

(mkBinPackage {
  name = "util-relation_2_12_1_1_2";
  pname = "util-relation_2.12";
  version = "1.1.2";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/util-relation_2.12/1.1.2/util-relation_2.12-1.1.2.jar";
  jarSha256 = "0wzy5bir049zk95dwrz5xx83wmhggi5115nmaxzfrvd55nnmy9zx";
  jarDest = "maven/org/scala-sbt/util-relation_2.12/1.1.2/util-relation_2.12-1.1.2.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/util-relation_2.12/1.1.2/util-relation_2.12-1.1.2.pom";
  metaSha256 = "1awpzw05v5zv6l7hwkhbyplmzfyyfqpd8v2nqhqpcb8q51kjcicf";
  metaDest = "maven/org/scala-sbt/util-relation_2.12/1.1.2/util-relation_2.12-1.1.2.pom";
})

(mkBinPackage {
  name = "util-relation_2_12_1_2_4";
  pname = "util-relation_2.12";
  version = "1.2.4";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/util-relation_2.12/1.2.4/util-relation_2.12-1.2.4.jar";
  jarSha256 = "0py8g217zidwg17lsasmydl5ikw2mpkd2vlfr47ibkxi1qq4l8s5";
  jarDest = "maven/org/scala-sbt/util-relation_2.12/1.2.4/util-relation_2.12-1.2.4.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/util-relation_2.12/1.2.4/util-relation_2.12-1.2.4.pom";
  metaSha256 = "0z78infvpnsrz0mpdbfgcc2q7jp16rpg3qpvjfgqszlibqlfxhj5";
  metaDest = "maven/org/scala-sbt/util-relation_2.12/1.2.4/util-relation_2.12-1.2.4.pom";
})

(mkBinPackage {
  name = "util-scripted_2_12_1_2_4";
  pname = "util-scripted_2.12";
  version = "1.2.4";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/util-scripted_2.12/1.2.4/util-scripted_2.12-1.2.4.jar";
  jarSha256 = "11n7km0r38gzrylakr7n1bxkyisrsy08a39h1q3y585rprsg3a96";
  jarDest = "maven/org/scala-sbt/util-scripted_2.12/1.2.4/util-scripted_2.12-1.2.4.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/util-scripted_2.12/1.2.4/util-scripted_2.12-1.2.4.pom";
  metaSha256 = "1jfrn7zx2svg4x5xqwfsn1fs2hfm3c5a1ls4plsd85hr1vzchvm7";
  metaDest = "maven/org/scala-sbt/util-scripted_2.12/1.2.4/util-scripted_2.12-1.2.4.pom";
})

(mkBinPackage {
  name = "util-tracking_2_12_1_1_2";
  pname = "util-tracking_2.12";
  version = "1.1.2";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/util-tracking_2.12/1.1.2/util-tracking_2.12-1.1.2.jar";
  jarSha256 = "0r3knf1nx2qfr0f15f1kpps4vr9rl0qcn66ymp47ni8k5v049m25";
  jarDest = "maven/org/scala-sbt/util-tracking_2.12/1.1.2/util-tracking_2.12-1.1.2.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/util-tracking_2.12/1.1.2/util-tracking_2.12-1.1.2.pom";
  metaSha256 = "00qkyv4m7dxxsmycf7499y2isd09wgaacwamvxi7q521wbys3799";
  metaDest = "maven/org/scala-sbt/util-tracking_2.12/1.1.2/util-tracking_2.12-1.1.2.pom";
})

(mkBinPackage {
  name = "util-tracking_2_12_1_2_4";
  pname = "util-tracking_2.12";
  version = "1.2.4";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/util-tracking_2.12/1.2.4/util-tracking_2.12-1.2.4.jar";
  jarSha256 = "0am7lggn57b5qlv1cbz76862fvxdqxnjqicy5wk2j3nha2dakg4j";
  jarDest = "maven/org/scala-sbt/util-tracking_2.12/1.2.4/util-tracking_2.12-1.2.4.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/util-tracking_2.12/1.2.4/util-tracking_2.12-1.2.4.pom";
  metaSha256 = "05d07s9k3jqnrjyff7hzlhy2pib1j5c7bfm396k5v24wq5m7j7il";
  metaDest = "maven/org/scala-sbt/util-tracking_2.12/1.2.4/util-tracking_2.12-1.2.4.pom";
})

(mkBinPackage {
  name = "zinc_2_12_1_1_1";
  pname = "zinc_2.12";
  version = "1.1.1";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/zinc_2.12/1.1.1/zinc_2.12-1.1.1.jar";
  jarSha256 = "0jxmls67mxjlalh2m1b6kmqs7v1q6195jgzb1dh75hr9gww58c3c";
  jarDest = "maven/org/scala-sbt/zinc_2.12/1.1.1/zinc_2.12-1.1.1.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/zinc_2.12/1.1.1/zinc_2.12-1.1.1.pom";
  metaSha256 = "04dhn5ym2vcl1x1bdfhbv3vpp7k4p07b73jq8302ck2zzf0m0q43";
  metaDest = "maven/org/scala-sbt/zinc_2.12/1.1.1/zinc_2.12-1.1.1.pom";
})

(mkBinPackage {
  name = "zinc_2_12_1_2_5";
  pname = "zinc_2.12";
  version = "1.2.5";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/zinc_2.12/1.2.5/zinc_2.12-1.2.5.jar";
  jarSha256 = "0ripnld29jnm7d5qpw4i3naql3am9cnkwz53l8rqf6grdqn23wmg";
  jarDest = "maven/org/scala-sbt/zinc_2.12/1.2.5/zinc_2.12-1.2.5.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/zinc_2.12/1.2.5/zinc_2.12-1.2.5.pom";
  metaSha256 = "0m4lq84q6raxqy1xyb2cp4hpiyygnlv55xjf9vmxdmwx8jjri7kg";
  metaDest = "maven/org/scala-sbt/zinc_2.12/1.2.5/zinc_2.12-1.2.5.pom";
})

(mkBinPackage {
  name = "zinc-apiinfo_2_12_1_1_1";
  pname = "zinc-apiinfo_2.12";
  version = "1.1.1";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/zinc-apiinfo_2.12/1.1.1/zinc-apiinfo_2.12-1.1.1.jar";
  jarSha256 = "00pwzw2nhjqsy1s5qdivnvcj00zm43b3a6xvs6w1s9jin07qyxd6";
  jarDest = "maven/org/scala-sbt/zinc-apiinfo_2.12/1.1.1/zinc-apiinfo_2.12-1.1.1.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/zinc-apiinfo_2.12/1.1.1/zinc-apiinfo_2.12-1.1.1.pom";
  metaSha256 = "0qgf9srvw4hjvpaaldcb3hfn4j4dwn62vkkjzmlmfimnaswxgh7d";
  metaDest = "maven/org/scala-sbt/zinc-apiinfo_2.12/1.1.1/zinc-apiinfo_2.12-1.1.1.pom";
})

(mkBinPackage {
  name = "zinc-apiinfo_2_12_1_2_5";
  pname = "zinc-apiinfo_2.12";
  version = "1.2.5";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/zinc-apiinfo_2.12/1.2.5/zinc-apiinfo_2.12-1.2.5.jar";
  jarSha256 = "0jrddhkjgd72wa3rlpp5la4ayf1jbi3hs4ycr74lafkhpgs0lh94";
  jarDest = "maven/org/scala-sbt/zinc-apiinfo_2.12/1.2.5/zinc-apiinfo_2.12-1.2.5.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/zinc-apiinfo_2.12/1.2.5/zinc-apiinfo_2.12-1.2.5.pom";
  metaSha256 = "19gb6afs10nqj6fgxngxzs1rpgc7cg62sbv7mdkj708l6d3kfn3k";
  metaDest = "maven/org/scala-sbt/zinc-apiinfo_2.12/1.2.5/zinc-apiinfo_2.12-1.2.5.pom";
})

(mkBinPackage {
  name = "zinc-classfile_2_12_1_1_1";
  pname = "zinc-classfile_2.12";
  version = "1.1.1";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/zinc-classfile_2.12/1.1.1/zinc-classfile_2.12-1.1.1.jar";
  jarSha256 = "05rc7xyzymymyjqzykmphbw3mjlzjjfzhhwhy8h7da8iqg8kicg3";
  jarDest = "maven/org/scala-sbt/zinc-classfile_2.12/1.1.1/zinc-classfile_2.12-1.1.1.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/zinc-classfile_2.12/1.1.1/zinc-classfile_2.12-1.1.1.pom";
  metaSha256 = "1iw9ln24mmm6r567il9i2szjdgsmhj7vc7wdy3rii56flgc37fnr";
  metaDest = "maven/org/scala-sbt/zinc-classfile_2.12/1.1.1/zinc-classfile_2.12-1.1.1.pom";
})

(mkBinPackage {
  name = "zinc-classfile_2_12_1_2_5";
  pname = "zinc-classfile_2.12";
  version = "1.2.5";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/zinc-classfile_2.12/1.2.5/zinc-classfile_2.12-1.2.5.jar";
  jarSha256 = "1iga6f97wi13kshrx9rmh7y387v3b249l5n61652birshj7zr56z";
  jarDest = "maven/org/scala-sbt/zinc-classfile_2.12/1.2.5/zinc-classfile_2.12-1.2.5.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/zinc-classfile_2.12/1.2.5/zinc-classfile_2.12-1.2.5.pom";
  metaSha256 = "14riw4ml5wy97f1p6hzksvdyz0cz9cb3msnmqb531k7wb3ngsyzp";
  metaDest = "maven/org/scala-sbt/zinc-classfile_2.12/1.2.5/zinc-classfile_2.12-1.2.5.pom";
})

(mkBinPackage {
  name = "zinc-classpath_2_12_1_1_1";
  pname = "zinc-classpath_2.12";
  version = "1.1.1";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/zinc-classpath_2.12/1.1.1/zinc-classpath_2.12-1.1.1.jar";
  jarSha256 = "0y3srdxdww98flmh06lmmrd4r3r10ij1d5spv0cvrkd9bbz9npb9";
  jarDest = "maven/org/scala-sbt/zinc-classpath_2.12/1.1.1/zinc-classpath_2.12-1.1.1.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/zinc-classpath_2.12/1.1.1/zinc-classpath_2.12-1.1.1.pom";
  metaSha256 = "0rvaif6d9xjkn44i3ki3r8x845f85kp9lvi1ywsij5hx61jbr5iz";
  metaDest = "maven/org/scala-sbt/zinc-classpath_2.12/1.1.1/zinc-classpath_2.12-1.1.1.pom";
})

(mkBinPackage {
  name = "zinc-classpath_2_12_1_2_5";
  pname = "zinc-classpath_2.12";
  version = "1.2.5";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/zinc-classpath_2.12/1.2.5/zinc-classpath_2.12-1.2.5.jar";
  jarSha256 = "12zd0lb395d6xggs18b80f6hfljl0xypcra5rr34m8gd5c6398nb";
  jarDest = "maven/org/scala-sbt/zinc-classpath_2.12/1.2.5/zinc-classpath_2.12-1.2.5.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/zinc-classpath_2.12/1.2.5/zinc-classpath_2.12-1.2.5.pom";
  metaSha256 = "0jcgs2lb8606jik0hxgadfziza6hsh18hcbswafgx73k0vprxfzs";
  metaDest = "maven/org/scala-sbt/zinc-classpath_2.12/1.2.5/zinc-classpath_2.12-1.2.5.pom";
})

(mkBinPackage {
  name = "zinc-compile_2_12_1_1_1";
  pname = "zinc-compile_2.12";
  version = "1.1.1";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/zinc-compile_2.12/1.1.1/zinc-compile_2.12-1.1.1.jar";
  jarSha256 = "107g7ajv3md1zzjv48m6rpbfnddvvc6sh6a4fgq77rm94md6hcvv";
  jarDest = "maven/org/scala-sbt/zinc-compile_2.12/1.1.1/zinc-compile_2.12-1.1.1.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/zinc-compile_2.12/1.1.1/zinc-compile_2.12-1.1.1.pom";
  metaSha256 = "1nfpm6wc9g5sqkrn41g9z50hdn2kmyh29cs5k89rjwk8rzhh3f49";
  metaDest = "maven/org/scala-sbt/zinc-compile_2.12/1.1.1/zinc-compile_2.12-1.1.1.pom";
})

(mkBinPackage {
  name = "zinc-compile_2_12_1_2_5";
  pname = "zinc-compile_2.12";
  version = "1.2.5";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/zinc-compile_2.12/1.2.5/zinc-compile_2.12-1.2.5.jar";
  jarSha256 = "1ddgcfllwqi0vm7fm91hb6wfdgsjri8jzikv24z24qfx042hvm6q";
  jarDest = "maven/org/scala-sbt/zinc-compile_2.12/1.2.5/zinc-compile_2.12-1.2.5.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/zinc-compile_2.12/1.2.5/zinc-compile_2.12-1.2.5.pom";
  metaSha256 = "09s08bbf9wwprl0xfd0v358jxpss21qfd00f06fkh49d9jll2sd0";
  metaDest = "maven/org/scala-sbt/zinc-compile_2.12/1.2.5/zinc-compile_2.12-1.2.5.pom";
})

(mkBinPackage {
  name = "zinc-compile-core_2_12_1_1_1";
  pname = "zinc-compile-core_2.12";
  version = "1.1.1";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/zinc-compile-core_2.12/1.1.1/zinc-compile-core_2.12-1.1.1.jar";
  jarSha256 = "15ksjqs7yhmgv5264nz30xwx2iiqsxld4ks4wx4zhnjqprxfr3pw";
  jarDest = "maven/org/scala-sbt/zinc-compile-core_2.12/1.1.1/zinc-compile-core_2.12-1.1.1.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/zinc-compile-core_2.12/1.1.1/zinc-compile-core_2.12-1.1.1.pom";
  metaSha256 = "07zfcjknbvvlxgfi55wzz9dfhlsw9zji3cwdd3ssqrjfrz3nbqfj";
  metaDest = "maven/org/scala-sbt/zinc-compile-core_2.12/1.1.1/zinc-compile-core_2.12-1.1.1.pom";
})

(mkBinPackage {
  name = "zinc-compile-core_2_12_1_2_5";
  pname = "zinc-compile-core_2.12";
  version = "1.2.5";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/zinc-compile-core_2.12/1.2.5/zinc-compile-core_2.12-1.2.5.jar";
  jarSha256 = "0z10ms9dqjb1p45k6z9s6735zr3k8h0k7p9s4m66j31cdn4sg7x7";
  jarDest = "maven/org/scala-sbt/zinc-compile-core_2.12/1.2.5/zinc-compile-core_2.12-1.2.5.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/zinc-compile-core_2.12/1.2.5/zinc-compile-core_2.12-1.2.5.pom";
  metaSha256 = "0pqv25s7m68rs4ns4apkc9wqvf6qxd16i0mizjybhb5yin0y35fr";
  metaDest = "maven/org/scala-sbt/zinc-compile-core_2.12/1.2.5/zinc-compile-core_2.12-1.2.5.pom";
})

(mkBinPackage {
  name = "zinc-core_2_12_1_1_1";
  pname = "zinc-core_2.12";
  version = "1.1.1";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/zinc-core_2.12/1.1.1/zinc-core_2.12-1.1.1.jar";
  jarSha256 = "0r53xgjfplidd27qkqp550n3dwk0f6ivk46z40ffjxckka7p0152";
  jarDest = "maven/org/scala-sbt/zinc-core_2.12/1.1.1/zinc-core_2.12-1.1.1.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/zinc-core_2.12/1.1.1/zinc-core_2.12-1.1.1.pom";
  metaSha256 = "1jm8kd5zzkvb7vd6hvjv7k5w1lcxprvgsx28zfd85zmszww00pwk";
  metaDest = "maven/org/scala-sbt/zinc-core_2.12/1.1.1/zinc-core_2.12-1.1.1.pom";
})

(mkBinPackage {
  name = "zinc-core_2_12_1_2_5";
  pname = "zinc-core_2.12";
  version = "1.2.5";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/zinc-core_2.12/1.2.5/zinc-core_2.12-1.2.5.jar";
  jarSha256 = "0gk8lkmgi0b4z4g1cplv6qxq9i6wm2xhr6cnllvsyhmvv8ymsxkn";
  jarDest = "maven/org/scala-sbt/zinc-core_2.12/1.2.5/zinc-core_2.12-1.2.5.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/zinc-core_2.12/1.2.5/zinc-core_2.12-1.2.5.pom";
  metaSha256 = "19hgaxrf75cmvxvqhwn5v3hqyrhdncd46h1n34y3nil551sicpj9";
  metaDest = "maven/org/scala-sbt/zinc-core_2.12/1.2.5/zinc-core_2.12-1.2.5.pom";
})

(mkBinPackage {
  name = "zinc-ivy-integration_2_12_1_1_1";
  pname = "zinc-ivy-integration_2.12";
  version = "1.1.1";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/zinc-ivy-integration_2.12/1.1.1/zinc-ivy-integration_2.12-1.1.1.jar";
  jarSha256 = "1kjlggscmlcik7w75awzhmr8b29kwjdf7k3ga5canbcmcya2j0ir";
  jarDest = "maven/org/scala-sbt/zinc-ivy-integration_2.12/1.1.1/zinc-ivy-integration_2.12-1.1.1.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/zinc-ivy-integration_2.12/1.1.1/zinc-ivy-integration_2.12-1.1.1.pom";
  metaSha256 = "00a78a3qjpr5sqh4sb8my046vrknrngal7a1xgxc8r08chdyailw";
  metaDest = "maven/org/scala-sbt/zinc-ivy-integration_2.12/1.1.1/zinc-ivy-integration_2.12-1.1.1.pom";
})

(mkBinPackage {
  name = "zinc-ivy-integration_2_12_1_2_5";
  pname = "zinc-ivy-integration_2.12";
  version = "1.2.5";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/zinc-ivy-integration_2.12/1.2.5/zinc-ivy-integration_2.12-1.2.5.jar";
  jarSha256 = "0vqhpb2i76zmw3np70yly6mkh8f1993hlq4sc24w755wqzdky6b5";
  jarDest = "maven/org/scala-sbt/zinc-ivy-integration_2.12/1.2.5/zinc-ivy-integration_2.12-1.2.5.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/zinc-ivy-integration_2.12/1.2.5/zinc-ivy-integration_2.12-1.2.5.pom";
  metaSha256 = "0308rns2wdw325lbwk5m078pk5fx3am9yn4m8ibk2g67gawp97dd";
  metaDest = "maven/org/scala-sbt/zinc-ivy-integration_2.12/1.2.5/zinc-ivy-integration_2.12-1.2.5.pom";
})

(mkBinPackage {
  name = "zinc-persist_2_12_1_1_1";
  pname = "zinc-persist_2.12";
  version = "1.1.1";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/zinc-persist_2.12/1.1.1/zinc-persist_2.12-1.1.1.jar";
  jarSha256 = "0xjjhdpy9p4330n6z9x5dkhck0i9i0wzhnisjk4v67dwvdb6k175";
  jarDest = "maven/org/scala-sbt/zinc-persist_2.12/1.1.1/zinc-persist_2.12-1.1.1.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/zinc-persist_2.12/1.1.1/zinc-persist_2.12-1.1.1.pom";
  metaSha256 = "0yhs59k9z7ffcnzi7w7wh2hrks7sglplwn5j6haybjgz0azapa13";
  metaDest = "maven/org/scala-sbt/zinc-persist_2.12/1.1.1/zinc-persist_2.12-1.1.1.pom";
})

(mkBinPackage {
  name = "zinc-persist_2_12_1_2_5";
  pname = "zinc-persist_2.12";
  version = "1.2.5";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/zinc-persist_2.12/1.2.5/zinc-persist_2.12-1.2.5.jar";
  jarSha256 = "155xi28d34cny9z9cb21qly652w9m6rwcjmp2f951gfsb1g9zs4s";
  jarDest = "maven/org/scala-sbt/zinc-persist_2.12/1.2.5/zinc-persist_2.12-1.2.5.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/zinc-persist_2.12/1.2.5/zinc-persist_2.12-1.2.5.pom";
  metaSha256 = "010fjz8hq64a1cd1w3p2nr8bwhmm3z89i261v65m3jx0ddzvcq4h";
  metaDest = "maven/org/scala-sbt/zinc-persist_2.12/1.2.5/zinc-persist_2.12-1.2.5.pom";
})

(mkBinPackage {
  name = "scalastyle_2_12_1_0_0";
  pname = "scalastyle_2.12";
  version = "1.0.0";
  org = "org.scalastyle";
  jarUrl = "https://repo1.maven.org/maven2/org/scalastyle/scalastyle_2.12/1.0.0/scalastyle_2.12-1.0.0.jar";
  jarSha256 = "1jbpyij38zl2d0igywsizd0kbc9291prmnxn07cx71nh50vmvvny";
  jarDest = "maven/org/scalastyle/scalastyle_2.12/1.0.0/scalastyle_2.12-1.0.0.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scalastyle/scalastyle_2.12/1.0.0/scalastyle_2.12-1.0.0.pom";
  metaSha256 = "0czky47ggz5jxn6x66cr12w9c6cybr1qrhxz0dipzmswvb4k86is";
  metaDest = "maven/org/scalastyle/scalastyle_2.12/1.0.0/scalastyle_2.12-1.0.0.pom";
})

(mkBinPackage {
  name = "scalastyle-sbt-plugin_2_12_1_0_1_0_0";
  pname = "scalastyle-sbt-plugin_2.12_1.0";
  version = "1.0.0";
  org = "org.scalastyle";
  jarUrl = "https://repo1.maven.org/maven2/org/scalastyle/scalastyle-sbt-plugin_2.12_1.0/1.0.0/scalastyle-sbt-plugin-1.0.0.jar";
  jarSha256 = "1cjjiacf665445jq97gn2c1skvy2qfwybxj6ayr7xpza0kb0wlbl";
  jarDest = "maven/org/scalastyle/scalastyle-sbt-plugin_2.12_1.0/1.0.0/scalastyle-sbt-plugin-1.0.0.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scalastyle/scalastyle-sbt-plugin_2.12_1.0/1.0.0/scalastyle-sbt-plugin-1.0.0.pom";
  metaSha256 = "0c6c4ax8v2gkab0pqpcr90ci4pp9mjzi61ji6hmiv0jj7y8rs0ng";
  metaDest = "maven/org/scalastyle/scalastyle-sbt-plugin_2.12_1.0/1.0.0/scalastyle-sbt-plugin-1.0.0.pom";
})

(mkBinPackage {
  name = "scalatest_2_12_3_0_1";
  pname = "scalatest_2.12";
  version = "3.0.1";
  org = "org.scalatest";
  jarUrl = "https://repo1.maven.org/maven2/org/scalatest/scalatest_2.12/3.0.1/scalatest_2.12-3.0.1.jar";
  jarSha256 = "0jpjy4ivjmngva1acinrxrylh4vz913kb7kcvzqpq4lzbfkv1f27";
  jarDest = "maven/org/scalatest/scalatest_2.12/3.0.1/scalatest_2.12-3.0.1.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scalatest/scalatest_2.12/3.0.1/scalatest_2.12-3.0.1.pom";
  metaSha256 = "0sxcz7bajcj01w2rw6994608x361l7hnma36vqgy52kfxm0jag87";
  metaDest = "maven/org/scalatest/scalatest_2.12/3.0.1/scalatest_2.12-3.0.1.pom";
})

(mkBinPackage {
  name = "scalatest_2_12_3_0_5";
  pname = "scalatest_2.12";
  version = "3.0.5";
  org = "org.scalatest";
  jarUrl = "https://repo1.maven.org/maven2/org/scalatest/scalatest_2.12/3.0.5/scalatest_2.12-3.0.5.jar";
  jarSha256 = "1r85w0m5m9rs52yf25nkslf2vz2pwhk5g2ldk93dl837xyyba5ml";
  jarDest = "maven/org/scalatest/scalatest_2.12/3.0.5/scalatest_2.12-3.0.5.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scalatest/scalatest_2.12/3.0.5/scalatest_2.12-3.0.5.pom";
  metaSha256 = "1aq29qbdrc4cqhmbphff1dpzgz0yn590xgp8nyvg09hay39bawym";
  metaDest = "maven/org/scalatest/scalatest_2.12/3.0.5/scalatest_2.12-3.0.5.pom";
})

(mkBinPackage {
  name = "sbt-scoverage_2_12_1_0_1_5_1";
  pname = "sbt-scoverage_2.12_1.0";
  version = "1.5.1";
  org = "org.scoverage";
  jarUrl = "https://repo1.maven.org/maven2/org/scoverage/sbt-scoverage_2.12_1.0/1.5.1/sbt-scoverage-1.5.1.jar";
  jarSha256 = "0v2sjhid65jszhr6yk4lzy9j8lsy3ass4g479ljln9wslpqqkxj2";
  jarDest = "maven/org/scoverage/sbt-scoverage_2.12_1.0/1.5.1/sbt-scoverage-1.5.1.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scoverage/sbt-scoverage_2.12_1.0/1.5.1/sbt-scoverage-1.5.1.pom";
  metaSha256 = "18lxg7n1pkb99p2yv5vslkh0mm15b821a43zh85r53lzsvjl54fb";
  metaDest = "maven/org/scoverage/sbt-scoverage_2.12_1.0/1.5.1/sbt-scoverage-1.5.1.pom";
})

(mkBinPackage {
  name = "scalac-scoverage-plugin_2_12_1_3_1";
  pname = "scalac-scoverage-plugin_2.12";
  version = "1.3.1";
  org = "org.scoverage";
  jarUrl = "https://repo1.maven.org/maven2/org/scoverage/scalac-scoverage-plugin_2.12/1.3.1/scalac-scoverage-plugin_2.12-1.3.1.jar";
  jarSha256 = "0icavfahpiq8zrwhihcprs012ykw2r2yqc31fypawsik50127iwz";
  jarDest = "maven/org/scoverage/scalac-scoverage-plugin_2.12/1.3.1/scalac-scoverage-plugin_2.12-1.3.1.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scoverage/scalac-scoverage-plugin_2.12/1.3.1/scalac-scoverage-plugin_2.12-1.3.1.pom";
  metaSha256 = "0r79jkhpn76cqyjzb9dgvr0agnkaidxkk4aan0bxgwapf47zc6y3";
  metaDest = "maven/org/scoverage/scalac-scoverage-plugin_2.12/1.3.1/scalac-scoverage-plugin_2.12-1.3.1.pom";
})

(mkBinPackage {
  name = "slf4j-api_1_7_25";
  pname = "slf4j-api";
  version = "1.7.25";
  org = "org.slf4j";
  jarUrl = "https://repo1.maven.org/maven2/org/slf4j/slf4j-api/1.7.25/slf4j-api-1.7.25.jar";
  jarSha256 = "0yavwayiv5pkbzvlvmqaaqpxsa9xn9xpcbjr2ywac7awbl4s1i0q";
  jarDest = "maven/org/slf4j/slf4j-api/1.7.25/slf4j-api-1.7.25.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/slf4j/slf4j-api/1.7.25/slf4j-api-1.7.25.pom";
  metaSha256 = "07hyr3qlsmfkc28b97vzkhx41kq96ns9320l393gsgfrnnhdgnbw";
  metaDest = "maven/org/slf4j/slf4j-api/1.7.25/slf4j-api-1.7.25.pom";
})

(mkBinPackage {
  name = "slf4j-api_1_7_7";
  pname = "slf4j-api";
  version = "1.7.7";
  org = "org.slf4j";
  jarUrl = "https://repo1.maven.org/maven2/org/slf4j/slf4j-api/1.7.7/slf4j-api-1.7.7.jar";
  jarSha256 = "1zimrxq8bjlp2pwqm0i9ggyanpy2v4bicnb1cn933cd1ih1hr639";
  jarDest = "maven/org/slf4j/slf4j-api/1.7.7/slf4j-api-1.7.7.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/slf4j/slf4j-api/1.7.7/slf4j-api-1.7.7.pom";
  metaSha256 = "1bcq5pa0vjfnbbq96fxhdn7qkka81k9zm05cvk8090y2lskh8f9m";
  metaDest = "maven/org/slf4j/slf4j-api/1.7.7/slf4j-api-1.7.7.pom";
})

(mkBinPackage {
  name = "jawn-parser_2_12_0_10_4";
  pname = "jawn-parser_2.12";
  version = "0.10.4";
  org = "org.spire-math";
  jarUrl = "https://repo1.maven.org/maven2/org/spire-math/jawn-parser_2.12/0.10.4/jawn-parser_2.12-0.10.4.jar";
  jarSha256 = "1cmd7a16n1f4rmzrg4zaayqq7al5brb6ykywpsqlcxjvikggs5y6";
  jarDest = "maven/org/spire-math/jawn-parser_2.12/0.10.4/jawn-parser_2.12-0.10.4.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/spire-math/jawn-parser_2.12/0.10.4/jawn-parser_2.12-0.10.4.pom";
  metaSha256 = "1bn6bmifv3fazg1062a1h31zs83jgf6jfqgw507q1kbvlf6q337g";
  metaDest = "maven/org/spire-math/jawn-parser_2.12/0.10.4/jawn-parser_2.12-0.10.4.pom";
})

(mkBinPackage {
  name = "webjars-locator-core_0_32";
  pname = "webjars-locator-core";
  version = "0.32";
  org = "org.webjars";
  jarUrl = "https://repo1.maven.org/maven2/org/webjars/webjars-locator-core/0.32/webjars-locator-core-0.32.jar";
  jarSha256 = "1clk9a12mbz09bvmpn1p7ba7dgq4rpkl1p44nkp9258qlv3shsy7";
  jarDest = "maven/org/webjars/webjars-locator-core/0.32/webjars-locator-core-0.32.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/webjars/webjars-locator-core/0.32/webjars-locator-core-0.32.pom";
  metaSha256 = "1nl8nwizn262dqvfgvc184sqs7dwmzqa26lydjw4m4dc94iz496q";
  metaDest = "maven/org/webjars/webjars-locator-core/0.32/webjars-locator-core-0.32.pom";
})

(mkBinPackage {
  name = "snakeyaml_1_13";
  pname = "snakeyaml";
  version = "1.13";
  org = "org.yaml";
  jarUrl = "https://repo1.maven.org/maven2/org/yaml/snakeyaml/1.13/snakeyaml-1.13.jar";
  jarSha256 = "1ablq86mh9ahjjg2bnb2r970pxiw1mrn6pnh04iwav51hv0zvggf";
  jarDest = "maven/org/yaml/snakeyaml/1.13/snakeyaml-1.13.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/yaml/snakeyaml/1.13/snakeyaml-1.13.pom";
  metaSha256 = "07g5dzhj6i98p9l96ipqm454d4yr1h8hq6azw8dnn587gv2cl3ns";
  metaDest = "maven/org/yaml/snakeyaml/1.13/snakeyaml-1.13.pom";
})

(mkBinPackage {
  name = "snakeyaml_1_17";
  pname = "snakeyaml";
  version = "1.17";
  org = "org.yaml";
  jarUrl = "https://repo1.maven.org/maven2/org/yaml/snakeyaml/1.17/snakeyaml-1.17.jar";
  jarSha256 = "199hjj2frxg0zm48hjqgkjbdb25myfzkpmqrbbfhcvxlkmpv6rjn";
  jarDest = "maven/org/yaml/snakeyaml/1.17/snakeyaml-1.17.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/yaml/snakeyaml/1.17/snakeyaml-1.17.pom";
  metaSha256 = "1driimlxcigz5ibkhqkxqhc92y07rc2731i10wbz9yvss9jdmins";
  metaDest = "maven/org/yaml/snakeyaml/1.17/snakeyaml-1.17.pom";
})

(mkBinPackage {
  name = "unfiltered_2_12_0_9_1";
  pname = "unfiltered_2.12";
  version = "0.9.1";
  org = "ws.unfiltered";
  jarUrl = "https://repo1.maven.org/maven2/ws/unfiltered/unfiltered_2.12/0.9.1/unfiltered_2.12-0.9.1.jar";
  jarSha256 = "08j4p0xxb0lwjk261dx8xabgkj4sdcvqsrdy4snaciwynmzsar7l";
  jarDest = "maven/ws/unfiltered/unfiltered_2.12/0.9.1/unfiltered_2.12-0.9.1.jar";
  metaUrl = "https://repo1.maven.org/maven2/ws/unfiltered/unfiltered_2.12/0.9.1/unfiltered_2.12-0.9.1.pom";
  metaSha256 = "0zpcvazs2sc20p6qmr6nfcw28dz2z55yh8fzfjbam3fm360g8lvn";
  metaDest = "maven/ws/unfiltered/unfiltered_2.12/0.9.1/unfiltered_2.12-0.9.1.pom";
})

(mkBinPackage {
  name = "unfiltered-directives_2_12_0_9_1";
  pname = "unfiltered-directives_2.12";
  version = "0.9.1";
  org = "ws.unfiltered";
  jarUrl = "https://repo1.maven.org/maven2/ws/unfiltered/unfiltered-directives_2.12/0.9.1/unfiltered-directives_2.12-0.9.1.jar";
  jarSha256 = "14n974z283rbpp9plm5bvi23bgd57vird5z937yj701wzk61qvl1";
  jarDest = "maven/ws/unfiltered/unfiltered-directives_2.12/0.9.1/unfiltered-directives_2.12-0.9.1.jar";
  metaUrl = "https://repo1.maven.org/maven2/ws/unfiltered/unfiltered-directives_2.12/0.9.1/unfiltered-directives_2.12-0.9.1.pom";
  metaSha256 = "1jwr04h4ix686yrijsyr5zld9vza26v66h7r57zlcpr367rmc7ik";
  metaDest = "maven/ws/unfiltered/unfiltered-directives_2.12/0.9.1/unfiltered-directives_2.12-0.9.1.pom";
})

(mkBinPackage {
  name = "unfiltered-filter_2_12_0_9_1";
  pname = "unfiltered-filter_2.12";
  version = "0.9.1";
  org = "ws.unfiltered";
  jarUrl = "https://repo1.maven.org/maven2/ws/unfiltered/unfiltered-filter_2.12/0.9.1/unfiltered-filter_2.12-0.9.1.jar";
  jarSha256 = "1fswbxk1nv2yfaihvswndhlrk2hy2c0i4qw615lynwr7ap6rp8wi";
  jarDest = "maven/ws/unfiltered/unfiltered-filter_2.12/0.9.1/unfiltered-filter_2.12-0.9.1.jar";
  metaUrl = "https://repo1.maven.org/maven2/ws/unfiltered/unfiltered-filter_2.12/0.9.1/unfiltered-filter_2.12-0.9.1.pom";
  metaSha256 = "0plc2yayknjjryfsnkysjaiw7dwqqi8gdrwiwpsancl0ccxvr15g";
  metaDest = "maven/ws/unfiltered/unfiltered-filter_2.12/0.9.1/unfiltered-filter_2.12-0.9.1.pom";
})

(mkBinPackage {
  name = "unfiltered-jetty_2_12_0_9_1";
  pname = "unfiltered-jetty_2.12";
  version = "0.9.1";
  org = "ws.unfiltered";
  jarUrl = "https://repo1.maven.org/maven2/ws/unfiltered/unfiltered-jetty_2.12/0.9.1/unfiltered-jetty_2.12-0.9.1.jar";
  jarSha256 = "1c0piriq15i5b78a90v6aa25gh26jwn8n9i5n0hvkm3mn7x90pf2";
  jarDest = "maven/ws/unfiltered/unfiltered-jetty_2.12/0.9.1/unfiltered-jetty_2.12-0.9.1.jar";
  metaUrl = "https://repo1.maven.org/maven2/ws/unfiltered/unfiltered-jetty_2.12/0.9.1/unfiltered-jetty_2.12-0.9.1.pom";
  metaSha256 = "1py7if552652ids7xs2yx9j4ypyrn7i1dx2q3vy2mbnr96x0p517";
  metaDest = "maven/ws/unfiltered/unfiltered-jetty_2.12/0.9.1/unfiltered-jetty_2.12-0.9.1.pom";
})

(mkBinPackage {
  name = "unfiltered-util_2_12_0_9_1";
  pname = "unfiltered-util_2.12";
  version = "0.9.1";
  org = "ws.unfiltered";
  jarUrl = "https://repo1.maven.org/maven2/ws/unfiltered/unfiltered-util_2.12/0.9.1/unfiltered-util_2.12-0.9.1.jar";
  jarSha256 = "0ivm3gnmnvqvb9i2vykzzhxbzd4lqd5dddwjh2m43sngxx9bsrfk";
  jarDest = "maven/ws/unfiltered/unfiltered-util_2.12/0.9.1/unfiltered-util_2.12-0.9.1.jar";
  metaUrl = "https://repo1.maven.org/maven2/ws/unfiltered/unfiltered-util_2.12/0.9.1/unfiltered-util_2.12-0.9.1.pom";
  metaSha256 = "1ha1s742nxvb0fpr0ssb17s3asm9gc0yklarjxmrp3vmkdvhbipd";
  metaDest = "maven/ws/unfiltered/unfiltered-util_2.12/0.9.1/unfiltered-util_2.12-0.9.1.pom";
})

(mkBinPackage {
  name = "sbt-assembly_0_14_6";
  pname = "sbt-assembly";
  version = "0.14.6";
  org = "com.eed3si9n";
  jarUrl = "https://repo.scala-sbt.org/scalasbt/sbt-plugin-releases/com.eed3si9n/sbt-assembly/scala_2.12/sbt_1.0/0.14.6/jars/sbt-assembly.jar";
  jarSha256 = "197q67bpqn2d3gayjkac0h2k0pijzfkcw7zs29kdhwwfn3gvcpq1";
  jarDest = "ivy2/com.eed3si9n/sbt-assembly/0.14.6/jars/sbt-assembly.jar";
  metaUrl = "https://repo.scala-sbt.org/scalasbt/sbt-plugin-releases/com.eed3si9n/sbt-assembly/scala_2.12/sbt_1.0/0.14.6/ivys/ivy.xml";
  metaSha256 = "1p0kcsv5g6p8f1xi6b4l5rggnzyk2d76a6gca6cyp17rav477ll9";
  metaDest = "ivy2/com.eed3si9n/sbt-assembly/0.14.6/ivys/ivy.xml";
})

(mkBinPackage {
  name = "sbt-buildinfo_0_7_0";
  pname = "sbt-buildinfo";
  version = "0.7.0";
  org = "com.eed3si9n";
  jarUrl = "https://repo.scala-sbt.org/scalasbt/sbt-plugin-releases/com.eed3si9n/sbt-buildinfo/scala_2.12/sbt_1.0/0.7.0/jars/sbt-buildinfo.jar";
  jarSha256 = "1qgcan837m30g7qk9zglhz3jxsv83yd1y7v7pmrfnvdcghkkmrfi";
  jarDest = "ivy2/com.eed3si9n/sbt-buildinfo/0.7.0/jars/sbt-buildinfo.jar";
  metaUrl = "https://repo.scala-sbt.org/scalasbt/sbt-plugin-releases/com.eed3si9n/sbt-buildinfo/scala_2.12/sbt_1.0/0.7.0/ivys/ivy.xml";
  metaSha256 = "0yrymvqwmwhq04x3qqfvdh3j2qjryrp52m4ms8ib8wbrbp3lnhgy";
  metaDest = "ivy2/com.eed3si9n/sbt-buildinfo/0.7.0/ivys/ivy.xml";
})

(mkBinPackage {
  name = "sbt-unidoc_0_4_1";
  pname = "sbt-unidoc";
  version = "0.4.1";
  org = "com.eed3si9n";
  jarUrl = "https://repo.scala-sbt.org/scalasbt/sbt-plugin-releases/com.eed3si9n/sbt-unidoc/scala_2.12/sbt_1.0/0.4.1/jars/sbt-unidoc.jar";
  jarSha256 = "1a1pvd0z0l40jvl1gp68bj396cm0q5ppz4awbz3pag0adci8gfkw";
  jarDest = "ivy2/com.eed3si9n/sbt-unidoc/0.4.1/jars/sbt-unidoc.jar";
  metaUrl = "https://repo.scala-sbt.org/scalasbt/sbt-plugin-releases/com.eed3si9n/sbt-unidoc/scala_2.12/sbt_1.0/0.4.1/ivys/ivy.xml";
  metaSha256 = "13whmngdglfl3qqcxl26wf9wclv78n9gb6x41xrf4dvica668dra";
  metaDest = "ivy2/com.eed3si9n/sbt-unidoc/0.4.1/ivys/ivy.xml";
})

(mkBinPackage {
  name = "sbt-paradox_0_3_0";
  pname = "sbt-paradox";
  version = "0.3.0";
  org = "com.lightbend.paradox";
  jarUrl = "https://repo.scala-sbt.org/scalasbt/sbt-plugin-releases/com.lightbend.paradox/sbt-paradox/scala_2.12/sbt_1.0/0.3.0/jars/sbt-paradox.jar";
  jarSha256 = "07gs0i0rwkcqx43j8p5kz2mvvlhn45xhcfzzsdvk2fgj851d64ak";
  jarDest = "ivy2/com.lightbend.paradox/sbt-paradox/0.3.0/jars/sbt-paradox.jar";
  metaUrl = "https://repo.scala-sbt.org/scalasbt/sbt-plugin-releases/com.lightbend.paradox/sbt-paradox/scala_2.12/sbt_1.0/0.3.0/ivys/ivy.xml";
  metaSha256 = "0qvys41n3hlnmk87vajqbjag6magci9q5iy7dahzj74zjxm0a51h";
  metaDest = "ivy2/com.lightbend.paradox/sbt-paradox/0.3.0/ivys/ivy.xml";
})

(mkBinPackage {
  name = "sbt-antlr4_0_8_1";
  pname = "sbt-antlr4";
  version = "0.8.1";
  org = "com.simplytyped";
  jarUrl = "https://repo.scala-sbt.org/scalasbt/sbt-plugin-releases/com.simplytyped/sbt-antlr4/scala_2.12/sbt_1.0/0.8.1/jars/sbt-antlr4.jar";
  jarSha256 = "14v102483lpn3gxf08506c1xrpxkzzb7xhhz6h9yiwqzidwfvdaf";
  jarDest = "ivy2/com.simplytyped/sbt-antlr4/0.8.1/jars/sbt-antlr4.jar";
  metaUrl = "https://repo.scala-sbt.org/scalasbt/sbt-plugin-releases/com.simplytyped/sbt-antlr4/scala_2.12/sbt_1.0/0.8.1/ivys/ivy.xml";
  metaSha256 = "12j3rjv7phnli9mv84m4xrkpn9a4dimrj3gbczs6qd37j0g5ph1c";
  metaDest = "ivy2/com.simplytyped/sbt-antlr4/0.8.1/ivys/ivy.xml";
})

(mkBinPackage {
  name = "sbt-ghpages_0_6_2";
  pname = "sbt-ghpages";
  version = "0.6.2";
  org = "com.typesafe.sbt";
  jarUrl = "https://repo.scala-sbt.org/scalasbt/sbt-plugin-releases/com.typesafe.sbt/sbt-ghpages/scala_2.12/sbt_1.0/0.6.2/jars/sbt-ghpages.jar";
  jarSha256 = "17piqpwf1sfj48ffji7as1vn3964xq0pxb3vdkvmfw8hw5sw98wa";
  jarDest = "ivy2/com.typesafe.sbt/sbt-ghpages/0.6.2/jars/sbt-ghpages.jar";
  metaUrl = "https://repo.scala-sbt.org/scalasbt/sbt-plugin-releases/com.typesafe.sbt/sbt-ghpages/scala_2.12/sbt_1.0/0.6.2/ivys/ivy.xml";
  metaSha256 = "0q2471pmz5160d8wfaplkisy1n9cpwqqiq62g33mvbmzkgl5kx5j";
  metaDest = "ivy2/com.typesafe.sbt/sbt-ghpages/0.6.2/ivys/ivy.xml";
})

(mkBinPackage {
  name = "sbt-git_0_9_3";
  pname = "sbt-git";
  version = "0.9.3";
  org = "com.typesafe.sbt";
  jarUrl = "https://repo.scala-sbt.org/scalasbt/sbt-plugin-releases/com.typesafe.sbt/sbt-git/scala_2.12/sbt_1.0/0.9.3/jars/sbt-git.jar";
  jarSha256 = "0i2fnk31ppcyj9dphja91mk9phwb6rflszm0ac76vq7vd7gckabx";
  jarDest = "ivy2/com.typesafe.sbt/sbt-git/0.9.3/jars/sbt-git.jar";
  metaUrl = "https://repo.scala-sbt.org/scalasbt/sbt-plugin-releases/com.typesafe.sbt/sbt-git/scala_2.12/sbt_1.0/0.9.3/ivys/ivy.xml";
  metaSha256 = "0q3918awd8grqdapi1yvxiy94kvrxxwk68dgfl37v2x9kg7y0mzn";
  metaDest = "ivy2/com.typesafe.sbt/sbt-git/0.9.3/ivys/ivy.xml";
})

(mkBinPackage {
  name = "sbt-site_1_3_1";
  pname = "sbt-site";
  version = "1.3.1";
  org = "com.typesafe.sbt";
  jarUrl = "https://repo.scala-sbt.org/scalasbt/sbt-plugin-releases/com.typesafe.sbt/sbt-site/scala_2.12/sbt_1.0/1.3.1/jars/sbt-site.jar";
  jarSha256 = "1jqh96w5pqs4j39abyrvimrm93vhl863rrj0v2xcrvwgimqlkxyw";
  jarDest = "ivy2/com.typesafe.sbt/sbt-site/1.3.1/jars/sbt-site.jar";
  metaUrl = "https://repo.scala-sbt.org/scalasbt/sbt-plugin-releases/com.typesafe.sbt/sbt-site/scala_2.12/sbt_1.0/1.3.1/ivys/ivy.xml";
  metaSha256 = "0908npdmnfgkhv55nfdb6m5295mfp166l1hjvdlsbb3wmx0mfl3d";
  metaDest = "ivy2/com.typesafe.sbt/sbt-site/1.3.1/ivys/ivy.xml";
})

(mkBinPackage {
  name = "sbt-web_1_4_2";
  pname = "sbt-web";
  version = "1.4.2";
  org = "com.typesafe.sbt";
  jarUrl = "https://repo.scala-sbt.org/scalasbt/sbt-plugin-releases/com.typesafe.sbt/sbt-web/scala_2.12/sbt_1.0/1.4.2/jars/sbt-web.jar";
  jarSha256 = "13qnj9kk4f9zzd4gfhhcq104n3i4qhxsgg43gbp64a1zm9zi93zv";
  jarDest = "ivy2/com.typesafe.sbt/sbt-web/1.4.2/jars/sbt-web.jar";
  metaUrl = "https://repo.scala-sbt.org/scalasbt/sbt-plugin-releases/com.typesafe.sbt/sbt-web/scala_2.12/sbt_1.0/1.4.2/ivys/ivy.xml";
  metaSha256 = "1m3w573mgwmvh3060lmsb9j2wwgilvli4ixxjhad3rvz0pvmlflk";
  metaDest = "ivy2/com.typesafe.sbt/sbt-web/1.4.2/ivys/ivy.xml";
})

(mkMetadataPackage {
  name = "config_1_2_1";
  pname = "config";
  version = "1.2.1";
  org = "com.typesafe";
  metaUrl = "https://repo1.maven.org/maven2/com/typesafe/config/1.2.1/config-1.2.1.pom";
  metaSha256 = "0g5ahmv3qnw2md5jm3s9yhzkwhlv8k80n585ikzrz1j80kqiwdk2";
  metaDest = "maven/com/typesafe/config/1.2.1/config-1.2.1.pom";
})

(mkMetadataPackage {
  name = "ant-parent_1_9_9";
  pname = "ant-parent";
  version = "1.9.9";
  org = "org.apache.ant";
  metaUrl = "https://repo1.maven.org/maven2/org/apache/ant/ant-parent/1.9.9/ant-parent-1.9.9.pom";
  metaSha256 = "0layp9p8yb5yq3q0wh5znqg94lxl24mk2lb6l6zzfk4yh9ppqq6f";
  metaDest = "maven/org/apache/ant/ant-parent/1.9.9/ant-parent-1.9.9.pom";
})

(mkMetadataPackage {
  name = "commons-parent_35";
  pname = "commons-parent";
  version = "35";
  org = "org.apache.commons";
  metaUrl = "https://repo1.maven.org/maven2/org/apache/commons/commons-parent/35/commons-parent-35.pom";
  metaSha256 = "16p48k5ly6yli1wlzb5qcipwd0lzhsnbrjr1vk4x9v1nhfms363h";
  metaDest = "maven/org/apache/commons/commons-parent/35/commons-parent-35.pom";
})

(mkMetadataPackage {
  name = "httpcomponents-client_4_3_6";
  pname = "httpcomponents-client";
  version = "4.3.6";
  org = "org.apache.httpcomponents";
  metaUrl = "https://repo1.maven.org/maven2/org/apache/httpcomponents/httpcomponents-client/4.3.6/httpcomponents-client-4.3.6.pom";
  metaSha256 = "0qycmd85darwdfqqh67wwsfh4ix6xgf82z0wi4k9hcwnnhkjinja";
  metaDest = "maven/org/apache/httpcomponents/httpcomponents-client/4.3.6/httpcomponents-client-4.3.6.pom";
})

(mkMetadataPackage {
  name = "maven_3_3_9";
  pname = "maven";
  version = "3.3.9";
  org = "org.apache.maven";
  metaUrl = "https://repo1.maven.org/maven2/org/apache/maven/maven/3.3.9/maven-3.3.9.pom";
  metaSha256 = "04ywjs7nywn17rcxwnqkrvyjlqdl9n2n7sbz3n6biwl0bhddg1r3";
  metaDest = "maven/org/apache/maven/maven/3.3.9/maven-3.3.9.pom";
})

(mkMetadataPackage {
  name = "jetty-project_9_2_21_v20170120";
  pname = "jetty-project";
  version = "9.2.21.v20170120";
  org = "org.eclipse.jetty";
  metaUrl = "https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-project/9.2.21.v20170120/jetty-project-9.2.21.v20170120.pom";
  metaSha256 = "0lha2yqv9lncghb6xcfmb7yxhn9js6xilhzw6dhc5xnwk8s79dd9";
  metaDest = "maven/org/eclipse/jetty/jetty-project/9.2.21.v20170120/jetty-project-9.2.21.v20170120.pom";
})

(mkMetadataPackage {
  name = "org_eclipse_jgit-parent_4_5_0_201609210915-r";
  pname = "org.eclipse.jgit-parent";
  version = "4.5.0.201609210915-r";
  org = "org.eclipse.jgit";
  metaUrl = "https://repo1.maven.org/maven2/org/eclipse/jgit/org.eclipse.jgit-parent/4.5.0.201609210915-r/org.eclipse.jgit-parent-4.5.0.201609210915-r.pom";
  metaSha256 = "1sli4l3cpjdlfp4fq5z71f474j78lmd3z8d8q4glih4fq6dhli2l";
  metaDest = "maven/org/eclipse/jgit/org.eclipse.jgit-parent/4.5.0.201609210915-r/org.eclipse.jgit-parent-4.5.0.201609210915-r.pom";
})

(mkMetadataPackage {
  name = "jruby-artifacts_1_7_21";
  pname = "jruby-artifacts";
  version = "1.7.21";
  org = "org.jruby";
  metaUrl = "https://repo1.maven.org/maven2/org/jruby/jruby-artifacts/1.7.21/jruby-artifacts-1.7.21.pom";
  metaSha256 = "16z33jdlj55a98yyyskfjmraapbmin56rsnmw9ymrh4ab78vhf1f";
  metaDest = "maven/org/jruby/jruby-artifacts/1.7.21/jruby-artifacts-1.7.21.pom";
})

(mkMetadataPackage {
  name = "asm-parent_5_0_3";
  pname = "asm-parent";
  version = "5.0.3";
  org = "org.ow2.asm";
  metaUrl = "https://repo1.maven.org/maven2/org/ow2/asm/asm-parent/5.0.3/asm-parent-5.0.3.pom";
  metaSha256 = "0clf3252nhw52k34vhjsm4mj8kz9casvkc5lp3s4slwa2bsapvf2";
  metaDest = "maven/org/ow2/asm/asm-parent/5.0.3/asm-parent-5.0.3.pom";
})

(mkMetadataPackage {
  name = "asm-parent_6_0";
  pname = "asm-parent";
  version = "6.0";
  org = "org.ow2.asm";
  metaUrl = "https://repo1.maven.org/maven2/org/ow2/asm/asm-parent/6.0/asm-parent-6.0.pom";
  metaSha256 = "053xrln1w9nj0aw23wsiqkgn8569fk6zx7mw8dns9jgcp55hc7br";
  metaDest = "maven/org/ow2/asm/asm-parent/6.0/asm-parent-6.0.pom";
})

(mkMetadataPackage {
  name = "slf4j-api_1_7_2";
  pname = "slf4j-api";
  version = "1.7.2";
  org = "org.slf4j";
  metaUrl = "https://repo1.maven.org/maven2/org/slf4j/slf4j-api/1.7.2/slf4j-api-1.7.2.pom";
  metaSha256 = "0k2xgjwg7mz8ri1abhw1ikrniliqg28gzsfqmgs1c58azqdagb1f";
  metaDest = "maven/org/slf4j/slf4j-api/1.7.2/slf4j-api-1.7.2.pom";
})

(mkMetadataPackage {
  name = "oss-parent_3";
  pname = "oss-parent";
  version = "3";
  org = "org.sonatype.oss";
  metaUrl = "https://repo1.maven.org/maven2/org/sonatype/oss/oss-parent/3/oss-parent-3.pom";
  metaSha256 = "1pmf9n7hshrlckk59adkq80cqp3iqs9p168nc5265560cy98h9qc";
  metaDest = "maven/org/sonatype/oss/oss-parent/3/oss-parent-3.pom";
})

(mkMetadataPackage {
  name = "oss-parent_5";
  pname = "oss-parent";
  version = "5";
  org = "org.sonatype.oss";
  metaUrl = "https://repo1.maven.org/maven2/org/sonatype/oss/oss-parent/5/oss-parent-5.pom";
  metaSha256 = "0g8da9zsimg7drhsnzivb2c874jda96frbii05iqlpaq189d8y0n";
  metaDest = "maven/org/sonatype/oss/oss-parent/5/oss-parent-5.pom";
})

(mkMetadataPackage {
  name = "oss-parent_6";
  pname = "oss-parent";
  version = "6";
  org = "org.sonatype.oss";
  metaUrl = "https://repo1.maven.org/maven2/org/sonatype/oss/oss-parent/6/oss-parent-6.pom";
  metaSha256 = "16c4i8n978zfb788i6lrwv9b6qgirzqnc25kl5c28fgmx09nsc5l";
  metaDest = "maven/org/sonatype/oss/oss-parent/6/oss-parent-6.pom";
})

(mkMetadataPackage {
  name = "oss-parent_7";
  pname = "oss-parent";
  version = "7";
  org = "org.sonatype.oss";
  metaUrl = "https://repo1.maven.org/maven2/org/sonatype/oss/oss-parent/7/oss-parent-7.pom";
  metaSha256 = "0m4lallnlhyfj3z24ispxzwvsxzaznhw6zsmk4j74sibr5kqh7xm";
  metaDest = "maven/org/sonatype/oss/oss-parent/7/oss-parent-7.pom";
})

(mkMetadataPackage {
  name = "oss-parent_9";
  pname = "oss-parent";
  version = "9";
  org = "org.sonatype.oss";
  metaUrl = "https://repo1.maven.org/maven2/org/sonatype/oss/oss-parent/9/oss-parent-9.pom";
  metaSha256 = "0yl2hbwz2kn1hll1i00ddzn8f89bfdcjwdifz0pj2j15k1gjch7v";
  metaDest = "maven/org/sonatype/oss/oss-parent/9/oss-parent-9.pom";
})

(mkMetadataPackage {
  name = "jackson-parent_2_7";
  pname = "jackson-parent";
  version = "2.7";
  org = "com.fasterxml.jackson";
  metaUrl = "https://repo1.maven.org/maven2/com/fasterxml/jackson/jackson-parent/2.7/jackson-parent-2.7.pom";
  metaSha256 = "0yzqfxfyz8092ar5ls9agjsi230n0bak6l9k3r2k4r6achf2d51q";
  metaDest = "maven/com/fasterxml/jackson/jackson-parent/2.7/jackson-parent-2.7.pom";
})

(mkMetadataPackage {
  name = "antlr-master_3_5_2";
  pname = "antlr-master";
  version = "3.5.2";
  org = "org.antlr";
  metaUrl = "https://repo1.maven.org/maven2/org/antlr/antlr-master/3.5.2/antlr-master-3.5.2.pom";
  metaSha256 = "1mhv6gqiwdrgypibcwxxhbrfh25rqc1a06jlkfq0w4553r9imna2";
  metaDest = "maven/org/antlr/antlr-master/3.5.2/antlr-master-3.5.2.pom";
})

(mkMetadataPackage {
  name = "apache_15";
  pname = "apache";
  version = "15";
  org = "org.apache";
  metaUrl = "https://repo1.maven.org/maven2/org/apache/apache/15/apache-15.pom";
  metaSha256 = "156lk89x31r2d6ljpwl1lvrl0sxgkd70wj6bq18b8rxcg7wz5hin";
  metaDest = "maven/org/apache/apache/15/apache-15.pom";
})

(mkMetadataPackage {
  name = "commons-parent_22";
  pname = "commons-parent";
  version = "22";
  org = "org.apache.commons";
  metaUrl = "https://repo1.maven.org/maven2/org/apache/commons/commons-parent/22/commons-parent-22.pom";
  metaSha256 = "1frwdic537d95l0ikgkvfpb4wjfjx2h5h211zysdsyhawdamx37v";
  metaDest = "maven/org/apache/commons/commons-parent/22/commons-parent-22.pom";
})

(mkMetadataPackage {
  name = "commons-parent_34";
  pname = "commons-parent";
  version = "34";
  org = "org.apache.commons";
  metaUrl = "https://repo1.maven.org/maven2/org/apache/commons/commons-parent/34/commons-parent-34.pom";
  metaSha256 = "175p0hnjk93gmgh8fv63z0xmd9jf5sgdq9ii54xiy7b4dp86jbis";
  metaDest = "maven/org/apache/commons/commons-parent/34/commons-parent-34.pom";
})

(mkMetadataPackage {
  name = "project_7";
  pname = "project";
  version = "7";
  org = "org.apache.httpcomponents";
  metaUrl = "https://repo1.maven.org/maven2/org/apache/httpcomponents/project/7/project-7.pom";
  metaSha256 = "1hs8m8cgyypd6vb882zjyns58nhzrkm7cpbb0kg5i9amhm1blvix";
  metaDest = "maven/org/apache/httpcomponents/project/7/project-7.pom";
})

(mkMetadataPackage {
  name = "maven-parent_27";
  pname = "maven-parent";
  version = "27";
  org = "org.apache.maven";
  metaUrl = "https://repo1.maven.org/maven2/org/apache/maven/maven-parent/27/maven-parent-27.pom";
  metaSha256 = "185qs7haas52g29j2k7gcy7b62fbl674a9yl9pfajjf44k27x62n";
  metaDest = "maven/org/apache/maven/maven-parent/27/maven-parent-27.pom";
})

(mkMetadataPackage {
  name = "jetty-parent_23";
  pname = "jetty-parent";
  version = "23";
  org = "org.eclipse.jetty";
  metaUrl = "https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-parent/23/jetty-parent-23.pom";
  metaSha256 = "0lccvbg0jbj3hbrh3bam8pjjy45cwzvh7r1zc8n6cb3kyf59s8pz";
  metaDest = "maven/org/eclipse/jetty/jetty-parent/23/jetty-parent-23.pom";
})

(mkMetadataPackage {
  name = "jruby-parent_1_7_21";
  pname = "jruby-parent";
  version = "1.7.21";
  org = "org.jruby";
  metaUrl = "https://repo1.maven.org/maven2/org/jruby/jruby-parent/1.7.21/jruby-parent-1.7.21.pom";
  metaSha256 = "0zj5gj1rnzp541533hjr9s6p5f7jm9qiqf6yw9wpl53wq8p203g7";
  metaDest = "maven/org/jruby/jruby-parent/1.7.21/jruby-parent-1.7.21.pom";
})

(mkMetadataPackage {
  name = "ow2_1_3";
  pname = "ow2";
  version = "1.3";
  org = "org.ow2";
  metaUrl = "https://repo1.maven.org/maven2/org/ow2/ow2/1.3/ow2-1.3.pom";
  metaSha256 = "1yr8hfx8gffpppa4ii6cvrsq029a6x8hzy7nsavxhs60s9kmq8ai";
  metaDest = "maven/org/ow2/ow2/1.3/ow2-1.3.pom";
})

(mkMetadataPackage {
  name = "slf4j-parent_1_7_2";
  pname = "slf4j-parent";
  version = "1.7.2";
  org = "org.slf4j";
  metaUrl = "https://repo1.maven.org/maven2/org/slf4j/slf4j-parent/1.7.2/slf4j-parent-1.7.2.pom";
  metaSha256 = "09a4k3if2llczb019p21hr3r1q7cl192ncw54vjav113dx50i3hx";
  metaDest = "maven/org/slf4j/slf4j-parent/1.7.2/slf4j-parent-1.7.2.pom";
})

(mkMetadataPackage {
  name = "slf4j-parent_1_7_7";
  pname = "slf4j-parent";
  version = "1.7.7";
  org = "org.slf4j";
  metaUrl = "https://repo1.maven.org/maven2/org/slf4j/slf4j-parent/1.7.7/slf4j-parent-1.7.7.pom";
  metaSha256 = "1m1k7nkwc73mr6bza02nznzr9lfryn68k5hw4rz59l38wwyaxzqx";
  metaDest = "maven/org/slf4j/slf4j-parent/1.7.7/slf4j-parent-1.7.7.pom";
})

(mkMetadataPackage {
  name = "oss-parent_25";
  pname = "oss-parent";
  version = "25";
  org = "com.fasterxml";
  metaUrl = "https://repo1.maven.org/maven2/com/fasterxml/oss-parent/25/oss-parent-25.pom";
  metaSha256 = "0h4sf9hdhbffhjrfqdnjhrkr6smqr837nmn2dn4zwkmwp6bn0hfw";
  metaDest = "maven/com/fasterxml/oss-parent/25/oss-parent-25.pom";
})

(mkMetadataPackage {
  name = "jvnet-parent_3";
  pname = "jvnet-parent";
  version = "3";
  org = "net.java";
  metaUrl = "https://repo1.maven.org/maven2/net/java/jvnet-parent/3/jvnet-parent-3.pom";
  metaSha256 = "0nj7958drckwf634cw9gmwgmdi302bya7bas16bbzp9rzag7ix9h";
  metaDest = "maven/net/java/jvnet-parent/3/jvnet-parent-3.pom";
})

(mkMetadataPackage {
  name = "apache_13";
  pname = "apache";
  version = "13";
  org = "org.apache";
  metaUrl = "https://repo1.maven.org/maven2/org/apache/apache/13/apache-13.pom";
  metaSha256 = "07c4yg52q1qiz2b982pcsiwf9ahmpil4jy7lpqvi5m0z6sq3slgz";
  metaDest = "maven/org/apache/apache/13/apache-13.pom";
})

(mkMetadataPackage {
  name = "apache_17";
  pname = "apache";
  version = "17";
  org = "org.apache";
  metaUrl = "https://repo1.maven.org/maven2/org/apache/apache/17/apache-17.pom";
  metaSha256 = "0gylw31fy16mk7hqzmxmi8qz7qp54j0y12i1pqk96was9fvl901r";
  metaDest = "maven/org/apache/apache/17/apache-17.pom";
})

(mkMetadataPackage {
  name = "apache_9";
  pname = "apache";
  version = "9";
  org = "org.apache";
  metaUrl = "https://repo1.maven.org/maven2/org/apache/apache/9/apache-9.pom";
  metaSha256 = "1p8qrz7swd6ylwfiv6x4kr3gip6sy2vca8xwydlxm3kwah5fcij9";
  metaDest = "maven/org/apache/apache/9/apache-9.pom";
})

(mkMetadataPackage {
  name = "commons-codec_1_6";
  pname = "commons-codec";
  version = "1.6";
  org = "commons-codec";
  metaUrl = "https://repo1.maven.org/maven2/commons-codec/commons-codec/1.6/commons-codec-1.6.pom";
  metaSha256 = "1298qykf61rrg2p3jnschq659ycqwkryp528v49vi9pkzz9kavm0";
  metaDest = "maven/commons-codec/commons-codec/1.6/commons-codec-1.6.pom";
})

(mkMetadataPackage {
  name = "commons-parent_28";
  pname = "commons-parent";
  version = "28";
  org = "org.apache.commons";
  metaUrl = "https://repo1.maven.org/maven2/org/apache/commons/commons-parent/28/commons-parent-28.pom";
  metaSha256 = "1iw6zsx6j4hbfmmcrin10cpz7p2644i6vn8cwsfvc85ix1l3lwql";
  metaDest = "maven/org/apache/commons/commons-parent/28/commons-parent-28.pom";
})

(mkMetadataPackage {
  name = "commons-parent_37";
  pname = "commons-parent";
  version = "37";
  org = "org.apache.commons";
  metaUrl = "https://repo1.maven.org/maven2/org/apache/commons/commons-parent/37/commons-parent-37.pom";
  metaSha256 = "0jq1km499fjm0mn6s33vrr2v27l6j1brs96ir2fcv3cdsr6mlw7f";
  metaDest = "maven/org/apache/commons/commons-parent/37/commons-parent-37.pom";
})

(mkMetadataPackage {
  name = "httpcomponents-core_4_3_3";
  pname = "httpcomponents-core";
  version = "4.3.3";
  org = "org.apache.httpcomponents";
  metaUrl = "https://repo1.maven.org/maven2/org/apache/httpcomponents/httpcomponents-core/4.3.3/httpcomponents-core-4.3.3.pom";
  metaSha256 = "0cfh3pgrchpjb2g6z2ijacsng7ssb002cpjvxwna19wvsk02yvn1";
  metaDest = "maven/org/apache/httpcomponents/httpcomponents-core/4.3.3/httpcomponents-core-4.3.3.pom";
})

(mkMetadataPackage {
  name = "plexus_3_3_1";
  pname = "plexus";
  version = "3.3.1";
  org = "org.codehaus.plexus";
  metaUrl = "https://repo1.maven.org/maven2/org/codehaus/plexus/plexus/3.3.1/plexus-3.3.1.pom";
  metaSha256 = "1fqnx2yyynsrg683zik56ni5mc7i8zji8z0n1gwm14n2kf46zjbf";
  metaDest = "maven/org/codehaus/plexus/plexus/3.3.1/plexus-3.3.1.pom";
})

(mkMetadataPackage {
  name = "sisu-plexus_0_3_2";
  pname = "sisu-plexus";
  version = "0.3.2";
  org = "org.eclipse.sisu";
  metaUrl = "https://repo1.maven.org/maven2/org/eclipse/sisu/sisu-plexus/0.3.2/sisu-plexus-0.3.2.pom";
  metaSha256 = "057spkshknfj8w3nicd5ks1s33n6ymszj7fc0ysig4xzvmxbqy14";
  metaDest = "maven/org/eclipse/sisu/sisu-plexus/0.3.2/sisu-plexus-0.3.2.pom";
})

(mkMetadataPackage {
  name = "apache_16";
  pname = "apache";
  version = "16";
  org = "org.apache";
  metaUrl = "https://repo1.maven.org/maven2/org/apache/apache/16/apache-16.pom";
  metaSha256 = "03m4fjgg98zcyjlsp64z21lyiszhwyg43ys7mabk1jynswpzz1cz";
  metaDest = "maven/org/apache/apache/16/apache-16.pom";
})

(mkMetadataPackage {
  name = "plexus-containers_1_5_5";
  pname = "plexus-containers";
  version = "1.5.5";
  org = "org.codehaus.plexus";
  metaUrl = "https://repo1.maven.org/maven2/org/codehaus/plexus/plexus-containers/1.5.5/plexus-containers-1.5.5.pom";
  metaSha256 = "1vxmg13pvvlsick6lcj3pj66672lbhbkhn2gdz5b0xn89s169hhv";
  metaDest = "maven/org/codehaus/plexus/plexus-containers/1.5.5/plexus-containers-1.5.5.pom";
})

(mkMetadataPackage {
  name = "sisu-inject_0_3_2";
  pname = "sisu-inject";
  version = "0.3.2";
  org = "org.eclipse.sisu";
  metaUrl = "https://repo1.maven.org/maven2/org/eclipse/sisu/sisu-inject/0.3.2/sisu-inject-0.3.2.pom";
  metaSha256 = "0mmbq3fpcj1bpcxxrdi7bp3k59w9dydibp24asnk5y1bhfxpj4zy";
  metaDest = "maven/org/eclipse/sisu/sisu-inject/0.3.2/sisu-inject-0.3.2.pom";
})

(mkMetadataPackage {
  name = "weld-api-parent_1_0";
  pname = "weld-api-parent";
  version = "1.0";
  org = "org.jboss.weld";
  metaUrl = "https://repo1.maven.org/maven2/org/jboss/weld/weld-api-parent/1.0/weld-api-parent-1.0.pom";
  metaSha256 = "1ha2d4lzqrmw6r44y4kgnjf6ic2n09i8fpimfnd00axsdz9dpc0z";
  metaDest = "maven/org/jboss/weld/weld-api-parent/1.0/weld-api-parent-1.0.pom";
})

(mkMetadataPackage {
  name = "spice-parent_17";
  pname = "spice-parent";
  version = "17";
  org = "org.sonatype.spice";
  metaUrl = "https://repo1.maven.org/maven2/org/sonatype/spice/spice-parent/17/spice-parent-17.pom";
  metaSha256 = "1pwvjq4qjfq53c345k6b74nj9c2g2ibgqhl8fzl6xhrynfjzjlci";
  metaDest = "maven/org/sonatype/spice/spice-parent/17/spice-parent-17.pom";
})

(mkMetadataPackage {
  name = "forge-parent_10";
  pname = "forge-parent";
  version = "10";
  org = "org.sonatype.forge";
  metaUrl = "https://repo1.maven.org/maven2/org/sonatype/forge/forge-parent/10/forge-parent-10.pom";
  metaSha256 = "02xx8rq6wpc6d97wpk7d27w03zqcgkdid5303wjh7k2r5g1vjky1";
  metaDest = "maven/org/sonatype/forge/forge-parent/10/forge-parent-10.pom";
})

(mkMetadataPackage {
  name = "weld-api-bom_1_0";
  pname = "weld-api-bom";
  version = "1.0";
  org = "org.jboss.weld";
  metaUrl = "https://repo1.maven.org/maven2/org/jboss/weld/weld-api-bom/1.0/weld-api-bom-1.0.pom";
  metaSha256 = "163vylps0c896ckgi66kd0kifzii9swv3xxrd1hkf1y1cwxdqx4g";
  metaDest = "maven/org/jboss/weld/weld-api-bom/1.0/weld-api-bom-1.0.pom";
})

(mkMetadataPackage {
  name = "plexus_2_0_7";
  pname = "plexus";
  version = "2.0.7";
  org = "org.codehaus.plexus";
  metaUrl = "https://repo1.maven.org/maven2/org/codehaus/plexus/plexus/2.0.7/plexus-2.0.7.pom";
  metaSha256 = "0x4arhayg4spy9jrlww8cj96hqvh44ja4ywps32ia2mb60h0cn9b";
  metaDest = "maven/org/codehaus/plexus/plexus/2.0.7/plexus-2.0.7.pom";
})

(mkMetadataPackage {
  name = "forge-parent_10";
  pname = "forge-parent";
  version = "10";
  org = "org.sonatype.forge";
  metaUrl = "https://repo1.maven.org/maven2/org/sonatype/forge/forge-parent/10/forge-parent-10.pom";
  metaSha256 = "02xx8rq6wpc6d97wpk7d27w03zqcgkdid5303wjh7k2r5g1vjky1";
  metaDest = "maven/org/sonatype/forge/forge-parent/10/forge-parent-10.pom";
})

(mkMetadataPackage {
  name = "weld-parent_6";
  pname = "weld-parent";
  version = "6";
  org = "org.jboss.weld";
  metaUrl = "https://repo1.maven.org/maven2/org/jboss/weld/weld-parent/6/weld-parent-6.pom";
  metaSha256 = "12305a41rn4dfhdjay2mrachb8m5bdy9nqy3cnmmqhd3g3cn9avl";
  metaDest = "maven/org/jboss/weld/weld-parent/6/weld-parent-6.pom";
})

(mkMetadataPackage {
  name = "logback-parent_1_2_3";
  pname = "logback-parent";
  version = "1.2.3";
  org = "ch.qos.logback";
  metaUrl = "https://repo1.maven.org/maven2/ch/qos/logback/logback-parent/1.2.3/logback-parent-1.2.3.pom";
  metaSha256 = "0smjx8smdi42xr4a6japk5rxyf56p86dfgyx7ifjbc67mwfh5kbr";
  metaDest = "maven/ch/qos/logback/logback-parent/1.2.3/logback-parent-1.2.3.pom";
})

(mkMetadataPackage {
  name = "paranamer-parent_2_8";
  pname = "paranamer-parent";
  version = "2.8";
  org = "com.thoughtworks.paranamer";
  metaUrl = "https://repo1.maven.org/maven2/com/thoughtworks/paranamer/paranamer-parent/2.8/paranamer-parent-2.8.pom";
  metaSha256 = "1kgp1366nfb40acpq0ww43c9ksi0vjk92ch64y6s5ljv3cfg157h";
  metaDest = "maven/com/thoughtworks/paranamer/paranamer-parent/2.8/paranamer-parent-2.8.pom";
})

(mkMetadataPackage {
  name = "antlr4-master_4_7_1";
  pname = "antlr4-master";
  version = "4.7.1";
  org = "org.antlr";
  metaUrl = "https://repo1.maven.org/maven2/org/antlr/antlr4-master/4.7.1/antlr4-master-4.7.1.pom";
  metaSha256 = "1346l3gaw3akk550q98wlz7l4rr5lywqg7diq6ycixhkyixzc9j1";
  metaDest = "maven/org/antlr/antlr4-master/4.7.1/antlr4-master-4.7.1.pom";
})

(mkMetadataPackage {
  name = "json_1_0_4";
  pname = "json";
  version = "1.0.4";
  org = "org.glassfish";
  metaUrl = "https://repo1.maven.org/maven2/org/glassfish/json/1.0.4/json-1.0.4.pom";
  metaSha256 = "1rkjm75b5a2m0kvljfn0gqhqbiml4jcqakwlimqj3y8m6516hz3d";
  metaDest = "maven/org/glassfish/json/1.0.4/json-1.0.4.pom";
})

(mkBinPackage {
  name = "util-interface_1_2_2";
  pname = "util-interface";
  version = "1.2.2";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/util-interface/1.2.2/util-interface-1.2.2.jar";
  jarSha256 = "1mrcxv8wnnmglw457c18ascds025najcdk066nrz4a50g5gqxcdd";
  jarDest = "maven/org/scala-sbt/util-interface/1.2.2/util-interface-1.2.2.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/util-interface/1.2.2/util-interface-1.2.2.pom";
  metaSha256 = "1dwvgv60gcwb0by1xn6gs4hrz4pcf4q53rx02y6c3z43yfbfrsbx";
  metaDest = "maven/org/scala-sbt/util-interface/1.2.2/util-interface-1.2.2.pom";
})

(mkBinPackage {
  name = "compiler-bridge_2_12_1_2_5";
  pname = "compiler-bridge_2.12";
  version = "1.2.5";
  org = "org.scala-sbt";
  jarUrl = "https://repo1.maven.org/maven2/org/scala-sbt/compiler-bridge_2.12/1.2.5/compiler-bridge_2.12-1.2.5-sources.jar";
  jarSha256 = "1ri8lmfbv8awb67sl6wdsfp4p2xr666k53vhs45kf31dq9ydi2a5";
  jarDest = "maven/org/scala-sbt/compiler-bridge_2.12/1.2.5/compiler-bridge_2.12-1.2.5-sources.jar";
  metaUrl = "https://repo1.maven.org/maven2/org/scala-sbt/compiler-bridge_2.12/1.2.5/compiler-bridge_2.12-1.2.5.pom";
  metaSha256 = "15wcybpq9lbiqr9a3l1cq5vb4cifv5h1qh04i5flpwff7knviygb";
  metaDest = "maven/org/scala-sbt/compiler-bridge_2.12/1.2.5/compiler-bridge_2.12-1.2.5.pom";
})

(mkBinPackage {
  name = "sbt-protobuf_0_6_3";
  pname = "sbt-protobuf";
  version = "0.6.3";
  org = "com.github.gseitz";
  jarUrl = "https://repo.scala-sbt.org/scalasbt/sbt-plugin-releases/com.github.gseitz/sbt-protobuf/scala_2.12/sbt_1.0/0.6.3/jars/sbt-protobuf.jar";
  jarSha256 = "04yhlf1m3384x4f4r8wa8iz6kpjnl8rgdgwxqgr3vgz84fsf0r2s";
  jarDest = "ivy2/com.github.gseitz/sbt-protobuf/0.6.3/jars/sbt-protobuf.jar";
  metaUrl = "https://repo.scala-sbt.org/scalasbt/sbt-plugin-releases/com.github.gseitz/sbt-protobuf/scala_2.12/sbt_1.0/0.6.3/ivys/ivy.xml";
  metaSha256 = "1y2lmymz8f9ncz5hsi5n83z1qvgakvak75245s0yx3d02pbp79d0";
  metaDest = "ivy2/com.github.gseitz/sbt-protobuf/0.6.3/ivys/ivy.xml";
})

(mkMetadataPackage {
  name = "protobuf-parent_3_4_0";
  pname = "protobuf-parent";
  version = "3.4.0";
  org = "com.google.protobuf";
  metaUrl = "https://repo1.maven.org/maven2/com/google/protobuf/protobuf-parent/3.4.0/protobuf-parent-3.4.0.pom";
  metaSha256 = "0irsayf19snivcmhyr6122d5mvyb8cd677bn9ixfph2251arr414";
  metaDest = "maven/com/google/protobuf/protobuf-parent/3.4.0/protobuf-parent-3.4.0.pom";
})

(mkMetadataPackage {
  name = "google_1";
  pname = "google";
  version = "1";
  org = "com.google";
  metaUrl = "https://repo1.maven.org/maven2/com/google/google/1/google-1.pom";
  metaSha256 = "10by4ybrjnl8zwfg4ca74d0gcl4p9l7dzlfb9iwxw7m325xb2vfd";
  metaDest = "maven/com/google/google/1/google-1.pom";
})

(mkBinPackage {
  name = "scopt_2_12_3_6_0";
  pname = "scopt_2.12";
  version = "3.6.0";
  org = "com.github.scopt";
  jarUrl = "https://repo1.maven.org/maven2/com/github/scopt/scopt_2.12/3.6.0/scopt_2.12-3.6.0.jar";
  jarSha256 = "0zglmdsyxggk6amy4l3g7igdqglr08hxn3qjvycx7yzsgkhy3f5g";
  jarDest = "maven/com/github/scopt/scopt_2.12/3.6.0/scopt_2.12-3.6.0.jar";
  metaUrl = "https://repo1.maven.org/maven2/com/github/scopt/scopt_2.12/3.6.0/scopt_2.12-3.6.0.pom";
  metaSha256 = "127wm698yr2qqymdb6ayf5668qv28s85f8dr4c14ijsgys1xfk8p";
  metaDest = "maven/com/github/scopt/scopt_2.12/3.6.0/scopt_2.12-3.6.0.pom";
})

]
