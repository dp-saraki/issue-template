#!/usr/bin/env bash
# 使い方: gh auth login 済みの状態で、対象リポジトリ内で実行
#   ./scripts/create-labels.sh            （カレントのリポジトリ）
#   ./scripts/create-labels.sh owner/repo （指定リポジトリ）
set -euo pipefail
REPO_OPT=()
[ "${1:-}" ] && REPO_OPT=(--repo "$1")

mk() { # name color description
  gh label create "$1" --color "$2" --description "$3" --force "${REPO_OPT[@]}"
}
group() { # prefix color desc value...
  local prefix=$1 color=$2 desc=$3; shift 3
  for v in "$@"; do mk "${prefix}:${v}" "$color" "$desc"; done
}

mk "障害" d73a4a "障害管理Issue"

group status    0e8a16 "ステータス" 起票 対応中 修正済み 再テスト済み 完了 重複起票 取り下げ 対応不要 ST申し送り
group priority  b60205 "優先度" 高 低
group test      1d76db "テスト分類" 機能テスト 単性能テスト
group report    5319e7 "起票チーム" フロント バック
group team      fbca04 "担当チーム" フロント バック データレイク インフラ・運用 管理 企画
group class     c5def5 "障害分類" 障害 許容動作 オペレーションミス データ不備 改善 テスト仕様書不備 重複
group cause     f9d0c4 "原因区分" 認識誤り 考慮不足 知識不足 単純バグ 仕様不備 先行成果物不備 データ不備
group cause-phase bfdadc "原因工程" 業務要件定義 システム要件定義 基本設計 詳細設計 製造
group ideal     d4c5f9 "理想検出工程" 業務要件定義 システム要件定義 基本設計 詳細設計 製造 単体テスト 結合テスト
group plan      ededed "企画確認" 確認不要 企画確認前 企画確認中 企画確認完了
group reflect   c2e0c6 "他成果物への反映" 未反映 反映済み 反映不要
group retest    0e8a16 "再テスト結果" OK NG