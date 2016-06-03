
_dnull:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    1003:	83 e4 f0             	and    $0xfffffff0,%esp
    1006:	83 ec 20             	sub    $0x20,%esp
    1009:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
    1010:	00 
    1011:	c7 44 24 04 85 1a 00 	movl   $0x1a85,0x4(%esp)
    1018:	00 
    1019:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1020:	e8 28 04 00 00       	call   144d <printf>
    1025:	8b 44 24 1c          	mov    0x1c(%esp),%eax
    1029:	8b 00                	mov    (%eax),%eax
    102b:	89 44 24 08          	mov    %eax,0x8(%esp)
    102f:	c7 44 24 04 a1 1a 00 	movl   $0x1aa1,0x4(%esp)
    1036:	00 
    1037:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    103e:	e8 0a 04 00 00       	call   144d <printf>
    1043:	e8 64 02 00 00       	call   12ac <exit>

00001048 <stosb>:
    1048:	55                   	push   %ebp
    1049:	89 e5                	mov    %esp,%ebp
    104b:	57                   	push   %edi
    104c:	53                   	push   %ebx
    104d:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1050:	8b 55 10             	mov    0x10(%ebp),%edx
    1053:	8b 45 0c             	mov    0xc(%ebp),%eax
    1056:	89 cb                	mov    %ecx,%ebx
    1058:	89 df                	mov    %ebx,%edi
    105a:	89 d1                	mov    %edx,%ecx
    105c:	fc                   	cld    
    105d:	f3 aa                	rep stos %al,%es:(%edi)
    105f:	89 ca                	mov    %ecx,%edx
    1061:	89 fb                	mov    %edi,%ebx
    1063:	89 5d 08             	mov    %ebx,0x8(%ebp)
    1066:	89 55 10             	mov    %edx,0x10(%ebp)
    1069:	5b                   	pop    %ebx
    106a:	5f                   	pop    %edi
    106b:	5d                   	pop    %ebp
    106c:	c3                   	ret    

0000106d <strcpy>:
    106d:	55                   	push   %ebp
    106e:	89 e5                	mov    %esp,%ebp
    1070:	83 ec 10             	sub    $0x10,%esp
    1073:	8b 45 08             	mov    0x8(%ebp),%eax
    1076:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1079:	8b 45 0c             	mov    0xc(%ebp),%eax
    107c:	0f b6 10             	movzbl (%eax),%edx
    107f:	8b 45 08             	mov    0x8(%ebp),%eax
    1082:	88 10                	mov    %dl,(%eax)
    1084:	8b 45 08             	mov    0x8(%ebp),%eax
    1087:	0f b6 00             	movzbl (%eax),%eax
    108a:	84 c0                	test   %al,%al
    108c:	0f 95 c0             	setne  %al
    108f:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1093:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    1097:	84 c0                	test   %al,%al
    1099:	75 de                	jne    1079 <strcpy+0xc>
    109b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    109e:	c9                   	leave  
    109f:	c3                   	ret    

000010a0 <strcmp>:
    10a0:	55                   	push   %ebp
    10a1:	89 e5                	mov    %esp,%ebp
    10a3:	eb 08                	jmp    10ad <strcmp+0xd>
    10a5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    10a9:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    10ad:	8b 45 08             	mov    0x8(%ebp),%eax
    10b0:	0f b6 00             	movzbl (%eax),%eax
    10b3:	84 c0                	test   %al,%al
    10b5:	74 10                	je     10c7 <strcmp+0x27>
    10b7:	8b 45 08             	mov    0x8(%ebp),%eax
    10ba:	0f b6 10             	movzbl (%eax),%edx
    10bd:	8b 45 0c             	mov    0xc(%ebp),%eax
    10c0:	0f b6 00             	movzbl (%eax),%eax
    10c3:	38 c2                	cmp    %al,%dl
    10c5:	74 de                	je     10a5 <strcmp+0x5>
    10c7:	8b 45 08             	mov    0x8(%ebp),%eax
    10ca:	0f b6 00             	movzbl (%eax),%eax
    10cd:	0f b6 d0             	movzbl %al,%edx
    10d0:	8b 45 0c             	mov    0xc(%ebp),%eax
    10d3:	0f b6 00             	movzbl (%eax),%eax
    10d6:	0f b6 c0             	movzbl %al,%eax
    10d9:	89 d1                	mov    %edx,%ecx
    10db:	29 c1                	sub    %eax,%ecx
    10dd:	89 c8                	mov    %ecx,%eax
    10df:	5d                   	pop    %ebp
    10e0:	c3                   	ret    

000010e1 <strlen>:
    10e1:	55                   	push   %ebp
    10e2:	89 e5                	mov    %esp,%ebp
    10e4:	83 ec 10             	sub    $0x10,%esp
    10e7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    10ee:	eb 04                	jmp    10f4 <strlen+0x13>
    10f0:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    10f4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    10f7:	03 45 08             	add    0x8(%ebp),%eax
    10fa:	0f b6 00             	movzbl (%eax),%eax
    10fd:	84 c0                	test   %al,%al
    10ff:	75 ef                	jne    10f0 <strlen+0xf>
    1101:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1104:	c9                   	leave  
    1105:	c3                   	ret    

00001106 <memset>:
    1106:	55                   	push   %ebp
    1107:	89 e5                	mov    %esp,%ebp
    1109:	83 ec 0c             	sub    $0xc,%esp
    110c:	8b 45 10             	mov    0x10(%ebp),%eax
    110f:	89 44 24 08          	mov    %eax,0x8(%esp)
    1113:	8b 45 0c             	mov    0xc(%ebp),%eax
    1116:	89 44 24 04          	mov    %eax,0x4(%esp)
    111a:	8b 45 08             	mov    0x8(%ebp),%eax
    111d:	89 04 24             	mov    %eax,(%esp)
    1120:	e8 23 ff ff ff       	call   1048 <stosb>
    1125:	8b 45 08             	mov    0x8(%ebp),%eax
    1128:	c9                   	leave  
    1129:	c3                   	ret    

