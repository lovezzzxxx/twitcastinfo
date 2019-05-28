# twitcastinfo
获取twitcasting频道的历史直播信息（是否有录播，直播链接，直播标题，直播时间）

### 方法  
`./twitcastinfo.sh "频道号码"`  
### 示例  
`./twitcastinfo.sh "c:annuuuu_cas" > twitcastinfo_c:annuuuu_cas.txt`
### 输出格式示例
是否有录播	直播链接	直播标题	直播时间
```
NO RECORD	/c:annuuuu_cas/movie/542757145		Radio む  初見さん捕まえる！ #542757145
NO RECORD	/c:annuuuu_cas/movie/542755210		Radio む  初見さん捕まえる！ #542755210
RECORD	/c:annuuuu_cas/movie/542750312	2019/05/06 07:40:33	おはよん
RECORD	/c:annuuuu_cas/movie/542678156	2019/05/05 23:38:49	寝落ち〇雑談〇
RECORD	/c:annuuuu_cas/movie/542657480	2019/05/05 22:39:24	初見さん捕まえる！
NO RECORD	/c:annuuuu_cas/movie/542518205		Radio 寝落ち〇雑談〇 #542518205
NO RECORD	/c:annuuuu_cas/movie/542518180		Radio 寝落ち〇雑談〇 #542518180
NO RECORD	/c:annuuuu_cas/movie/542518153		Radio 寝落ち〇雑談〇 #542518153
NO RECORD	/c:annuuuu_cas/movie/542518129		Radio 寝落ち〇雑談〇 #542518129
```
