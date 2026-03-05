# snATAC-ArchR
利用ArchR包，从fragments文件开始分析ATAC数据
参考基因组一共有三类供选择
Rice MSU 7.0  https://rice.uga.edu/pub/data/Eukaryotic_Projects/o_sativa/annotation_dbs/pseudomolecules/version_7.0/
irgsp 云平台上（较旧一点）
Japonica v7.0 10.1093/nar/gkl976
 kitaake的3.1 https://phytozome-next.jgi.doe.gov/

 前提知识：是在本地电脑上，包含环境配置，ArchR的下载开始，BSgenome配置失败，（主要原因是BSgenome自带的水稻注释基因组版本与我们的gtf注释版本不一致，故失败），后续转到linux里从构建BSgenome开始分析，这里发现云平台上构建参考基因组的时候，基因组用的与后续不一致，决定重新构建参考基因组，以及后续的云平台任务分析。

 LiunxVersion是属于从头开始的ArchR分析
 缺乏水稻的blackList基因组文件（目前忽略，将于后续补上）
 