0000112a <strchr>:
    112a:	55                   	push   %ebp
    112b:	89 e5                	mov    %esp,%ebp
    112d:	83 ec 04             	sub    $0x4,%esp
    1130:	8b 45 0c             	mov    0xc(%ebp),%eax
    1133:	88 45 fc             	mov    %al,-0x4(%ebp)
    1136:	eb 14                	jmp    114c <strchr+0x22>
    1138:	8b 45 08             	mov    0x8(%ebp),%eax
    113b:	0f b6 00             	movzbl (%eax),%eax
    113e:	3a 45 fc             	cmp    -0x4(%ebp),%al
    1141:	75 05                	jne    1148 <strchr+0x1e>
    1143:	8b 45 08             	mov    0x8(%ebp),%eax
    1146:	eb 13                	jmp    115b <strchr+0x31>
    1148:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    114c:	8b 45 08             	mov    0x8(%ebp),%eax
    114f:	0f b6 00             	movzbl (%eax),%eax
    1152:	84 c0                	test   %al,%al
    1154:	75 e2                	jne    1138 <strchr+0xe>
    1156:	b8 00 00 00 00       	mov    $0x0,%eax
    115b:	c9                   	leave  
    115c:	c3                   	ret    

0000115d <gets>:
    115d:	55                   	push   %ebp
    115e:	89 e5                	mov    %esp,%ebp
    1160:	83 ec 28             	sub    $0x28,%esp
    1163:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    116a:	eb 44                	jmp    11b0 <gets+0x53>
    116c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1173:	00 
    1174:	8d 45 ef             	lea    -0x11(%ebp),%eax
    1177:	89 44 24 04          	mov    %eax,0x4(%esp)
    117b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1182:	e8 3d 01 00 00       	call   12c4 <read>
    1187:	89 45 f4             	mov    %eax,-0xc(%ebp)
    118a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    118e:	7e 2d                	jle    11bd <gets+0x60>
    1190:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1193:	03 45 08             	add    0x8(%ebp),%eax
    1196:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
    119a:	88 10                	mov    %dl,(%eax)
    119c:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    11a0:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11a4:	3c 0a                	cmp    $0xa,%al
    11a6:	74 16                	je     11be <gets+0x61>
    11a8:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11ac:	3c 0d                	cmp    $0xd,%al
    11ae:	74 0e                	je     11be <gets+0x61>
    11b0:	8b 45 f0             	mov    -0x10(%ebp),%eax
    11b3:	83 c0 01             	add    $0x1,%eax
    11b6:	3b 45 0c             	cmp    0xc(%ebp),%eax
    11b9:	7c b1                	jl     116c <gets+0xf>
    11bb:	eb 01                	jmp    11be <gets+0x61>
    11bd:	90                   	nop
    11be:	8b 45 f0             	mov    -0x10(%ebp),%eax
    11c1:	03 45 08             	add    0x8(%ebp),%eax
    11c4:	c6 00 00             	movb   $0x0,(%eax)
    11c7:	8b 45 08             	mov    0x8(%ebp),%eax
    11ca:	c9                   	leave  
    11cb:	c3                   	ret    

000011cc <stat>:
    11cc:	55                   	push   %ebp
    11cd:	89 e5                	mov    %esp,%ebp
    11cf:	83 ec 28             	sub    $0x28,%esp
    11d2:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    11d9:	00 
    11da:	8b 45 08             	mov    0x8(%ebp),%eax
    11dd:	89 04 24             	mov    %eax,(%esp)
    11e0:	e8 07 01 00 00       	call   12ec <open>
    11e5:	89 45 f0             	mov    %eax,-0x10(%ebp)
    11e8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    11ec:	79 07                	jns    11f5 <stat+0x29>
    11ee:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    11f3:	eb 23                	jmp    1218 <stat+0x4c>
    11f5:	8b 45 0c             	mov    0xc(%ebp),%eax
    11f8:	89 44 24 04          	mov    %eax,0x4(%esp)
    11fc:	8b 45 f0             	mov    -0x10(%ebp),%eax
    11ff:	89 04 24             	mov    %eax,(%esp)
    1202:	e8 fd 00 00 00       	call   1304 <fstat>
    1207:	89 45 f4             	mov    %eax,-0xc(%ebp)
    120a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    120d:	89 04 24             	mov    %eax,(%esp)
    1210:	e8 bf 00 00 00       	call   12d4 <close>
    1215:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1218:	c9                   	leave  
    1219:	c3                   	ret    

0000121a <atoi>:
    121a:	55                   	push   %ebp
    121b:	89 e5                	mov    %esp,%ebp
    121d:	83 ec 10             	sub    $0x10,%esp
    1220:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    1227:	eb 24                	jmp    124d <atoi+0x33>
    1229:	8b 55 fc             	mov    -0x4(%ebp),%edx
    122c:	89 d0                	mov    %edx,%eax
    122e:	c1 e0 02             	shl    $0x2,%eax
    1231:	01 d0                	add    %edx,%eax
    1233:	01 c0                	add    %eax,%eax
    1235:	89 c2                	mov    %eax,%edx
    1237:	8b 45 08             	mov    0x8(%ebp),%eax
    123a:	0f b6 00             	movzbl (%eax),%eax
    123d:	0f be c0             	movsbl %al,%eax
    1240:	8d 04 02             	lea    (%edx,%eax,1),%eax
    1243:	83 e8 30             	sub    $0x30,%eax
    1246:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1249:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    124d:	8b 45 08             	mov    0x8(%ebp),%eax
    1250:	0f b6 00             	movzbl (%eax),%eax
    1253:	3c 2f                	cmp    $0x2f,%al
    1255:	7e 0a                	jle    1261 <atoi+0x47>
    1257:	8b 45 08             	mov    0x8(%ebp),%eax
    125a:	0f b6 00             	movzbl (%eax),%eax
    125d:	3c 39                	cmp    $0x39,%al
    125f:	7e c8                	jle    1229 <atoi+0xf>
    1261:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1264:	c9                   	leave  
    1265:	c3                   	ret    

