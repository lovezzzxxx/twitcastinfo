# twitcastinfo
获取twitcasting频道的历史直播信息（是否有录播，直播链接，直播标题，直播时间）

### 方法  
`./twitcastinfo.sh "频道号码"`  
### 示例  
`./twitcastinfo.sh "c:annuuuu_cas" > twitcastinfo_c:annuuuu_cas.txt`
### 输出格式示例
是否有录播，直播链接，直播时间，直播标题
```
NO_REC	/c:annuuuu_cas/movie/535219011	2019/03/30 17:07:35	Radio 初見さん捕まえる #535219011
NO_REC	/c:annuuuu_cas/movie/535194932	2019/03/30 14:37:23	Radio 初見さん捕まえる #535194932
RECORD	/c:annuuuu_cas/movie/535080025	2019/03/29 23:31:43	Radio 寝落ち、雑談〇 #535080025
NO_REC	/c:annuuuu_cas/movie/534996481	2019/03/29 17:48:05	Radio 初見さん捕まえる！ #534996481
NO_REC	/c:annuuuu_cas/movie/534907869	2019/03/29 03:11:17	Radio #534907869
NO_REC	/c:annuuuu_cas/movie/534905830	2019/03/29 02:55:29	Radio 添い寝 #534905830
NO_REC	/c:annuuuu_cas/movie/534868523	2019/03/29 00:09:20	Live 寝落ち、雑談○ #534868523
NO_REC	/c:annuuuu_cas/movie/534852136	2019/03/28 23:19:16	Live 寝落ち、雑談○ #534852136
NO_REC	/c:annuuuu_cas/movie/534827765	2019/03/28 22:05:38	Live 初見さん捕まえる！ #534827765
```
