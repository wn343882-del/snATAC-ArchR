#####################
# #以下在linux login Page或者一步到位登录到计算节点
# # 先看看你有哪些conda环境
conda env list
# 激活环境
conda activate R-4.3.1

# 进入你的工作目录
cd /jdfsbjcas1/ST_BJ/P21Z28400N0234/wangning12/1_project/3_2509riceLunchBreak/ATAC/scripts/

# 第一步：fa转twoBit
/jdfsbjcas1/ST_BJ/P21Z28400N0234/huangsi/01.Project/01.TYLCV/03.ATAC_V3/L01_L02_merge/Sly_all/05.analyse/faToTwoBit \
  IRGSP-1.0_genome.fasta \
  IRGSP-1.0_genome.fasta.2bit
##提取染色体的名字
grep ">" IRGSP-1.0_genome.fasta \
| awk '{print $1}' \
| sed 's/^>//g' \
| grep -E "^chr(0[1-9]|1[0-2])$" \
> rice.chromName.txt

# 验证结果
echo "=== twoBit文件大小 ==="
ls -lh IRGSP-1.0_genome.fasta.2bit

echo "=== 染色体列表 ==="
cat rice.chromName.txt
wc -l rice.chromName.txt

# 在当前目录创建seed文件
cat > BSgenome.Osativa.IRGSP.seed <<EOF
Package: BSgenome.Osativa.IRGSP
Title: Oryza sativa IRGSP genome
Description: BSgenome for IRGSP rice genome
Version: 1.0.0
organism: Oryza sativa
common_name: Rice
genome: IRGSP
provider: IRGSP
release_date: 2024
source_url: local
organism_biocview: OryzaSativa
BSgenomeObjname: OsativaIRGSP
seqnames: rice.chromName.txt
circ_seqs: character(0)
SrcDataFiles: rice_genome.2bit
seqs_srcdir: .
EOF

# 验证seed文件内容
cat BSgenome.Osativa.IRGSP.seed
########进入R之后的操作###############################

# 在 R 中执行以下代码
library(BSgenome)

# 检查当前目录
getwd()
list.files(pattern = "IRGSP")

# 读取染色体名称验证
seqnames <- read.table("rice.chromName.txt")
head(seqnames)
cat("染色体数量：", nrow(seqnames), "\n")

# 构建 BSgenome 包
forgeBSgenomeDataPkg(
  "BSgenome.Oryza.IRGSP.IRGSP1-seed", 
  seqs_srcdir = getwd(), 
  destdir = getwd(), 
  verbose = TRUE
)

# 退出 R
q()
# 选择 n 不保存工作空间

# linux终端构建 R 包
R CMD build BSgenome.Oryza.IRGSP.IRGSP1

# 查看生成的 tar.gz 文件
ls -lh BSgenome.Oryza.IRGSP.IRGSP1_1.0.tar.gz

# 检查包是否有问题
R CMD check BSgenome.Oryza.IRGSP.IRGSP1_1.0.tar.gz

# 查看当前 R 库路径
Rscript -e ".libPaths()"

export R_LIBS_USER=/jdfsbjcas1/ST_BJ/PUB/User/wangning12/R/x86_64-pc-linux-gnu-library/4.1
# 安装包到默认路径
R CMD INSTALL BSgenome.Oryza.IRGSP.IRGSP1_1.0.tar.gz 

#R里验证是否安装成功
#library(BSgenome.Oryza.IRGSP.IRGSP1)