00001266 <memmove>:
    1266:	55                   	push   %ebp
    1267:	89 e5                	mov    %esp,%ebp
    1269:	83 ec 10             	sub    $0x10,%esp
    126c:	8b 45 08             	mov    0x8(%ebp),%eax
    126f:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1272:	8b 45 0c             	mov    0xc(%ebp),%eax
    1275:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1278:	eb 13                	jmp    128d <memmove+0x27>
    127a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    127d:	0f b6 10             	movzbl (%eax),%edx
    1280:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1283:	88 10                	mov    %dl,(%eax)
    1285:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    1289:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    128d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1291:	0f 9f c0             	setg   %al
    1294:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    1298:	84 c0                	test   %al,%al
    129a:	75 de                	jne    127a <memmove+0x14>
    129c:	8b 45 08             	mov    0x8(%ebp),%eax
    129f:	c9                   	leave  
    12a0:	c3                   	ret    
    12a1:	90                   	nop
    12a2:	90                   	nop
    12a3:	90                   	nop

000012a4 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    12a4:	b8 01 00 00 00       	mov    $0x1,%eax
    12a9:	cd 40                	int    $0x40
    12ab:	c3                   	ret    

000012ac <exit>:
SYSCALL(exit)
    12ac:	b8 02 00 00 00       	mov    $0x2,%eax
    12b1:	cd 40                	int    $0x40
    12b3:	c3                   	ret    

000012b4 <wait>:
SYSCALL(wait)
    12b4:	b8 03 00 00 00       	mov    $0x3,%eax
    12b9:	cd 40                	int    $0x40
    12bb:	c3                   	ret    

000012bc <pipe>:
SYSCALL(pipe)
    12bc:	b8 04 00 00 00       	mov    $0x4,%eax
    12c1:	cd 40                	int    $0x40
    12c3:	c3                   	ret    

000012c4 <read>:
SYSCALL(read)
    12c4:	b8 05 00 00 00       	mov    $0x5,%eax
    12c9:	cd 40                	int    $0x40
    12cb:	c3                   	ret    

000012cc <write>:
SYSCALL(write)
    12cc:	b8 10 00 00 00       	mov    $0x10,%eax
    12d1:	cd 40                	int    $0x40
    12d3:	c3                   	ret    

000012d4 <close>:
SYSCALL(close)
    12d4:	b8 15 00 00 00       	mov    $0x15,%eax
    12d9:	cd 40                	int    $0x40
    12db:	c3                   	ret    

000012dc <kill>:
SYSCALL(kill)
    12dc:	b8 06 00 00 00       	mov    $0x6,%eax
    12e1:	cd 40                	int    $0x40
    12e3:	c3                   	ret    

000012e4 <exec>:
SYSCALL(exec)
    12e4:	b8 07 00 00 00       	mov    $0x7,%eax
    12e9:	cd 40                	int    $0x40
    12eb:	c3                   	ret    

000012ec <open>:
SYSCALL(open)
    12ec:	b8 0f 00 00 00       	mov    $0xf,%eax
    12f1:	cd 40                	int    $0x40
    12f3:	c3                   	ret    

000012f4 <mknod>:
SYSCALL(mknod)
    12f4:	b8 11 00 00 00       	mov    $0x11,%eax
    12f9:	cd 40                	int    $0x40
    12fb:	c3                   	ret    

000012fc <unlink>:
SYSCALL(unlink)
    12fc:	b8 12 00 00 00       	mov    $0x12,%eax
    1301:	cd 40                	int    $0x40
    1303:	c3                   	ret    

00001304 <fstat>:
SYSCALL(fstat)
    1304:	b8 08 00 00 00       	mov    $0x8,%eax
    1309:	cd 40                	int    $0x40
    130b:	c3                   	ret    

0000130c <link>:
SYSCALL(link)
    130c:	b8 13 00 00 00       	mov    $0x13,%eax
    1311:	cd 40                	int    $0x40
    1313:	c3                   	ret    

00001314 <mkdir>:
SYSCALL(mkdir)
    1314:	b8 14 00 00 00       	mov    $0x14,%eax
    1319:	cd 40                	int    $0x40
    131b:	c3                   	ret    

0000131c <chdir>:
SYSCALL(chdir)
    131c:	b8 09 00 00 00       	mov    $0x9,%eax
    1321:	cd 40                	int    $0x40
    1323:	c3                   	ret    

00001324 <dup>:
SYSCALL(dup)
    1324:	b8 0a 00 00 00       	mov    $0xa,%eax
    1329:	cd 40                	int    $0x40
    132b:	c3                   	ret    

0000132c <getpid>:
SYSCALL(getpid)
    132c:	b8 0b 00 00 00       	mov    $0xb,%eax
    1331:	cd 40                	int    $0x40
    1333:	c3                   	ret    

00001334 <sbrk>:
SYSCALL(sbrk)
    1334:	b8 0c 00 00 00       	mov    $0xc,%eax
    1339:	cd 40                	int    $0x40
    133b:	c3                   	ret    

0000133c <sleep>:
SYSCALL(sleep)
    133c:	b8 0d 00 00 00       	mov    $0xd,%eax
    1341:	cd 40                	int    $0x40
    1343:	c3                   	ret    

00001344 <uptime>:
SYSCALL(uptime)
    1344:	b8 0e 00 00 00       	mov    $0xe,%eax
    1349:	cd 40                	int    $0x40
    134b:	c3                   	ret    

0000134c <clone>:
SYSCALL(clone)
    134c:	b8 16 00 00 00       	mov    $0x16,%eax
    1351:	cd 40                	int    $0x40
    1353:	c3                   	ret    

00001354 <texit>:
SYSCALL(texit)
    1354:	b8 17 00 00 00       	mov    $0x17,%eax
    1359:	cd 40                	int    $0x40
    135b:	c3                   	ret    

0000135c <tsleep>:
SYSCALL(tsleep)
    135c:	b8 18 00 00 00       	mov    $0x18,%eax
    1361:	cd 40                	int    $0x40
    1363:	c3                   	ret    

00001364 <twakeup>:
SYSCALL(twakeup)
    1364:	b8 19 00 00 00       	mov    $0x19,%eax
    1369:	cd 40                	int    $0x40
    136b:	c3                   	ret    

0000136c <thread_yield>:
SYSCALL(thread_yield)
    136c:	b8 1a 00 00 00       	mov    $0x1a,%eax
    1371:	cd 40                	int    $0x40
    1373:	c3                   	ret    

