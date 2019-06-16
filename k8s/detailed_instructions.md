## This branch provides YAML and a shell script for starting up the Scalyr Kubernetes agent.

Sore yang baik Kami ingin menjelaskan pengoptimalan yang telah kami lakukan untuk Anda:

Pertama, kami telah mencoba mengurangi kebingungan dalam proses konfigurasi dengan menyediakan skrip ini.

Kedua, Agen Scalyr telah diverifikasi untuk bekerja dalam kelompok lebih dari 1000 node dengan sangat sedikit peningkatan pada CPU dan Bandwidth (Semua fitur dihidupkan). Kami mohon maaf atas masalah masa lalu di kluster Anda.

Untuk mengidentifikasi masalah, kami telah mematikan beberapa fitur tambahan (seperti Metrik dan Acara Kubernetes). Kami sekarang dengan ketat membatasi jumlah permintaan dari masing-masing Agen ke master API.

Terima kasih atas kesabaran Anda dalam bekerja bersama kami! Izinkan kami menunjukkan kepada Anda bahwa solusi kami berfungsi untuk grup Kubernet yang sangat besar.

## Newest image (Kubernetes Image yang Terbaru)

<Segera akan datang>

## Configurations and Settings (konfigurasi dan pengaturan)

a) Turn on Rate-limiter (to limit rate of API calls to k8s masters)
b) Turn on bz2 compression
c) Turn off kubernetes_events monitoring
d) Turn off kubernetes metrics
e) Do not run Scalyr Agent on master node
f) Increase maximum line size to 50K

## How to run (Bagaiman menjalankannya):

1. Install `git` (e.g. yum install git)
2. `git clone https://github.com/scalyr/agent-poc.git --branch customer_b`
3. `cd agent-poc/k8s/`
4. `export SCALYR_API_KEY=<YOUR_API_KEY>`
5. Edit `configmap.yaml` `SCALYR_K8S_CLUSTER_NAME`: Change `<your-cluster-name>` to name of k8s cluster you wish to monitor.
6. Edit `configmap.yaml` `SCALYR_K8S_RATELIMIT_CLUSTER_NUM_AGENTS`: Enter number of nodes in your cluster. No need to be exact but as close as possible.
7. `source start.sh`

## How to re-pull latest script version if you already downloaded before (Cara mendapatkan versi skrip terbaru jika Anda sudah mengunduh sebelumnya)

1. `cd agent-poc/k8s/`
2. `mv configmap.yaml configmap.yaml.bak`
3. `git reset --hard`
4. `git pull`
5. Edit `configmap.yaml` `SCALYR_K8S_CLUSTER_NAME`: Change `<your-cluster-name>` to name of k8s cluster you wish to monitor.
6. Edit `configmap.yaml` `SCALYR_K8S_RATELIMIT_CLUSTER_NUM_AGENTS`: Enter number of nodes in your cluster. No need to be exact but as close as possible.
7. Copy other custom changes you made from `configmap.yaml.bak` to `configmap.yaml` as needed.
8. `source start.sh`