00001374 <putc>:
    1374:	55                   	push   %ebp
    1375:	89 e5                	mov    %esp,%ebp
    1377:	83 ec 28             	sub    $0x28,%esp
    137a:	8b 45 0c             	mov    0xc(%ebp),%eax
    137d:	88 45 f4             	mov    %al,-0xc(%ebp)
    1380:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1387:	00 
    1388:	8d 45 f4             	lea    -0xc(%ebp),%eax
    138b:	89 44 24 04          	mov    %eax,0x4(%esp)
    138f:	8b 45 08             	mov    0x8(%ebp),%eax
    1392:	89 04 24             	mov    %eax,(%esp)
    1395:	e8 32 ff ff ff       	call   12cc <write>
    139a:	c9                   	leave  
    139b:	c3                   	ret    

0000139c <printint>:
    139c:	55                   	push   %ebp
    139d:	89 e5                	mov    %esp,%ebp
    139f:	53                   	push   %ebx
    13a0:	83 ec 44             	sub    $0x44,%esp
    13a3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    13aa:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    13ae:	74 17                	je     13c7 <printint+0x2b>
    13b0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    13b4:	79 11                	jns    13c7 <printint+0x2b>
    13b6:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    13bd:	8b 45 0c             	mov    0xc(%ebp),%eax
    13c0:	f7 d8                	neg    %eax
    13c2:	89 45 f4             	mov    %eax,-0xc(%ebp)
    13c5:	eb 06                	jmp    13cd <printint+0x31>
    13c7:	8b 45 0c             	mov    0xc(%ebp),%eax
    13ca:	89 45 f4             	mov    %eax,-0xc(%ebp)
    13cd:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    13d4:	8b 4d ec             	mov    -0x14(%ebp),%ecx
    13d7:	8b 5d 10             	mov    0x10(%ebp),%ebx
    13da:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13dd:	ba 00 00 00 00       	mov    $0x0,%edx
    13e2:	f7 f3                	div    %ebx
    13e4:	89 d0                	mov    %edx,%eax
    13e6:	0f b6 80 d8 1a 00 00 	movzbl 0x1ad8(%eax),%eax
    13ed:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
    13f1:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    13f5:	8b 45 10             	mov    0x10(%ebp),%eax
    13f8:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    13fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13fe:	ba 00 00 00 00       	mov    $0x0,%edx
    1403:	f7 75 d4             	divl   -0x2c(%ebp)
    1406:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1409:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    140d:	75 c5                	jne    13d4 <printint+0x38>
    140f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1413:	74 28                	je     143d <printint+0xa1>
    1415:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1418:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)
    141d:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1421:	eb 1a                	jmp    143d <printint+0xa1>
    1423:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1426:	0f b6 44 05 dc       	movzbl -0x24(%ebp,%eax,1),%eax
    142b:	0f be c0             	movsbl %al,%eax
    142e:	89 44 24 04          	mov    %eax,0x4(%esp)
    1432:	8b 45 08             	mov    0x8(%ebp),%eax
    1435:	89 04 24             	mov    %eax,(%esp)
    1438:	e8 37 ff ff ff       	call   1374 <putc>
    143d:	83 6d ec 01          	subl   $0x1,-0x14(%ebp)
    1441:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1445:	79 dc                	jns    1423 <printint+0x87>
    1447:	83 c4 44             	add    $0x44,%esp
    144a:	5b                   	pop    %ebx
    144b:	5d                   	pop    %ebp
    144c:	c3                   	ret    

0000144d <printf>:
    144d:	55                   	push   %ebp
    144e:	89 e5                	mov    %esp,%ebp
    1450:	83 ec 38             	sub    $0x38,%esp
    1453:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    145a:	8d 45 0c             	lea    0xc(%ebp),%eax
    145d:	83 c0 04             	add    $0x4,%eax
    1460:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1463:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    146a:	e9 7e 01 00 00       	jmp    15ed <printf+0x1a0>
    146f:	8b 55 0c             	mov    0xc(%ebp),%edx
    1472:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1475:	8d 04 02             	lea    (%edx,%eax,1),%eax
    1478:	0f b6 00             	movzbl (%eax),%eax
    147b:	0f be c0             	movsbl %al,%eax
    147e:	25 ff 00 00 00       	and    $0xff,%eax
    1483:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1486:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    148a:	75 2c                	jne    14b8 <printf+0x6b>
    148c:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    1490:	75 0c                	jne    149e <printf+0x51>
    1492:	c7 45 f0 25 00 00 00 	movl   $0x25,-0x10(%ebp)
    1499:	e9 4b 01 00 00       	jmp    15e9 <printf+0x19c>
    149e:	8b 45 e8             	mov    -0x18(%ebp),%eax
    14a1:	0f be c0             	movsbl %al,%eax
    14a4:	89 44 24 04          	mov    %eax,0x4(%esp)
    14a8:	8b 45 08             	mov    0x8(%ebp),%eax
    14ab:	89 04 24             	mov    %eax,(%esp)
    14ae:	e8 c1 fe ff ff       	call   1374 <putc>
    14b3:	e9 31 01 00 00       	jmp    15e9 <printf+0x19c>
    14b8:	83 7d f0 25          	cmpl   $0x25,-0x10(%ebp)
    14bc:	0f 85 27 01 00 00    	jne    15e9 <printf+0x19c>
    14c2:	83 7d e8 64          	cmpl   $0x64,-0x18(%ebp)
    14c6:	75 2d                	jne    14f5 <printf+0xa8>
    14c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14cb:	8b 00                	mov    (%eax),%eax
    14cd:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    14d4:	00 
    14d5:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    14dc:	00 
    14dd:	89 44 24 04          	mov    %eax,0x4(%esp)
    14e1:	8b 45 08             	mov    0x8(%ebp),%eax
    14e4:	89 04 24             	mov    %eax,(%esp)
    14e7:	e8 b0 fe ff ff       	call   139c <printint>
    14ec:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    14f0:	e9 ed 00 00 00       	jmp    15e2 <printf+0x195>
    14f5:	83 7d e8 78          	cmpl   $0x78,-0x18(%ebp)
    14f9:	74 06                	je     1501 <printf+0xb4>
    14fb:	83 7d e8 70          	cmpl   $0x70,-0x18(%ebp)
    14ff:	75 2d                	jne    152e <printf+0xe1>
    1501:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1504:	8b 00                	mov    (%eax),%eax
    1506:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    150d:	00 
    150e:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    1515:	00 
    1516:	89 44 24 04          	mov    %eax,0x4(%esp)
    151a:	8b 45 08             	mov    0x8(%ebp),%eax
    151d:	89 04 24             	mov    %eax,(%esp)
    1520:	e8 77 fe ff ff       	call   139c <printint>
    1525:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    1529:	e9 b4 00 00 00       	jmp    15e2 <printf+0x195>
    152e:	83 7d e8 73          	cmpl   $0x73,-0x18(%ebp)
    1532:	75 46                	jne    157a <printf+0x12d>
    1534:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1537:	8b 00                	mov    (%eax),%eax
    1539:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    153c:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    1540:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    1544:	75 27                	jne    156d <printf+0x120>
    1546:	c7 45 e4 a5 1a 00 00 	movl   $0x1aa5,-0x1c(%ebp)
    154d:	eb 1f                	jmp    156e <printf+0x121>
    154f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1552:	0f b6 00             	movzbl (%eax),%eax
    1555:	0f be c0             	movsbl %al,%eax
    1558:	89 44 24 04          	mov    %eax,0x4(%esp)
    155c:	8b 45 08             	mov    0x8(%ebp),%eax
    155f:	89 04 24             	mov    %eax,(%esp)
    1562:	e8 0d fe ff ff       	call   1374 <putc>
    1567:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    156b:	eb 01                	jmp    156e <printf+0x121>
    156d:	90                   	nop
    156e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1571:	0f b6 00             	movzbl (%eax),%eax
    1574:	84 c0                	test   %al,%al
    1576:	75 d7                	jne    154f <printf+0x102>
    1578:	eb 68                	jmp    15e2 <printf+0x195>
    157a:	83 7d e8 63          	cmpl   $0x63,-0x18(%ebp)
    157e:	75 1d                	jne    159d <printf+0x150>
    1580:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1583:	8b 00                	mov    (%eax),%eax
    1585:	0f be c0             	movsbl %al,%eax
    1588:	89 44 24 04          	mov    %eax,0x4(%esp)
    158c:	8b 45 08             	mov    0x8(%ebp),%eax
    158f:	89 04 24             	mov    %eax,(%esp)
    1592:	e8 dd fd ff ff       	call   1374 <putc>
    1597:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    159b:	eb 45                	jmp    15e2 <printf+0x195>
    159d:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    15a1:	75 17                	jne    15ba <printf+0x16d>
    15a3:	8b 45 e8             	mov    -0x18(%ebp),%eax
    15a6:	0f be c0             	movsbl %al,%eax
    15a9:	89 44 24 04          	mov    %eax,0x4(%esp)
    15ad:	8b 45 08             	mov    0x8(%ebp),%eax
    15b0:	89 04 24             	mov    %eax,(%esp)
    15b3:	e8 bc fd ff ff       	call   1374 <putc>
    15b8:	eb 28                	jmp    15e2 <printf+0x195>
    15ba:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    15c1:	00 
    15c2:	8b 45 08             	mov    0x8(%ebp),%eax
    15c5:	89 04 24             	mov    %eax,(%esp)
    15c8:	e8 a7 fd ff ff       	call   1374 <putc>
    15cd:	8b 45 e8             	mov    -0x18(%ebp),%eax
    15d0:	0f be c0             	movsbl %al,%eax
    15d3:	89 44 24 04          	mov    %eax,0x4(%esp)
    15d7:	8b 45 08             	mov    0x8(%ebp),%eax
    15da:	89 04 24             	mov    %eax,(%esp)
    15dd:	e8 92 fd ff ff       	call   1374 <putc>
    15e2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    15e9:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    15ed:	8b 55 0c             	mov    0xc(%ebp),%edx
    15f0:	8b 45 ec             	mov    -0x14(%ebp),%eax
    15f3:	8d 04 02             	lea    (%edx,%eax,1),%eax
    15f6:	0f b6 00             	movzbl (%eax),%eax
    15f9:	84 c0                	test   %al,%al
    15fb:	0f 85 6e fe ff ff    	jne    146f <printf+0x22>
    1601:	c9                   	leave  
    1602:	c3                   	ret    
    1603:	90                   	nop

00001604 <free>:
    1604:	55                   	push   %ebp
    1605:	89 e5                	mov    %esp,%ebp
    1607:	83 ec 10             	sub    $0x10,%esp
    160a:	8b 45 08             	mov    0x8(%ebp),%eax
    160d:	83 e8 08             	sub    $0x8,%eax
    1610:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1613:	a1 f8 1a 00 00       	mov    0x1af8,%eax
    1618:	89 45 fc             	mov    %eax,-0x4(%ebp)
    161b:	eb 24                	jmp    1641 <free+0x3d>
    161d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1620:	8b 00                	mov    (%eax),%eax
    1622:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1625:	77 12                	ja     1639 <free+0x35>
    1627:	8b 45 f8             	mov    -0x8(%ebp),%eax
    162a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    162d:	77 24                	ja     1653 <free+0x4f>
    162f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1632:	8b 00                	mov    (%eax),%eax
    1634:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1637:	77 1a                	ja     1653 <free+0x4f>
    1639:	8b 45 fc             	mov    -0x4(%ebp),%eax
    163c:	8b 00                	mov    (%eax),%eax
    163e:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1641:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1644:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1647:	76 d4                	jbe    161d <free+0x19>
    1649:	8b 45 fc             	mov    -0x4(%ebp),%eax
    164c:	8b 00                	mov    (%eax),%eax
    164e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1651:	76 ca                	jbe    161d <free+0x19>
    1653:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1656:	8b 40 04             	mov    0x4(%eax),%eax
    1659:	c1 e0 03             	shl    $0x3,%eax
    165c:	89 c2                	mov    %eax,%edx
    165e:	03 55 f8             	add    -0x8(%ebp),%edx
    1661:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1664:	8b 00                	mov    (%eax),%eax
    1666:	39 c2                	cmp    %eax,%edx
    1668:	75 24                	jne    168e <free+0x8a>
    166a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    166d:	8b 50 04             	mov    0x4(%eax),%edx
    1670:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1673:	8b 00                	mov    (%eax),%eax
    1675:	8b 40 04             	mov    0x4(%eax),%eax
    1678:	01 c2                	add    %eax,%edx
    167a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    167d:	89 50 04             	mov    %edx,0x4(%eax)
    1680:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1683:	8b 00                	mov    (%eax),%eax
    1685:	8b 10                	mov    (%eax),%edx
    1687:	8b 45 f8             	mov    -0x8(%ebp),%eax
    168a:	89 10                	mov    %edx,(%eax)
    168c:	eb 0a                	jmp    1698 <free+0x94>
    168e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1691:	8b 10                	mov    (%eax),%edx
    1693:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1696:	89 10                	mov    %edx,(%eax)
    1698:	8b 45 fc             	mov    -0x4(%ebp),%eax
    169b:	8b 40 04             	mov    0x4(%eax),%eax
    169e:	c1 e0 03             	shl    $0x3,%eax
    16a1:	03 45 fc             	add    -0x4(%ebp),%eax
    16a4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    16a7:	75 20                	jne    16c9 <free+0xc5>
    16a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16ac:	8b 50 04             	mov    0x4(%eax),%edx
    16af:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16b2:	8b 40 04             	mov    0x4(%eax),%eax
    16b5:	01 c2                	add    %eax,%edx
    16b7:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16ba:	89 50 04             	mov    %edx,0x4(%eax)
    16bd:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16c0:	8b 10                	mov    (%eax),%edx
    16c2:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16c5:	89 10                	mov    %edx,(%eax)
    16c7:	eb 08                	jmp    16d1 <free+0xcd>
    16c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16cc:	8b 55 f8             	mov    -0x8(%ebp),%edx
    16cf:	89 10                	mov    %edx,(%eax)
    16d1:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16d4:	a3 f8 1a 00 00       	mov    %eax,0x1af8
    16d9:	c9                   	leave  
    16da:	c3                   	ret    

000016db <morecore>:
    16db:	55                   	push   %ebp
    16dc:	89 e5                	mov    %esp,%ebp
    16de:	83 ec 28             	sub    $0x28,%esp
    16e1:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    16e8:	77 07                	ja     16f1 <morecore+0x16>
    16ea:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
    16f1:	8b 45 08             	mov    0x8(%ebp),%eax
    16f4:	c1 e0 03             	shl    $0x3,%eax
    16f7:	89 04 24             	mov    %eax,(%esp)
    16fa:	e8 35 fc ff ff       	call   1334 <sbrk>
    16ff:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1702:	83 7d f0 ff          	cmpl   $0xffffffff,-0x10(%ebp)
    1706:	75 07                	jne    170f <morecore+0x34>
    1708:	b8 00 00 00 00       	mov    $0x0,%eax
    170d:	eb 22                	jmp    1731 <morecore+0x56>
    170f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1712:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1715:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1718:	8b 55 08             	mov    0x8(%ebp),%edx
    171b:	89 50 04             	mov    %edx,0x4(%eax)
    171e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1721:	83 c0 08             	add    $0x8,%eax
    1724:	89 04 24             	mov    %eax,(%esp)
    1727:	e8 d8 fe ff ff       	call   1604 <free>
    172c:	a1 f8 1a 00 00       	mov    0x1af8,%eax
    1731:	c9                   	leave  
    1732:	c3                   	ret    

00001733 <malloc>:
    1733:	55                   	push   %ebp
    1734:	89 e5                	mov    %esp,%ebp
    1736:	83 ec 28             	sub    $0x28,%esp
    1739:	8b 45 08             	mov    0x8(%ebp),%eax
    173c:	83 c0 07             	add    $0x7,%eax
    173f:	c1 e8 03             	shr    $0x3,%eax
    1742:	83 c0 01             	add    $0x1,%eax
    1745:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1748:	a1 f8 1a 00 00       	mov    0x1af8,%eax
    174d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1750:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1754:	75 23                	jne    1779 <malloc+0x46>
    1756:	c7 45 f0 f0 1a 00 00 	movl   $0x1af0,-0x10(%ebp)
    175d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1760:	a3 f8 1a 00 00       	mov    %eax,0x1af8
    1765:	a1 f8 1a 00 00       	mov    0x1af8,%eax
    176a:	a3 f0 1a 00 00       	mov    %eax,0x1af0
    176f:	c7 05 f4 1a 00 00 00 	movl   $0x0,0x1af4
    1776:	00 00 00 
    1779:	8b 45 f0             	mov    -0x10(%ebp),%eax
    177c:	8b 00                	mov    (%eax),%eax
    177e:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1781:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1784:	8b 40 04             	mov    0x4(%eax),%eax
    1787:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    178a:	72 4d                	jb     17d9 <malloc+0xa6>
    178c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    178f:	8b 40 04             	mov    0x4(%eax),%eax
    1792:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1795:	75 0c                	jne    17a3 <malloc+0x70>
    1797:	8b 45 ec             	mov    -0x14(%ebp),%eax
    179a:	8b 10                	mov    (%eax),%edx
    179c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    179f:	89 10                	mov    %edx,(%eax)
    17a1:	eb 26                	jmp    17c9 <malloc+0x96>
    17a3:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17a6:	8b 40 04             	mov    0x4(%eax),%eax
    17a9:	89 c2                	mov    %eax,%edx
    17ab:	2b 55 f4             	sub    -0xc(%ebp),%edx
    17ae:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17b1:	89 50 04             	mov    %edx,0x4(%eax)
    17b4:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17b7:	8b 40 04             	mov    0x4(%eax),%eax
    17ba:	c1 e0 03             	shl    $0x3,%eax
    17bd:	01 45 ec             	add    %eax,-0x14(%ebp)
    17c0:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17c3:	8b 55 f4             	mov    -0xc(%ebp),%edx
    17c6:	89 50 04             	mov    %edx,0x4(%eax)
    17c9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17cc:	a3 f8 1a 00 00       	mov    %eax,0x1af8
    17d1:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17d4:	83 c0 08             	add    $0x8,%eax
    17d7:	eb 38                	jmp    1811 <malloc+0xde>
    17d9:	a1 f8 1a 00 00       	mov    0x1af8,%eax
    17de:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    17e1:	75 1b                	jne    17fe <malloc+0xcb>
    17e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17e6:	89 04 24             	mov    %eax,(%esp)
    17e9:	e8 ed fe ff ff       	call   16db <morecore>
    17ee:	89 45 ec             	mov    %eax,-0x14(%ebp)
    17f1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    17f5:	75 07                	jne    17fe <malloc+0xcb>
    17f7:	b8 00 00 00 00       	mov    $0x0,%eax
    17fc:	eb 13                	jmp    1811 <malloc+0xde>
    17fe:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1801:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1804:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1807:	8b 00                	mov    (%eax),%eax
    1809:	89 45 ec             	mov    %eax,-0x14(%ebp)
    180c:	e9 70 ff ff ff       	jmp    1781 <malloc+0x4e>
    1811:	c9                   	leave  
    1812:	c3                   	ret    
    1813:	90                   	nop

00001814 <xchg>:
    1814:	55                   	push   %ebp
    1815:	89 e5                	mov    %esp,%ebp
    1817:	83 ec 10             	sub    $0x10,%esp
    181a:	8b 55 08             	mov    0x8(%ebp),%edx
    181d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1820:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1823:	f0 87 02             	lock xchg %eax,(%edx)
    1826:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1829:	8b 45 fc             	mov    -0x4(%ebp),%eax
    182c:	c9                   	leave  
    182d:	c3                   	ret    

0000182e <lock_init>:
    182e:	55                   	push   %ebp
    182f:	89 e5                	mov    %esp,%ebp
    1831:	8b 45 08             	mov    0x8(%ebp),%eax
    1834:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    183a:	5d                   	pop    %ebp
    183b:	c3                   	ret    

0000183c <lock_acquire>:
    183c:	55                   	push   %ebp
    183d:	89 e5                	mov    %esp,%ebp
    183f:	83 ec 08             	sub    $0x8,%esp
    1842:	8b 45 08             	mov    0x8(%ebp),%eax
    1845:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    184c:	00 
    184d:	89 04 24             	mov    %eax,(%esp)
    1850:	e8 bf ff ff ff       	call   1814 <xchg>
    1855:	85 c0                	test   %eax,%eax
    1857:	75 e9                	jne    1842 <lock_acquire+0x6>
    1859:	c9                   	leave  
    185a:	c3                   	ret    

0000185b <lock_release>:
    185b:	55                   	push   %ebp
    185c:	89 e5                	mov    %esp,%ebp
    185e:	83 ec 08             	sub    $0x8,%esp
    1861:	8b 45 08             	mov    0x8(%ebp),%eax
    1864:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    186b:	00 
    186c:	89 04 24             	mov    %eax,(%esp)
    186f:	e8 a0 ff ff ff       	call   1814 <xchg>
    1874:	c9                   	leave  
    1875:	c3                   	ret    

00001876 <thread_create>:
    1876:	55                   	push   %ebp
    1877:	89 e5                	mov    %esp,%ebp
    1879:	83 ec 28             	sub    $0x28,%esp
    187c:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    1883:	e8 ab fe ff ff       	call   1733 <malloc>
    1888:	89 45 f0             	mov    %eax,-0x10(%ebp)
    188b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    188e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1891:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1894:	25 ff 0f 00 00       	and    $0xfff,%eax
    1899:	85 c0                	test   %eax,%eax
    189b:	74 15                	je     18b2 <thread_create+0x3c>
    189d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    18a0:	89 c2                	mov    %eax,%edx
    18a2:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
    18a8:	b8 00 10 00 00       	mov    $0x1000,%eax
    18ad:	29 d0                	sub    %edx,%eax
    18af:	01 45 f0             	add    %eax,-0x10(%ebp)
    18b2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    18b6:	75 1b                	jne    18d3 <thread_create+0x5d>
    18b8:	c7 44 24 04 ac 1a 00 	movl   $0x1aac,0x4(%esp)
    18bf:	00 
    18c0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    18c7:	e8 81 fb ff ff       	call   144d <printf>
    18cc:	b8 00 00 00 00       	mov    $0x0,%eax
    18d1:	eb 6f                	jmp    1942 <thread_create+0xcc>
    18d3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    18d6:	8b 55 08             	mov    0x8(%ebp),%edx
    18d9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    18dc:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    18e0:	89 54 24 08          	mov    %edx,0x8(%esp)
    18e4:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    18eb:	00 
    18ec:	89 04 24             	mov    %eax,(%esp)
    18ef:	e8 58 fa ff ff       	call   134c <clone>
    18f4:	89 45 ec             	mov    %eax,-0x14(%ebp)
    18f7:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    18fb:	79 1b                	jns    1918 <thread_create+0xa2>
    18fd:	c7 44 24 04 ba 1a 00 	movl   $0x1aba,0x4(%esp)
    1904:	00 
    1905:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    190c:	e8 3c fb ff ff       	call   144d <printf>
    1911:	b8 00 00 00 00       	mov    $0x0,%eax
    1916:	eb 2a                	jmp    1942 <thread_create+0xcc>
    1918:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    191c:	7e 05                	jle    1923 <thread_create+0xad>
    191e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1921:	eb 1f                	jmp    1942 <thread_create+0xcc>
    1923:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1927:	75 14                	jne    193d <thread_create+0xc7>
    1929:	c7 44 24 04 c7 1a 00 	movl   $0x1ac7,0x4(%esp)
    1930:	00 
    1931:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1938:	e8 10 fb ff ff       	call   144d <printf>
    193d:	b8 00 00 00 00       	mov    $0x0,%eax
    1942:	c9                   	leave  
    1943:	c3                   	ret    

00001944 <random>:
    1944:	55                   	push   %ebp
    1945:	89 e5                	mov    %esp,%ebp
    1947:	a1 ec 1a 00 00       	mov    0x1aec,%eax
    194c:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    1952:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    1957:	a3 ec 1a 00 00       	mov    %eax,0x1aec
    195c:	a1 ec 1a 00 00       	mov    0x1aec,%eax
    1961:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1964:	ba 00 00 00 00       	mov    $0x0,%edx
    1969:	f7 f1                	div    %ecx
    196b:	89 d0                	mov    %edx,%eax
    196d:	5d                   	pop    %ebp
    196e:	c3                   	ret    
    196f:	90                   	nop

00001970 <init_q>:
    1970:	55                   	push   %ebp
    1971:	89 e5                	mov    %esp,%ebp
    1973:	8b 45 08             	mov    0x8(%ebp),%eax
    1976:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    197c:	8b 45 08             	mov    0x8(%ebp),%eax
    197f:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    1986:	8b 45 08             	mov    0x8(%ebp),%eax
    1989:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
    1990:	5d                   	pop    %ebp
    1991:	c3                   	ret    

00001992 <add_q>:
    1992:	55                   	push   %ebp
    1993:	89 e5                	mov    %esp,%ebp
    1995:	83 ec 28             	sub    $0x28,%esp
    1998:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    199f:	e8 8f fd ff ff       	call   1733 <malloc>
    19a4:	89 45 f4             	mov    %eax,-0xc(%ebp)
    19a7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19aa:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    19b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19b4:	8b 55 0c             	mov    0xc(%ebp),%edx
    19b7:	89 10                	mov    %edx,(%eax)
    19b9:	8b 45 08             	mov    0x8(%ebp),%eax
    19bc:	8b 40 04             	mov    0x4(%eax),%eax
    19bf:	85 c0                	test   %eax,%eax
    19c1:	75 0b                	jne    19ce <add_q+0x3c>
    19c3:	8b 45 08             	mov    0x8(%ebp),%eax
    19c6:	8b 55 f4             	mov    -0xc(%ebp),%edx
    19c9:	89 50 04             	mov    %edx,0x4(%eax)
    19cc:	eb 0c                	jmp    19da <add_q+0x48>
    19ce:	8b 45 08             	mov    0x8(%ebp),%eax
    19d1:	8b 40 08             	mov    0x8(%eax),%eax
    19d4:	8b 55 f4             	mov    -0xc(%ebp),%edx
    19d7:	89 50 04             	mov    %edx,0x4(%eax)
    19da:	8b 45 08             	mov    0x8(%ebp),%eax
    19dd:	8b 55 f4             	mov    -0xc(%ebp),%edx
    19e0:	89 50 08             	mov    %edx,0x8(%eax)
    19e3:	8b 45 08             	mov    0x8(%ebp),%eax
    19e6:	8b 00                	mov    (%eax),%eax
    19e8:	8d 50 01             	lea    0x1(%eax),%edx
    19eb:	8b 45 08             	mov    0x8(%ebp),%eax
    19ee:	89 10                	mov    %edx,(%eax)
    19f0:	c9                   	leave  
    19f1:	c3                   	ret    

000019f2 <empty_q>:
    19f2:	55                   	push   %ebp
    19f3:	89 e5                	mov    %esp,%ebp
    19f5:	8b 45 08             	mov    0x8(%ebp),%eax
    19f8:	8b 00                	mov    (%eax),%eax
    19fa:	85 c0                	test   %eax,%eax
    19fc:	75 07                	jne    1a05 <empty_q+0x13>
    19fe:	b8 01 00 00 00       	mov    $0x1,%eax
    1a03:	eb 05                	jmp    1a0a <empty_q+0x18>
    1a05:	b8 00 00 00 00       	mov    $0x0,%eax
    1a0a:	5d                   	pop    %ebp
    1a0b:	c3                   	ret    

00001a0c <pop_q>:
    1a0c:	55                   	push   %ebp
    1a0d:	89 e5                	mov    %esp,%ebp
    1a0f:	83 ec 28             	sub    $0x28,%esp
    1a12:	8b 45 08             	mov    0x8(%ebp),%eax
    1a15:	89 04 24             	mov    %eax,(%esp)
    1a18:	e8 d5 ff ff ff       	call   19f2 <empty_q>
    1a1d:	85 c0                	test   %eax,%eax
    1a1f:	75 5d                	jne    1a7e <pop_q+0x72>
    1a21:	8b 45 08             	mov    0x8(%ebp),%eax
    1a24:	8b 40 04             	mov    0x4(%eax),%eax
    1a27:	8b 00                	mov    (%eax),%eax
    1a29:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1a2c:	8b 45 08             	mov    0x8(%ebp),%eax
    1a2f:	8b 40 04             	mov    0x4(%eax),%eax
    1a32:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1a35:	8b 45 08             	mov    0x8(%ebp),%eax
    1a38:	8b 40 04             	mov    0x4(%eax),%eax
    1a3b:	8b 50 04             	mov    0x4(%eax),%edx
    1a3e:	8b 45 08             	mov    0x8(%ebp),%eax
    1a41:	89 50 04             	mov    %edx,0x4(%eax)
    1a44:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a47:	89 04 24             	mov    %eax,(%esp)
    1a4a:	e8 b5 fb ff ff       	call   1604 <free>
    1a4f:	8b 45 08             	mov    0x8(%ebp),%eax
    1a52:	8b 00                	mov    (%eax),%eax
    1a54:	8d 50 ff             	lea    -0x1(%eax),%edx
    1a57:	8b 45 08             	mov    0x8(%ebp),%eax
    1a5a:	89 10                	mov    %edx,(%eax)
    1a5c:	8b 45 08             	mov    0x8(%ebp),%eax
    1a5f:	8b 00                	mov    (%eax),%eax
    1a61:	85 c0                	test   %eax,%eax
    1a63:	75 14                	jne    1a79 <pop_q+0x6d>
    1a65:	8b 45 08             	mov    0x8(%ebp),%eax
    1a68:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    1a6f:	8b 45 08             	mov    0x8(%ebp),%eax
    1a72:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
    1a79:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a7c:	eb 05                	jmp    1a83 <pop_q+0x77>
    1a7e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1a83:	c9                   	leave  
    1a84:	c3                   	ret    
