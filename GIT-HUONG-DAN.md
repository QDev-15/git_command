# Sổ tay Git (tiếng Việt)

Tra cứu nhanh các câu lệnh Git, nhóm theo **công việc**. Mỗi lệnh có chú thích ngay bên cạnh.
Tìm nhanh bằng `Ctrl+F` theo từ khoá (ví dụ: `hoàn tác`, `stash`, `tag`, `tài khoản`, `worktree`, `lỗi`).

- Viết cho Git 2.4x–2.5x trên Windows (Git for Windows + Git Credential Manager). Máy hiện tại: **Git 2.46**.
  Bản mới nhất (09/2026) là **Git 2.55**. Lệnh cần bản mới hơn được ghi rõ `(Git ≥ 2.xx)`, xem mục 27.
- Quy ước trong file:
  - `<...>`: giá trị bạn thay vào, ví dụ `<branch>` → `feature/login`.
  - `[...]`: phần tuỳ chọn, có thể bỏ.
  - ⚠: lệnh có thể **làm mất dữ liệu** hoặc **viết lại lịch sử**. Đọc kỹ chú thích trước khi chạy.
  - Lệnh viết theo cú pháp **Git Bash**. Trong PowerShell hầu hết vẫn chạy được, riêng `HEAD@{1}`, `stash@{0}`
    phải đặt trong nháy: `git reset --hard 'HEAD@{1}'`.
- Tự sửa file này thoải mái. Mục **29. Ghi chú riêng** ở cuối để bạn thêm lệnh của mình.
  Sửa xong chạy `powershell -ExecutionPolicy Bypass -File docs\build-html.ps1` để cập nhật bản HTML.

## Mục lục

**Bắt đầu**

0. [20 lệnh dùng hằng ngày](#0-20-lệnh-dùng-hằng-ngày)
1. [Khái niệm cốt lõi (đọc 5 phút, đỡ sợ Git cả đời)](#1-khái-niệm-cốt-lõi)
2. [Cài đặt & cấu hình lần đầu](#2-cài-đặt--cấu-hình-lần-đầu)
3. [Nhiều tài khoản GitHub / đăng nhập (Credential Manager, SSH)](#3-nhiều-tài-khoản-github--đăng-nhập)
4. [Tạo / lấy repo về máy](#4-tạo--lấy-repo-về-máy)

**Công việc hằng ngày**

5. [Xem trạng thái và thay đổi](#5-xem-trạng-thái-và-thay-đổi)
6. [Stage & commit](#6-stage--commit)
7. [Branch (nhánh)](#7-branch-nhánh)
8. [Làm việc với remote: fetch / pull / push](#8-làm-việc-với-remote-fetch--pull--push)
9. [Gộp code: merge / rebase / squash / cherry-pick](#9-gộp-code-merge--rebase--squash--cherry-pick)
10. [Xử lý conflict](#10-xử-lý-conflict)
11. [Hoàn tác & sửa sai](#11-hoàn-tác--sửa-sai)
12. [Stash (cất tạm thay đổi)](#12-stash-cất-tạm-thay-đổi)
13. [Xem lịch sử & tìm kiếm](#13-xem-lịch-sử--tìm-kiếm)
14. [Tag & phát hành (release)](#14-tag--phát-hành-release)

**Quản lý workspace & repo**

15. [Worktree, submodule, sparse-checkout, nhiều repo](#15-quản-lý-workspace)
16. [.gitignore, .gitattributes, xuống dòng CRLF/LF](#16-gitignore-gitattributes-xuống-dòng-crlflf)
17. [File lớn (LFS), xoá dữ liệu nhạy cảm, bảo trì repo](#17-file-lớn-lfs-xoá-dữ-liệu-nhạy-cảm-bảo-trì-repo)
18. [Patch & bundle: chia sẻ code không qua remote](#18-patch--bundle-chia-sẻ-code-không-qua-remote)
19. [Hooks: tự động kiểm tra trước khi commit / push](#19-hooks-tự-động-kiểm-tra-trước-khi-commit--push)
20. [Ký commit (chữ ký SSH / GPG)](#20-ký-commit-chữ-ký-ssh--gpg)

**Công cụ & quy trình**

21. [GitHub CLI (`gh`): Pull Request, issue, release, Actions](#21-github-cli-gh)
22. [Git trong VS Code](#22-git-trong-vs-code)
23. [Alias & mẹo tăng tốc](#23-alias--mẹo-tăng-tốc)
24. [Chiến lược nhánh & quy tắc làm việc nhóm](#24-chiến-lược-nhánh--quy-tắc-làm-việc-nhóm)
25. [Quy trình mẫu (workflow) từng bước](#25-quy-trình-mẫu-workflow-từng-bước)
26. [Lỗi thường gặp & cách sửa](#26-lỗi-thường-gặp--cách-sửa)
27. [Tính năng mới Git 2.47 → 2.55](#27-tính-năng-mới-git-247--255)
28. [Thuật ngữ](#28-thuật-ngữ)
29. [Ghi chú riêng](#29-ghi-chú-riêng)

---

## 0. 20 lệnh dùng hằng ngày

| Việc | Lệnh |
|---|---|
| Xem đang có gì thay đổi | `git status -sb` |
| Xem chi tiết đã sửa gì | `git diff` / `git diff --staged` |
| Chọn file để commit | `git add <file>` / `git add -p` |
| Commit | `git commit -m "fix: ..."` |
| Lấy code mới về | `git pull` (hoặc `git fetch` rồi xem trước) |
| Đẩy code lên | `git push` |
| Tạo nhánh mới và chuyển sang | `git switch -c feature/x` |
| Chuyển nhánh | `git switch <branch>` |
| Xem lịch sử gọn | `git log --oneline --graph -20` |
| Cập nhật nhánh theo main | `git fetch && git rebase origin/main` |
| Cất tạm việc đang làm | `git stash -u` → `git stash pop` |
| Bỏ thay đổi 1 file | `git restore <file>` ⚠ |
| Bỏ stage 1 file | `git restore --staged <file>` |
| Sửa commit cuối (chưa push) | `git commit --amend` ⚠ |
| Huỷ commit cuối, giữ code | `git reset --soft HEAD~1` |
| Huỷ commit đã push | `git revert <commit>` |
| Ai sửa dòng này | `git blame <file>` |
| Tìm commit theo nội dung code | `git log -S "chuỗi"` |
| Cứu commit / nhánh lỡ mất | `git reflog` |
| Tạo Pull Request | `gh pr create --fill` |

---

## 1. Khái niệm cốt lõi

### 1.1 Ba vùng chứa code

```
 Working tree            Index (staging area)          Repository (.git)
 (file bạn đang sửa) --git add--> (bản chuẩn bị commit) --git commit--> (lịch sử commit)
        ^                                                       |
        +------------------ git switch / git restore -----------+
```

- **Working tree**: thư mục bạn thấy và sửa trực tiếp.
- **Index / staging area**: "giỏ hàng" chứa các thay đổi sẽ vào commit tới. `git add` bỏ vào giỏ.
- **Repository** (`.git`): toàn bộ lịch sử. Mỗi **commit** là một ảnh chụp đầy đủ project, có mã
  hash (vd. `a1b2c3d`), tác giả, thời gian, message và trỏ tới commit cha.

### 1.2 Branch, HEAD, remote

- **Branch** chỉ là một **con trỏ** tới một commit. Tạo nhánh gần như không tốn gì. Commit mới làm
  con trỏ tiến lên.
- **HEAD**: "tôi đang đứng ở đâu", thường trỏ tới một nhánh. **Detached HEAD** = HEAD trỏ thẳng vào
  một commit, không thuộc nhánh nào. Commit tạo ra lúc này dễ bị "mất" nếu không tạo nhánh.
- **Remote** (`origin`): bản repo trên server (GitHub).
  - `origin/main` là **remote-tracking branch**: bản chụp của `main` trên server tại lần `fetch`
    cuối. Nó không tự cập nhật.
  - **Upstream**: nhánh remote mà nhánh local của bạn "theo dõi", để `git pull` / `git push` biết
    làm việc với nhánh nào.
- **ahead / behind**: `ahead 2` = có 2 commit local chưa push; `behind 3` = server có 3 commit
  bạn chưa lấy.

### 1.3 Fetch, merge, rebase trong một hình

```
        A---B---C  main (server có thêm C)
             \
              D---E  feature (của bạn)

merge:   A---B---C-------M  feature      (M = merge commit, giữ nguyên D, E)
              \         /
               D-------E

rebase:  A---B---C---D'---E'  feature    (D, E được "chép lại" lên sau C: lịch sử thẳng, hash mới)
```

- **fast-forward**: nhánh đích không có commit mới nên Git chỉ việc dời con trỏ tới trước,
  không cần merge commit.
- Commit **không bao giờ bị sửa**. Amend / rebase thực chất tạo commit **mới** (hash mới). Vì vậy
  lệnh viết lại lịch sử gây rắc rối nếu người khác đã lấy commit cũ.

### 1.4 Cách chỉ tới một commit

| Cách viết | Nghĩa |
|---|---|
| `a1b2c3d` | Hash rút gọn (7+ ký tự là đủ) |
| `HEAD` | Commit hiện tại |
| `HEAD~1`, `HEAD~3` | 1 / 3 commit trước (đi theo cha thứ nhất) |
| `HEAD^2` | Cha thứ 2 của một merge commit |
| `main`, `origin/main`, `v1.0.0` | Tên nhánh / nhánh remote / tag |
| `HEAD@{2}` | Vị trí HEAD 2 bước trước (theo reflog) |
| `main@{yesterday}` | `main` như hôm qua (theo reflog máy bạn) |
| `@{u}` | Nhánh upstream của nhánh hiện tại |
| `A..B` | Commit có ở B nhưng không có ở A |
| `A...B` | Commit có ở A hoặc B nhưng không ở cả hai |
| `:/fix login` | Commit gần nhất có message chứa "fix login" |

---

## 2. Cài đặt & cấu hình lần đầu

Cài: `winget install Git.Git` (hoặc tải từ git-scm.com). Cập nhật: `git update-git-for-windows`.

Cấu hình có 3 cấp. Cấp càng hẹp càng được ưu tiên: `--local` > `--global` > `--system`.

| Cấp | Phạm vi | File |
|---|---|---|
| `--system` | Mọi user trên máy | `C:\Program Files\Git\etc\gitconfig` |
| `--global` | User hiện tại | `C:\Users\<bạn>\.gitconfig` |
| `--local` (mặc định) | Chỉ repo hiện tại | `<repo>\.git\config` |

### 2.1 Bắt buộc

```bash
git --version                                   # Xem phiên bản Git
git config --global user.name "Nguyen Huu Quynh"           # Tên hiển thị trong commit
git config --global user.email "ban@example.com"           # Email trong commit (nên trùng email tài khoản GitHub)
git config --local  user.email "quynh.nguyenhuu@imipgroup.com"  # Email riêng cho repo hiện tại (ghi đè global)
```

### 2.2 Nên đặt (khuyến nghị)

```bash
git config --global init.defaultBranch main     # Repo mới tạo dùng nhánh "main" thay vì "master"
git config --global core.editor "code --wait"   # Dùng VS Code để soạn commit message / rebase
git config --global core.autocrlf true          # Windows: checkout ra CRLF, commit vào LF (xem mục 16)
git config --global core.longpaths true         # Windows: cho phép đường dẫn dài hơn 260 ký tự
git config --global core.quotepath false        # Hiện tên file tiếng Việt đúng dấu, không bị \303\241...
git config --global pull.rebase true            # "git pull" sẽ rebase thay vì tạo merge commit
git config --global rebase.autoStash true       # Tự stash / pop khi pull --rebase lúc đang có thay đổi
git config --global rebase.autoSquash true      # rebase -i tự xếp các commit fixup! vào đúng chỗ
git config --global rebase.updateRefs true      # Rebase chồng nhánh (stacked branches) tự cập nhật các nhánh con
git config --global fetch.prune true            # Tự xoá các nhánh remote đã bị xoá khi fetch
git config --global fetch.pruneTags true        # ... và các tag đã bị xoá trên server
git config --global push.autoSetupRemote true   # Lần push đầu của nhánh mới tự tạo upstream (khỏi cần -u)
git config --global push.followTags true        # Push kèm các tag có chú thích trỏ vào commit đang push
git config --global rerere.enabled true         # Ghi nhớ cách đã giải conflict, lần sau tự áp dụng lại
git config --global merge.conflictstyle zdiff3  # Conflict hiện thêm đoạn gốc (base), dễ giải hơn
git config --global diff.algorithm histogram    # Diff dễ đọc hơn thuật toán mặc định
git config --global diff.colorMoved zebra       # Tô màu riêng các đoạn code chỉ bị di chuyển
git config --global branch.sort -committerdate  # "git branch" xếp nhánh mới làm việc lên đầu
git config --global tag.sort version:refname    # "git tag" xếp theo số phiên bản (v1.10 sau v1.9)
git config --global help.autocorrect prompt     # Gõ sai lệnh (git stauts) thì gợi ý và hỏi chạy lệnh đúng
git config --global commit.verbose true         # Khi soạn commit message, hiện luôn diff bên dưới
```

### 2.3 Xem / sửa / xoá cấu hình

```bash
git config --list --show-origin                 # Liệt kê mọi cấu hình kèm file chứa nó
git config --show-origin --get user.email       # Xem một giá trị và nó đến từ file nào
git config --global --unset core.editor         # Xoá một cấu hình
git config --global --edit                      # Mở file cấu hình global để sửa tay
git config --global commit.template ~/.gitmessage.txt   # Mẫu commit message soạn sẵn
```

---

## 3. Nhiều tài khoản GitHub / đăng nhập

Máy này đang có 2 tài khoản GitHub trong Git Credential Manager (GCM): `QDev-15` và `quynhvp90`.
Khi một repo không được chỉ định tài khoản, **mỗi lần push GCM sẽ hỏi chọn tài khoản**.

Từ 2021 GitHub **không nhận mật khẩu** khi push qua HTTPS. Phải dùng GCM (đăng nhập qua trình duyệt),
Personal Access Token hoặc SSH.

### 3.1 Git Credential Manager (HTTPS, mặc định trên Windows)

```bash
git credential-manager github list              # Liệt kê các tài khoản GitHub đã đăng nhập
git credential-manager github login             # Đăng nhập thêm một tài khoản (mở trình duyệt)
git credential-manager github logout <user>     # Đăng xuất / xoá một tài khoản

# Gắn một tài khoản cho RIÊNG repo hiện tại, để hết bị hỏi khi push:
git config --local credential.https://github.com.username QDev-15

# Cách khác: đưa username vào URL remote
git remote set-url origin https://QDev-15@github.com/QDev-15/ImageProcessing.git

git config --global credential.helper manager   # Bật lại GCM nếu bị mất cấu hình
```

- Xoá mật khẩu / token đã lưu: *Control Panel → Credential Manager → Windows Credentials*, tìm
  các mục `git:https://github.com...`.
- Lỗi `403` / `Permission ... denied to <user>`: đang dùng nhầm tài khoản, hoặc tài khoản không có
  quyền ghi vào repo.

### 3.2 Tự động chọn tài khoản / email theo thư mục (`includeIf`)

Mọi repo nằm trong một thư mục sẽ tự dùng email và tài khoản riêng, không phải cấu hình từng repo.

Trong `C:\Users\<bạn>\.gitconfig`:

```ini
[includeIf "gitdir/i:D:/Working/project/"]
    path = ~/.gitconfig-work
[includeIf "gitdir/i:D:/Personal/"]
    path = ~/.gitconfig-personal
# Theo URL remote (Git ≥ 2.36): mọi repo có remote thuộc QDev-15
[includeIf "hasconfig:remote.*.url:https://github.com/QDev-15/**"]
    path = ~/.gitconfig-qdev
```

File `~/.gitconfig-work`:

```ini
[user]
    email = quynh.nguyenhuu@imipgroup.com
[credential "https://github.com"]
    username = quynhvp90
```

(`gitdir/i` = không phân biệt hoa thường, nên dùng trên Windows. Đường dẫn dùng dấu `/` và kết thúc bằng `/`.)
Kiểm tra: `git config --show-origin --get user.email` trong một repo thuộc thư mục đó.

### 3.3 SSH (thay cho HTTPS)

```bash
ssh-keygen -t ed25519 -C "ban@example.com" -f ~/.ssh/id_qdev15   # Tạo cặp khoá SSH
cat ~/.ssh/id_qdev15.pub                        # Copy khoá công khai → GitHub → Settings → SSH and GPG keys
ssh -T git@github.com                           # Kiểm tra kết nối ("Hi <user>!" là OK)
git remote set-url origin git@github.com:QDev-15/ImageProcessing.git  # Chuyển remote sang SSH
```

Nhiều tài khoản với SSH: đặt alias host trong `~/.ssh/config`.

```
Host github-qdev
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_qdev15
    IdentitiesOnly yes
```

Rồi dùng URL `git@github-qdev:QDev-15/ImageProcessing.git`.

Mạng công ty chặn cổng 22: thêm `Port 443` và `HostName ssh.github.com` vào khối `Host` ở trên.

---

## 4. Tạo / lấy repo về máy

```bash
git init                                        # Biến thư mục hiện tại thành repo Git
git init <thư-mục>                              # Tạo thư mục mới và init
git clone <url>                                 # Tải repo về (tạo thư mục trùng tên repo)
git clone <url> <thư-mục>                       # Tải về vào thư mục tuỳ chọn
git clone -b <branch> <url>                     # Clone và checkout sẵn một nhánh
git clone --depth 1 <url>                       # "Shallow": chỉ commit mới nhất (nhanh, nhẹ; không có lịch sử)
git clone --filter=blob:none <url>              # "Partial clone": đủ lịch sử, nội dung file tải khi cần (repo lớn)
git clone --recurse-submodules <url>            # Clone kèm các submodule
git clone --single-branch -b <branch> <url>     # Chỉ lấy một nhánh

git fetch --deepen=50                           # Repo shallow: lấy thêm 50 commit lịch sử
git fetch --unshallow                           # Repo shallow: lấy đủ toàn bộ lịch sử

git remote add origin <url>                     # Gắn repo local với repo trên GitHub
git push -u origin main                         # Push lần đầu và đặt upstream
gh repo create <tên> --private --source . --push  # Tạo repo trên GitHub từ thư mục hiện tại và push luôn
```

**Fork** (sao repo người khác về tài khoản mình để đóng góp):

```bash
gh repo fork <owner>/<repo> --clone             # Fork + clone; tự thêm remote "upstream" trỏ về repo gốc
git remote add upstream <url-repo-gốc>          # (nếu fork bằng web) thêm remote repo gốc
git fetch upstream && git rebase upstream/main  # Cập nhật fork theo repo gốc
git push origin main                            # Đẩy bản đã cập nhật lên fork của bạn
```

---

## 5. Xem trạng thái và thay đổi

```bash
git status                                      # Trạng thái: file sửa / đã stage / chưa theo dõi
git status -sb                                  # Dạng ngắn + tên nhánh, ahead/behind
git status --ignored                            # Hiện cả file bị .gitignore

git diff                                        # Thay đổi CHƯA stage (working tree so với index)
git diff --staged                               # Thay đổi ĐÃ stage (sẽ vào commit tới)
git diff HEAD                                   # Toàn bộ thay đổi so với commit cuối
git diff <branch1>..<branch2>                   # So sánh 2 nhánh (đầu nhánh với đầu nhánh)
git diff <branch1>...<branch2>                  # Chỉ thay đổi của branch2 kể từ lúc tách khỏi branch1 (giống PR)
git diff <commit> -- <file>                     # Diff của một file so với một commit
git diff --stat                                 # Chỉ tóm tắt số dòng thêm / xoá theo file
git diff --name-only                            # Chỉ tên file thay đổi
git diff --name-status                          # Tên file + loại thay đổi (A thêm, M sửa, D xoá, R đổi tên)
git diff --word-diff                            # Diff theo từ (hợp với văn bản, README)
git diff -w                                     # Bỏ qua khác biệt khoảng trắng
git diff --check                                # Báo khoảng trắng thừa cuối dòng, dấu conflict sót lại
git difftool                                    # Mở diff bằng công cụ đồ hoạ đã cấu hình
git difftool --dir-diff                         # So sánh cả thư mục trong công cụ đồ hoạ
```

---

## 6. Stage & commit

### 6.1 Stage

```bash
git add <file>                                  # Stage một file
git add .                                       # Stage mọi thay đổi trong thư mục hiện tại trở xuống
git add -A                                      # Stage mọi thay đổi trong toàn repo (kể cả file bị xoá)
git add -u                                      # Chỉ stage file ĐÃ theo dõi (bỏ qua file mới)
git add -p                                      # Chọn từng đoạn (hunk): y = lấy, n = bỏ, s = chia nhỏ, e = sửa tay
git add -N <file>                               # Báo trước file mới ("intent to add") để nó hiện trong git diff
git restore --staged <file>                     # Bỏ stage (file vẫn giữ nguyên thay đổi)
git restore --staged -p <file>                  # Bỏ stage từng đoạn
```

### 6.2 Commit

```bash
git commit -m "Nội dung"                        # Commit với message ngắn
git commit                                      # Mở editor để viết message dài (dòng 1 = tiêu đề)
git commit -m "Tiêu đề" -m "Mô tả chi tiết"     # Mỗi -m là một đoạn
git commit -v                                   # Hiện diff trong editor khi viết message
git commit -am "Nội dung"                       # Stage mọi file ĐÃ được theo dõi + commit (bỏ qua file mới)
git commit --amend                              # ⚠ Sửa commit cuối (message / thêm file). Chỉ dùng khi CHƯA push
git commit --amend --no-edit                    # ⚠ Thêm file vừa stage vào commit cuối, giữ nguyên message
git commit --amend --author="Tên <email>"       # ⚠ Sửa tác giả commit cuối
git commit --amend --reset-author --no-edit     # ⚠ Đặt lại tác giả theo user.name / user.email hiện tại
git commit --allow-empty -m "Trigger CI"        # Commit rỗng (vd. để kích hoạt CI)
git commit --fixup <commit>                     # Tạo commit "fixup!" sửa cho commit cũ; gộp lại bằng rebase -i --autosquash
git commit --fixup=reword:<commit>              # Chỉ sửa message của commit cũ (gộp khi autosquash)
git commit --trailer "Co-authored-by: Tên <email>" -m "..."   # Ghi nhận đồng tác giả (GitHub hiện cả 2 avatar)
git commit --no-verify -m "..."                 # Bỏ qua hook pre-commit / commit-msg (chỉ khi thật cần)
```

### 6.3 Xoá / đổi tên file

```bash
git rm <file>                                   # Xoá file và stage việc xoá
git rm -r <thư-mục>                             # Xoá cả thư mục
git rm --cached <file>                          # Ngừng theo dõi file nhưng giữ file trên đĩa (vd. lỡ commit file cấu hình)
git mv <cũ> <mới>                               # Đổi tên / di chuyển file (giữ lịch sử)
git mv readme.md README.md                      # Windows: đổi chỉ hoa / thường phải dùng git mv
```

### 6.4 Viết commit message tốt

- Dòng đầu ≤ 72 ký tự, thể mệnh lệnh, nói **cái gì**: `fix: không crash khi PDF không có trang`.
- Dòng thứ 2 để trống. Phần thân giải thích **vì sao** (và ảnh hưởng gì), không kể lại diff.
- Quy ước **Conventional Commits**: `feat:` tính năng, `fix:` sửa lỗi, `docs:`, `refactor:`, `perf:`,
  `test:`, `build:`, `ci:`, `chore:`. Thay đổi phá vỡ tương thích: `feat!:` hoặc dòng `BREAKING CHANGE:`.
- Mỗi commit là một thay đổi trọn vẹn, build được. Dùng `git add -p` để tách.

---

## 7. Branch (nhánh)

```bash
git branch                                      # Liệt kê nhánh local (* = nhánh hiện tại)
git branch -a                                   # Liệt kê cả nhánh remote
git branch -vv                                  # Kèm commit cuối + nhánh upstream + ahead/behind
git branch --merged                             # Các nhánh đã merge vào nhánh hiện tại (xoá an toàn)
git branch --no-merged                          # Các nhánh chưa merge
git branch --contains <commit>                  # Những nhánh nào chứa commit này
git branch --list "feature/*"                   # Lọc theo mẫu
git branch --show-current                       # In tên nhánh hiện tại

git switch <branch>                             # Chuyển sang nhánh (lệnh mới, thay cho checkout)
git switch -c <branch>                          # Tạo nhánh mới từ vị trí hiện tại và chuyển sang
git switch -c <branch> <commit|tag>             # Tạo nhánh từ một commit / tag cụ thể
git switch -c <branch> origin/<branch>          # Tạo nhánh local theo dõi một nhánh remote
git switch <branch-chỉ-có-trên-remote>          # Tự tạo nhánh local theo dõi origin/<branch> nếu tên khớp
git switch -                                    # Quay lại nhánh vừa ở trước đó
git switch --detach <commit>                    # Đứng ở một commit (detached HEAD) để xem / test
git switch --orphan <branch>                    # Nhánh mới không có lịch sử (vd. gh-pages)
git checkout <branch>                           # Cách cũ để chuyển nhánh (vẫn dùng được)

git branch -m <tên-mới>                         # Đổi tên nhánh hiện tại
git branch -m <cũ> <mới>                        # Đổi tên nhánh khác
git branch -d <branch>                          # Xoá nhánh local (chỉ khi đã merge)
git branch -D <branch>                          # ⚠ Xoá nhánh local kể cả chưa merge
git push origin --delete <branch>               # Xoá nhánh trên remote
git branch -u origin/<branch>                   # Đặt upstream cho nhánh hiện tại
git branch --unset-upstream                     # Bỏ upstream
```

Đổi tên nhánh đã có trên remote (vd. `master` → `main`):

```bash
git branch -m master main
git push -u origin main
git push origin --delete master                 # Trước đó đổi "default branch" trên GitHub sang main
```

Xoá mọi nhánh local đã merge vào main (trừ main / master):

```bash
git switch main && git branch --merged | grep -vE '^\*|main|master' | xargs -r git branch -d
```

Đặt tên nhánh gợi ý: `feature/<mô-tả>`, `fix/<mô-tả>`, `hotfix/<mô-tả>`, `release/<phiên-bản>`,
viết thường, nối bằng `-`, có thể kèm mã ticket: `feature/123-export-pdf`.

---

## 8. Làm việc với remote: fetch / pull / push

### 8.1 Remote

```bash
git remote -v                                   # Xem các remote và URL
git remote add <tên> <url>                      # Thêm remote (vd. "upstream" khi fork)
git remote set-url origin <url>                 # Đổi URL remote (vd. đổi HTTPS ↔ SSH, repo chuyển chủ)
git remote rename <cũ> <mới>                    # Đổi tên remote
git remote remove <tên>                         # Xoá remote
git remote show origin                          # Chi tiết remote: nhánh, upstream, trạng thái
git remote prune origin                         # Xoá các origin/<branch> đã không còn trên server
```

### 8.2 Fetch & pull

```bash
git fetch                                       # Tải commit mới từ remote, KHÔNG đụng code đang làm
git fetch --all --prune                         # Fetch mọi remote + xoá nhánh remote đã bị xoá
git fetch origin <branch>                       # Chỉ fetch một nhánh
git fetch origin pull/123/head:pr-123           # Lấy code của Pull Request #123 về nhánh pr-123
git log HEAD..origin/main --oneline             # Sau fetch: xem server có gì mới trước khi pull

git pull                                        # fetch + merge (hoặc rebase nếu pull.rebase=true)
git pull --rebase                               # fetch + rebase commit local lên trên (lịch sử thẳng)
git pull --ff-only                              # Chỉ cập nhật nếu fast-forward được, không tự tạo merge commit
git pull origin main                            # Kéo main của server vào nhánh hiện tại
```

### 8.3 Push

```bash
git push                                        # Đẩy nhánh hiện tại lên upstream
git push -u origin <branch>                     # Push lần đầu + đặt upstream
git push origin HEAD                            # Đẩy nhánh hiện tại lên nhánh cùng tên trên remote
git push origin <local>:<remote>                # Push nhánh local lên nhánh remote khác tên
git push --force-with-lease                     # ⚠ Force push AN TOÀN: từ chối nếu remote có commit người khác mới đẩy
git push --force-with-lease --force-if-includes # ⚠ An toàn hơn nữa: còn kiểm tra bạn đã từng thấy commit mới đó chưa
git push --force                                # ⚠⚠ Ghi đè remote bất kể thế nào. Tránh dùng trên nhánh chung
git push --tags                                 # Đẩy toàn bộ tag
git push --atomic origin main v1.2.0            # Đẩy nhiều ref: hoặc tất cả thành công, hoặc không cái nào
git push --dry-run                              # Xem sẽ push gì mà không push thật
git push -o ci.skip                             # Gửi "push option" (vd. GitLab bỏ qua CI; GitHub không hỗ trợ)

git ls-remote --heads origin                    # Xem nhánh trên remote mà không cần fetch
git ls-remote --tags origin                     # Xem tag trên remote
```

**Refspec** (`<nguồn>:<đích>`) là cú pháp của push / fetch: `git push origin feature:main` = đẩy
nhánh local `feature` lên nhánh `main` của server. `git push origin :old` (nguồn rỗng) = xoá nhánh `old`.

---

## 9. Gộp code: merge / rebase / squash / cherry-pick

### 9.1 Chọn cách gộp

| Cách | Lịch sử | Khi nào dùng |
|---|---|---|
| **Merge** (`git merge`) | Giữ nguyên, thêm merge commit | Gộp nhánh đã chia sẻ; cần giữ dấu vết nhánh |
| **Rebase** (`git rebase`) | Thẳng, commit được "chép lại" (hash mới) | Cập nhật nhánh **riêng** của bạn theo main trước khi tạo PR |
| **Squash** (`merge --squash`, "Squash and merge" trên GitHub) | Gom cả nhánh thành 1 commit | Nhánh có nhiều commit lặt vặt |
| **Cherry-pick** | Chép từng commit | Mang một bản sửa lỗi sang nhánh release |

### 9.2 Merge

```bash
git merge <branch>                              # Gộp <branch> vào nhánh hiện tại
git merge --no-ff <branch>                      # Luôn tạo merge commit (giữ dấu vết nhánh feature)
git merge --ff-only <branch>                    # Chỉ gộp nếu fast-forward được
git merge --squash <branch>                     # Gom mọi thay đổi thành 1 lần stage, rồi tự commit
git merge -X theirs <branch>                    # Conflict thì tự lấy phía <branch> (chỉ các đoạn conflict)
git merge -X ours <branch>                      # Conflict thì tự giữ phía nhánh hiện tại
git merge --abort                               # Huỷ merge đang dở (khi conflict), quay về trước merge
git merge-base main feature                     # Commit tổ tiên chung của 2 nhánh
```

### 9.3 Rebase

```bash
git rebase <branch>                             # ⚠ Đặt các commit của nhánh hiện tại lên trên <branch>
git rebase origin/main                          # Cập nhật nhánh feature theo main mới nhất (lịch sử thẳng)
git rebase -i HEAD~5                            # ⚠ Sửa 5 commit gần nhất (xem bảng lệnh bên dưới)
git rebase -i --autosquash <base>               # Tự gộp các commit "fixup!" vào commit gốc
git rebase -i --root                            # ⚠ Sửa từ commit đầu tiên của repo
git rebase --continue                           # Tiếp tục sau khi giải conflict
git rebase --skip                               # Bỏ qua commit đang gây conflict
git rebase --abort                              # Huỷ rebase, quay về như cũ
git rebase --onto <base-mới> <base-cũ> <branch> # Chuyển một đoạn commit sang base khác
git rebase --exec "dotnet build" origin/main    # Chạy lệnh sau mỗi commit được rebase (kiểm tra commit nào cũng build được)
git range-diff origin/main@{1} origin/main HEAD # So sánh bản cũ và bản mới của một chuỗi commit sau rebase
```

Các lệnh trong màn hình `rebase -i`:

| Lệnh | Tác dụng |
|---|---|
| `pick` | Giữ nguyên commit |
| `reword` (`r`) | Giữ commit, sửa message |
| `edit` (`e`) | Dừng lại ở commit đó để sửa code (sửa xong: `git commit --amend`, `git rebase --continue`) |
| `squash` (`s`) | Gộp vào commit phía trên, gộp cả message |
| `fixup` (`f`) | Gộp vào commit phía trên, bỏ message của commit này |
| `drop` (`d`) | Xoá commit |
| `exec` (`x`) | Chạy một lệnh shell tại điểm đó |
| đổi thứ tự dòng | Đổi thứ tự commit |

**Quy tắc vàng của rebase:** không rebase các commit đã push lên nhánh mà người khác đang dùng.

### 9.4 Cherry-pick

```bash
git cherry-pick <commit>                        # Chép một commit từ nhánh khác vào nhánh hiện tại
git cherry-pick <c1>..<c2>                      # Chép một dải commit (không gồm c1)
git cherry-pick <c1>^..<c2>                     # Chép một dải commit (gồm cả c1)
git cherry-pick -x <commit>                     # Ghi thêm "(cherry picked from commit ...)" vào message
git cherry-pick -n <commit>                     # Chép thay đổi nhưng chưa commit
git cherry-pick -m 1 <merge-commit>             # Chép một merge commit (lấy theo cha thứ 1)
git cherry-pick --continue                      # Tiếp tục sau khi giải conflict
git cherry-pick --abort                         # Huỷ cherry-pick đang dở
```

---

## 10. Xử lý conflict

```bash
git status                                      # Xem file đang conflict ("both modified")
git diff --name-only --diff-filter=U            # Liệt kê các file còn conflict
# Mở file, tìm các khối conflict, sửa thành nội dung đúng, xoá các dấu <<<<<<< ||||||| ======= >>>>>>>
git add <file>                                  # Đánh dấu đã giải xong
git merge --continue                            # (hoặc rebase --continue / cherry-pick --continue)

git checkout --ours <file>                      # Lấy nguyên bản của nhánh HIỆN TẠI cho file đó
git checkout --theirs <file>                    # Lấy nguyên bản của nhánh ĐANG GỘP VÀO
git checkout -m <file>                          # Đặt lại file về trạng thái conflict ban đầu (giải lại từ đầu)
git mergetool                                   # Mở công cụ merge đồ hoạ
git log --merge -p <file>                       # Các commit hai bên gây ra conflict ở file này
git rerere diff                                 # (rerere bật) xem cách giải đã được ghi nhớ
```

Khối conflict (với `merge.conflictstyle zdiff3`):

```
<<<<<<< HEAD            ← phía nhánh hiện tại ("ours")
code của bạn
||||||| base            ← bản gốc trước khi hai bên cùng sửa
code gốc
=======
code của nhánh kia      ← phía "theirs"
>>>>>>> feature/x
```

Lưu ý: khi **rebase**, "ours" là nhánh đích (base) còn "theirs" là commit của bạn, ngược với merge.

Dùng công cụ đồ hoạ: VS Code tự nhận file conflict (nút *Accept Current / Incoming / Both*, hoặc
*Resolve in Merge Editor*). Đặt VS Code làm mergetool:

```bash
git config --global merge.tool vscode
git config --global mergetool.vscode.cmd 'code --wait --merge $REMOTE $LOCAL $BASE $MERGED'
```

---

## 11. Hoàn tác & sửa sai

### 11.1 Bảng tra nhanh

| Tình huống | Lệnh |
|---|---|
| Bỏ thay đổi chưa stage của 1 file | `git restore <file>` ⚠ |
| Bỏ mọi thay đổi chưa commit | `git restore .` ⚠ (+ `git clean -fd` cho file mới) |
| Bỏ stage 1 file | `git restore --staged <file>` |
| Lấy lại file như ở commit X | `git restore --source <commit> <file>` |
| Lấy lại file đã bị xoá ở commit trước | `git restore --source <commit>~1 <file>` |
| Sửa message / thêm file vào commit cuối (chưa push) | `git commit --amend` ⚠ |
| Huỷ commit cuối, giữ thay đổi ở trạng thái stage | `git reset --soft HEAD~1` |
| Huỷ commit cuối, giữ thay đổi (chưa stage) | `git reset HEAD~1` |
| Huỷ commit cuối **và vứt luôn thay đổi** | `git reset --hard HEAD~1` ⚠ |
| Gộp 3 commit cuối thành 1 | `git reset --soft HEAD~3 && git commit` |
| Đưa nhánh về đúng như remote | `git fetch && git reset --hard origin/<branch>` ⚠ |
| Huỷ một commit **đã push** (an toàn, tạo commit đảo ngược) | `git revert <commit>` |
| Revert nhiều commit, gộp 1 lần | `git revert --no-commit <c1>..<c2> && git commit` |
| Revert một merge commit | `git revert -m 1 <merge-commit>` |
| Xoá file chưa theo dõi (xem trước) | `git clean -n` |
| Xoá file / thư mục chưa theo dõi | `git clean -fd` ⚠ |
| Xoá cả file bị .gitignore (bin/, obj/...) | `git clean -fdx` ⚠⚠ |
| Xoá có hỏi từng file | `git clean -i` |

### 11.2 Ba kiểu `reset` khác nhau thế nào

`git reset <commit>` dời con trỏ nhánh về `<commit>`. Khác nhau ở chỗ index và working tree ra sao:

| Kiểu | Con trỏ nhánh | Index (stage) | Working tree (file) | Mất dữ liệu? |
|---|---|---|---|---|
| `--soft` | Dời | Giữ (thay đổi vẫn ở trạng thái đã stage) | Giữ | Không |
| `--mixed` (mặc định) | Dời | Reset (thay đổi thành chưa stage) | Giữ | Không |
| `--hard` | Dời | Reset | **Reset (mất thay đổi chưa commit)** | ⚠ Có |
| `--keep` | Dời | Reset | Giữ thay đổi chưa commit; từ chối nếu có xung đột | Không |

### 11.3 Cứu dữ liệu (lỡ reset --hard, xoá nhánh, rebase hỏng)

```bash
git reflog                                      # Nhật ký mọi vị trí HEAD từng đi qua (giữ ~90 ngày)
git reflog show <branch>                        # Nhật ký riêng của một nhánh
git reset --hard HEAD@{2}                       # Quay về vị trí trong reflog
git branch cuu-nhanh <commit>                   # Tạo lại nhánh từ commit tìm thấy trong reflog
git fsck --lost-found                           # Tìm commit / blob "mồ côi" (cách cuối cùng)
```

Thay đổi **chưa từng được commit hay stash** mà bị `restore` / `reset --hard` thì Git không cứu
được. Thử *Local History* của VS Code (*Timeline* ở Explorer).

### 11.4 Sửa lịch sử cũ

```bash
git rebase -i <commit>~1                        # ⚠ Sửa / gộp / xoá / đổi thứ tự từ <commit> trở về sau
git commit --fixup <commit> && git rebase -i --autosquash <commit>~1   # ⚠ Sửa code của commit cũ
git history reword <commit>                     # ⚠ (Git ≥ 2.54, thử nghiệm) sửa message commit cũ, không đụng working tree
git history fixup <commit>                      # ⚠ (Git ≥ 2.55) đưa phần đang stage vào commit cũ
git history split <commit>                      # ⚠ (Git ≥ 2.54) tách một commit thành hai
```

Đổi tác giả / email cho nhiều commit (vd. lỡ commit bằng email cá nhân):

```bash
git rebase -r <commit-gốc> --exec "git commit --amend --no-edit --reset-author"   # ⚠ Mọi commit sau <commit-gốc>
```

---

## 12. Stash (cất tạm thay đổi)

Dùng khi đang làm dở mà cần chuyển nhánh / pull gấp.

```bash
git stash                                       # Cất thay đổi đã theo dõi, working tree sạch
git stash push -m "đang làm login"              # Cất kèm ghi chú
git stash -u                                    # Cất cả file mới (untracked)
git stash -a                                    # Cất cả file bị .gitignore
git stash push -- <file1> <file2>               # Chỉ cất một số file
git stash push --staged                         # Chỉ cất phần đã stage
git stash --keep-index                          # Cất nhưng giữ lại phần đã stage trong working tree
git stash list                                  # Danh sách các lần cất
git stash show -p stash@{0}                     # Xem nội dung một stash
git stash pop                                   # Lấy stash mới nhất ra và XOÁ khỏi danh sách
git stash apply stash@{1}                       # Lấy ra nhưng GIỮ trong danh sách
git stash drop stash@{1}                        # Xoá một stash
git stash clear                                 # ⚠ Xoá toàn bộ stash
git stash branch <branch-mới>                   # Tạo nhánh mới từ stash (khi pop bị conflict)
git restore --source=stash@{0} -- <file>        # Lấy một file từ stash

git stash export --to-ref refs/stashes/backup   # (Git ≥ 2.51) Xuất stash thành ref để push / mang sang máy khác
git stash import <commit>                       # (Git ≥ 2.51) Nhập lại stash đã xuất
```

Lỡ `git stash drop` / `clear`: tìm lại bằng
`git fsck --unreachable | grep commit | cut -d' ' -f3 | xargs git log --merges --no-walk --oneline`,
rồi `git stash apply <hash>`.

---

## 13. Xem lịch sử & tìm kiếm

### 13.1 git log

```bash
git log                                         # Lịch sử đầy đủ
git log --oneline --graph --decorate --all      # Cây lịch sử gọn, mọi nhánh
git log -n 10                                   # 10 commit gần nhất
git log -p <file>                               # Lịch sử kèm diff của một file
git log --follow <file>                         # Lịch sử file, kể cả trước khi đổi tên
git log -L 120,160:<file>                       # Lịch sử của đúng các dòng 120-160
git log -L :ExportPdf:<file>                    # Lịch sử của một hàm (theo tên)
git log --author="Quynh"                        # Lọc theo tác giả
git log --since="2 weeks ago" --until="yesterday"  # Lọc theo thời gian
git log --grep="fix" -i                         # Tìm theo nội dung commit message (không phân biệt hoa thường)
git log -S "ToBitonal"                          # Tìm commit thêm / xoá chuỗi này trong code ("pickaxe")
git log -G "regex"                              # Như -S nhưng dùng regex
git log main..feature                           # Commit có ở feature nhưng chưa có ở main
git log @{u}..                                  # Commit local chưa push
git log --first-parent main                     # Chỉ các commit / merge trên chính main (bỏ chi tiết nhánh con)
git log --merges                                # Chỉ merge commit
git log --no-merges                             # Bỏ merge commit
git log --stat                                  # Kèm thống kê file thay đổi
git log --pretty=format:"%h %ad %an %s" --date=short  # Định dạng tuỳ chỉnh
git log -- <thư-mục>                            # Chỉ các commit đụng tới thư mục đó
git log --diff-filter=D --name-only             # Các commit đã xoá file (tìm file bị xoá)
```

Mã định dạng hay dùng cho `--pretty=format:`: `%h` hash ngắn, `%H` hash đầy đủ, `%an` tác giả,
`%ae` email, `%ad` ngày (theo `--date=short|iso|relative`), `%ar` "3 days ago", `%s` tiêu đề,
`%d` nhánh / tag trỏ vào.

### 13.2 Xem nội dung, người sửa, tìm trong code

```bash
git show <commit>                               # Chi tiết một commit
git show --stat <commit>                        # Chỉ danh sách file thay đổi
git show <commit>:<đường/dẫn/file>              # Nội dung file tại một commit
git show <commit>:<file> > file-cu.cs           # Xuất bản cũ của file ra đĩa
git blame <file>                                # Ai sửa từng dòng, ở commit nào
git blame -L 10,30 <file>                       # Chỉ các dòng 10-30
git blame -w -C <file>                          # Bỏ qua sửa khoảng trắng, dò code bị chép / di chuyển
git config blame.ignoreRevsFile .git-blame-ignore-revs  # Bỏ qua các commit chỉ format code khi blame
git last-modified <thư-mục>                     # (Git ≥ 2.52) Commit gần nhất sửa từng file trong thư mục
git shortlog -sn                                # Số commit theo từng người
git shortlog -sn --since="1 month ago"          # ... trong tháng qua
git grep "từ khoá"                              # Tìm trong code đang theo dõi (nhanh hơn grep thường)
git grep -n -i "từ khoá" -- "*.cs"              # Kèm số dòng, không phân biệt hoa thường, chỉ file .cs
git grep "từ khoá" <commit>                     # Tìm trong code tại một commit
git log --stat --since="1 week ago"          # Commit + file thay đổi trong tuần (thay cho git whatchanged đã bị bỏ)
```

### 13.3 Tìm commit gây lỗi (`bisect`)

```bash
git bisect start                                # Bắt đầu tìm kiếm nhị phân
git bisect bad                                  # Đánh dấu commit hiện tại là lỗi
git bisect good <commit|tag>                    # Đánh dấu một commit cũ là tốt
# Git checkout commit ở giữa → test → gõ good / bad → lặp đến khi Git chỉ ra commit gây lỗi
git bisect skip                                 # Commit này không test được (vd. không build), bỏ qua
git bisect reset                                # Kết thúc, quay về nhánh ban đầu
git bisect run <lệnh-test>                      # Tự động: lệnh trả 0 = tốt, khác 0 = lỗi
```

---

## 14. Tag & phát hành (release)

```bash
git tag                                         # Liệt kê tag
git tag -l "v1.*"                               # Lọc tag theo mẫu
git tag v1.0.0                                  # Tag nhẹ (lightweight) tại HEAD
git tag -a v1.0.0 -m "Bản 1.0.0"                # Tag có chú thích (khuyên dùng cho release)
git tag -a v1.0.0 <commit> -m "..."             # Tag một commit cũ
git tag -s v1.0.0 -m "..."                      # Tag có chữ ký (mục 20)
git show v1.0.0                                 # Xem thông tin tag
git push origin v1.0.0                          # Đẩy một tag
git push --tags                                 # Đẩy mọi tag
git tag -d v1.0.0                               # Xoá tag local
git push origin --delete v1.0.0                 # Xoá tag trên remote
git tag -f v1.0.0 <commit> && git push -f origin v1.0.0  # ⚠ Dời tag sang commit khác (tránh nếu đã phát hành)
git fetch --tags                                # Lấy tag từ server
git describe --tags                             # Mô tả vị trí hiện tại theo tag gần nhất (vd. v1.0.0-5-gabc123)
git log v1.0.0..v1.1.0 --oneline                # Các thay đổi giữa 2 bản phát hành (làm changelog)
git archive --format=zip -o release.zip v1.0.0  # Xuất mã nguồn tại tag thành file zip
git switch --detach v1.0.0                      # Đứng ở bản 1.0.0 để build lại / kiểm tra
```

Đánh số phiên bản gợi ý (SemVer): `MAJOR.MINOR.PATCH`. Tăng MAJOR khi thay đổi không tương thích,
MINOR khi thêm tính năng, PATCH khi sửa lỗi. Bản thử: `v1.2.0-beta.1`.

---

## 15. Quản lý workspace

### 15.1 Worktree: làm nhiều nhánh cùng lúc, mỗi nhánh một thư mục

Không cần stash / chuyển nhánh. Ví dụ: vừa sửa hotfix vừa giữ nguyên feature đang làm dở, hoặc
để một thư mục chạy build / test lâu trong khi code tiếp ở thư mục khác.

```bash
git worktree add ../ImageProcessing-hotfix hotfix/x    # Checkout nhánh có sẵn ra thư mục mới
git worktree add -b feature/y ../ImageProcessing-y     # Tạo nhánh mới + thư mục mới
git worktree add --detach ../review <commit>    # Thư mục tạm để xem một commit / PR
git worktree list                               # Liệt kê các worktree
git worktree remove ../ImageProcessing-hotfix   # Xoá worktree (thư mục phải sạch)
git worktree remove --force <path>              # ⚠ Xoá kể cả khi còn thay đổi chưa commit
git worktree move <path-cũ> <path-mới>          # Di chuyển thư mục worktree
git worktree prune                              # Dọn thông tin các worktree đã bị xoá thư mục bằng tay
git worktree lock <path>                        # Khoá để không bị prune (vd. nằm trên ổ USB)
git worktree repair                             # Sửa liên kết sau khi di chuyển repo / worktree bằng tay
```

Một nhánh chỉ được checkout ở **một** worktree tại một thời điểm. Các worktree dùng chung lịch sử,
stash, cấu hình của repo chính.

### 15.2 Submodule: nhúng repo khác vào repo này

Submodule lưu **một commit cụ thể** của repo con. Repo cha chỉ ghi "đang dùng commit nào".

```bash
git submodule add <url> libs/<tên>              # Thêm submodule
git submodule update --init --recursive         # Lấy code submodule sau khi clone
git submodule update --remote                   # Cập nhật submodule lên commit mới nhất của nhánh nó theo dõi
git submodule status                            # Trạng thái các submodule
git submodule summary                           # Tóm tắt thay đổi của submodule
git submodule foreach git pull                  # Chạy một lệnh trong mọi submodule
git submodule sync                              # Cập nhật URL sau khi .gitmodules đổi URL
git config --global submodule.recurse true      # Pull / checkout tự cập nhật submodule
git diff --submodule=log                        # Diff hiện log commit của submodule thay vì chỉ hash
# Gỡ submodule:
git submodule deinit -f libs/<tên>
git rm -f libs/<tên>
rm -rf .git/modules/libs/<tên>
```

Thay thế đơn giản hơn: **git subtree** (chép code repo con vào hẳn repo cha, không cần lệnh đặc biệt khi clone):

```bash
git subtree add --prefix libs/<tên> <url> main --squash    # Nhúng
git subtree pull --prefix libs/<tên> <url> main --squash   # Cập nhật
```

### 15.3 Sparse-checkout & partial clone: chỉ lấy một phần repo (repo lớn / monorepo)

```bash
git clone --filter=blob:none --sparse <url>     # Clone nhẹ, ban đầu chỉ có file ở gốc
git sparse-checkout set Source/ImageCoreService docs   # Chỉ checkout các thư mục này
git sparse-checkout add Installer               # Thêm thư mục
git sparse-checkout list                        # Xem các thư mục đang lấy
git sparse-checkout disable                     # Lấy lại toàn bộ repo
git backfill                                    # (Git ≥ 2.49) Partial clone: tải trước các file còn thiếu theo lô
```

### 15.4 Nhiều repo / VS Code workspace

- Mở thư mục cha có nhiều repo con: VS Code (tab Source Control) hiện từng repo riêng. Khi push /
  commit, nhớ chọn **đúng repo** trong danh sách.
- Workspace nhiều gốc: *File → Add Folder to Workspace...* rồi *Save Workspace As...* để tạo file
  `.code-workspace`. Mở lại file này là có đủ các repo.
- Chạy một lệnh cho mọi repo con (Git Bash):

```bash
for d in */.git; do (cd "${d%/.git}" && echo "== ${d%/.git}" && git status -sb); done   # status mọi repo
for d in */.git; do (cd "${d%/.git}" && git pull --ff-only); done                      # pull mọi repo
for d in */.git; do (cd "${d%/.git}" && echo "== ${d%/.git}" && git log @{u}.. --oneline); done  # commit chưa push
```

Push một lúc lên nhiều remote (vd. GitHub + server công ty):

```bash
git remote set-url --add --push origin <url-1>  # Thêm URL push thứ nhất cho origin
git remote set-url --add --push origin <url-2>  # ... thứ hai: "git push" đẩy lên cả hai
# (Git ≥ 2.55) nhóm remote:  git config remotes.all "origin backup"  rồi  git push all
```

---

## 16. .gitignore, .gitattributes, xuống dòng CRLF/LF

### 16.1 .gitignore

```gitignore
# Mỗi dòng một mẫu. Chú thích phải nằm trên dòng riêng (# ở cuối dòng KHÔNG phải chú thích).

# thư mục bin ở mọi cấp
bin/
# chỉ thư mục artifacts ở gốc repo
/artifacts/
# mọi file đuôi .user
*.user
# ngoại lệ: vẫn theo dõi file này
!keep.user
# file .log trong mọi thư mục logs
**/logs/*.log
```

```bash
git check-ignore -v <file>                      # Vì sao file này bị ignore (dòng nào, file nào)
git rm -r --cached . && git add .               # Áp dụng lại .gitignore cho file đã lỡ theo dõi
git status --ignored                            # Liệt kê cả file bị ignore
git config --global core.excludesFile ~/.gitignore_global   # Ignore chung mọi repo (vd. .DS_Store, Thumbs.db)
# .git/info/exclude = ignore chỉ trên máy mình, không commit
git update-index --assume-unchanged <file>      # Tạm lờ thay đổi của một file đã theo dõi (chỉ máy mình)
git update-index --no-assume-unchanged <file>   # Bỏ lờ
git update-index --skip-worktree <file>         # Giữ bản sửa riêng của file cấu hình, không bị pull ghi đè
git ls-files -v | grep "^[hS]"                  # Liệt kê các file đang bị assume-unchanged (h) / skip-worktree (S)
```

Mẫu `.gitignore` cho .NET / Node / Python...: `gh repo create --gitignore VisualStudio` hoặc
github.com/github/gitignore. .NET có sẵn: `dotnet new gitignore`.

### 16.2 Xuống dòng CRLF / LF và cảnh báo `LF will be replaced by CRLF`

Windows dùng CRLF, Linux / macOS dùng LF. Cảnh báo
`warning: in the working copy of 'x.cs', LF will be replaced by CRLF the next time Git touches it`
**chỉ là thông báo**, không phải lỗi: file đang có LF, lần checkout sau Git sẽ đổi sang CRLF vì bạn đặt
`core.autocrlf=true`. Cách làm sạch và thống nhất cho cả nhóm là dùng `.gitattributes` (commit vào repo):

```gitattributes
# Git tự nhận file văn bản, lưu LF trong repo
* text=auto
# diff hiểu cú pháp C# (hiện tên hàm ở tiêu đề hunk)
*.cs    text diff=csharp
# file Visual Studio và PowerShell luôn CRLF
*.sln   text eol=crlf
*.ps1   text eol=crlf
# script Linux luôn LF (CRLF làm script chạy lỗi)
*.sh    text eol=lf
# file nhị phân: không diff, không đổi xuống dòng
*.png   binary
*.dll   binary
*.pdf   binary
```

```bash
git add --renormalize .                         # Sau khi thêm .gitattributes: chuẩn hoá lại xuống dòng mọi file
git commit -m "chore: chuẩn hoá xuống dòng"
git ls-files --eol                              # Xem mỗi file đang LF hay CRLF (trong index / working tree)
git check-attr -a <file>                        # Xem các thuộc tính áp dụng cho một file
```

---

## 17. File lớn (LFS), xoá dữ liệu nhạy cảm, bảo trì repo

### 17.1 Git LFS cho file nhị phân lớn

GitHub từ chối file > 100 MB và cảnh báo file > 50 MB. Git LFS lưu file lớn ở server riêng, repo
chỉ chứa con trỏ nhỏ.

```bash
git lfs install                                 # Bật LFS (một lần cho mỗi máy)
git lfs track "*.traineddata"                   # Theo dõi một loại file bằng LFS (ghi vào .gitattributes)
git add .gitattributes                          # Nhớ commit .gitattributes
git lfs ls-files                                # Các file đang dùng LFS
git lfs pull                                    # Tải nội dung file LFS (sau clone / khi thiếu)
git lfs migrate info                            # Loại file nào chiếm nhiều dung lượng trong lịch sử
git lfs migrate import --include="*.dll"        # ⚠ Chuyển file cũ trong lịch sử sang LFS (viết lại lịch sử)
```

### 17.2 Lỡ commit mật khẩu / key / file quá lớn

1. **Nếu là bí mật: thu hồi và đổi ngay** (token, mật khẩu, key), vì dữ liệu đã lên remote coi như bị
   lộ, kể cả khi xoá khỏi lịch sử.
2. Chưa push: `git reset --soft HEAD~1`, bỏ file ra, commit lại.
3. Đã push: xoá khỏi mọi commit bằng `git filter-repo` (cài: `pip install git-filter-repo`), rồi force push.
   ⚠ Viết lại toàn bộ lịch sử, mọi người phải clone lại.

```bash
git filter-repo --path <file> --invert-paths    # ⚠ Xoá hẳn một file khỏi mọi commit
git filter-repo --replace-text thay-the.txt     # ⚠ Thay chuỗi bí mật (mỗi dòng: chuỗi==>***REMOVED***)
git filter-repo --strip-blobs-bigger-than 50M   # ⚠ Bỏ mọi file lớn hơn 50 MB khỏi lịch sử
git push --force --all && git push --force --tags
```

Phòng ngừa: bật *Secret scanning / Push protection* trong GitHub (Settings → Code security), dùng
hook `pre-commit` quét bí mật (mục 19).

### 17.3 Bảo trì repo

```bash
git maintenance start                           # Đăng ký bảo trì nền định kỳ (fetch nền, gc, commit-graph)
git maintenance run --auto                      # Chạy bảo trì ngay nếu cần
git maintenance stop                            # Tắt bảo trì nền
git gc                                          # Nén, dọn object thừa
git gc --aggressive --prune=now                 # Nén kỹ (chậm), sau khi viết lại lịch sử
git count-objects -vH                           # Dung lượng repo
git fsck                                        # Kiểm tra repo có hỏng không
git reflog expire --expire=now --all            # ⚠ Xoá reflog (sau filter-repo, để gc dọn được object cũ)
git config core.fsmonitor true                  # Theo dõi thay đổi file bằng daemon: git status nhanh hơn trên repo lớn
git config core.untrackedCache true             # Cache file chưa theo dõi: git status nhanh hơn
```

---

## 18. Patch & bundle: chia sẻ code không qua remote

Khi không push được (máy khách, mạng nội bộ, gửi qua email / USB).

```bash
git diff > thay-doi.patch                       # Thay đổi chưa commit → file patch
git diff --staged > thay-doi.patch              # Chỉ phần đã stage
git apply --check thay-doi.patch                # Kiểm tra patch áp được không
git apply thay-doi.patch                        # Áp patch vào working tree (chưa commit)
git apply -3 thay-doi.patch                     # Áp patch, nếu lệch thì tạo conflict để giải thay vì thất bại

git format-patch -3 -o patches/                 # 3 commit gần nhất → mỗi commit một file .patch (giữ tác giả, message)
git format-patch origin/main..HEAD -o patches/  # Mọi commit chưa có ở main
git am patches/*.patch                          # Áp các patch thành commit (giữ tác giả, message)
git am --abort                                  # Huỷ khi áp lỗi

git bundle create repo.bundle --all             # Đóng gói cả repo (mọi nhánh, tag) thành 1 file
git bundle create update.bundle main ^v1.0.0    # Chỉ gói các commit sau v1.0.0
git bundle verify repo.bundle                   # Kiểm tra bundle
git clone repo.bundle <thư-mục>                 # Clone từ file bundle
git fetch update.bundle main:main               # Lấy commit mới từ bundle
```

---

## 19. Hooks: tự động kiểm tra trước khi commit / push

Hook là script chạy tự động ở một thời điểm. Nằm trong `.git/hooks/` (không được commit), hoặc
trong một thư mục của repo nếu đặt `core.hooksPath` (commit được, cả nhóm dùng chung).

| Hook | Chạy khi | Dùng để |
|---|---|---|
| `pre-commit` | Trước khi tạo commit | Format code, chạy lint, chặn file lớn / bí mật |
| `commit-msg` | Sau khi viết message | Bắt buộc theo Conventional Commits |
| `pre-push` | Trước khi push | Chạy build / test nhanh |
| `post-checkout`, `post-merge` | Sau checkout / merge | Tự `dotnet restore`, `npm install` |

```bash
git config core.hooksPath .githooks             # Dùng hook trong thư mục .githooks của repo (commit được)
git commit --no-verify                          # Bỏ qua pre-commit / commit-msg (khẩn cấp)
git push --no-verify                            # Bỏ qua pre-push
git hook run pre-commit                         # Chạy thử một hook
git hook list pre-commit                        # (Git ≥ 2.54) Liệt kê hook đã cấu hình và nguồn gốc
```

Ví dụ `.githooks/pre-push` (Git Bash vẫn chạy được trên Windows), chặn push nếu build lỗi:

```bash
#!/bin/sh
dotnet build Source/ImageProcessing.sln -v q || { echo "Build lỗi, không push."; exit 1; }
```

Công cụ quản lý hook: `pre-commit` (Python, pre-commit.com), `husky` (Node), `lefthook` (đa nền tảng).

---

## 20. Ký commit (chữ ký SSH / GPG)

Commit có chữ ký hiện nhãn **Verified** trên GitHub, chứng minh commit đúng là của bạn (email trong
commit có thể bị giả mạo). Cách đơn giản nhất là ký bằng khoá SSH:

```bash
git config --global gpg.format ssh                        # Ký bằng SSH thay vì GPG
git config --global user.signingkey ~/.ssh/id_ed25519.pub # Khoá dùng để ký
git config --global commit.gpgsign true                   # Tự ký mọi commit
git config --global tag.gpgsign true                      # Tự ký mọi tag có chú thích
# Thêm khoá .pub vào GitHub → Settings → SSH and GPG keys → New SSH key → Key type: Signing Key
git commit -S -m "..."                                    # Ký một commit (khi chưa bật tự ký)
git log --show-signature -1                               # Xem chữ ký (cần gpg.ssh.allowedSignersFile để xác minh tại máy)
git verify-commit <commit>                                # Kiểm tra chữ ký commit
git verify-tag v1.0.0                                     # Kiểm tra chữ ký tag
```

---

## 21. GitHub CLI (`gh`)

Cài bằng `winget install GitHub.cli`, rồi đăng nhập bằng `gh auth login`.

```bash
gh auth status                                  # Tài khoản gh đang dùng
gh auth switch                                  # Chuyển giữa các tài khoản đã đăng nhập
gh auth setup-git                               # Dùng gh làm credential helper cho git
gh repo clone QDev-15/ImageProcessing           # Clone
gh repo view --web                              # Mở repo trên trình duyệt
gh browse <file>:<dòng>                         # Mở một file / dòng trên GitHub

gh pr create --fill                             # Tạo Pull Request từ nhánh hiện tại (lấy tiêu đề từ commit)
gh pr create --base master --title "..." --body "..."   # Tạo PR với nhánh đích cụ thể
gh pr create --draft                            # PR nháp (chưa sẵn sàng review)
gh pr list                                      # Danh sách PR
gh pr status                                    # PR của bạn và PR đang chờ bạn review
gh pr checkout <số>                             # Checkout code của một PR về máy
gh pr view <số> --web                           # Xem PR trên web
gh pr diff <số>                                 # Xem diff của PR
gh pr review <số> --approve                     # Duyệt PR (hoặc --request-changes -b "...", --comment)
gh pr merge <số> --squash --delete-branch       # Merge (squash) và xoá nhánh
gh pr merge <số> --auto --squash                # Tự merge khi CI xanh và đủ duyệt
gh pr checks                                    # Trạng thái CI của PR

gh issue create --title "..." --body "..."      # Tạo issue
gh issue list --assignee @me                    # Issue giao cho bạn
gh issue develop <số> --checkout                # Tạo nhánh gắn với issue và chuyển sang
gh release create v1.0.0 artifacts/installer/*.msi --generate-notes   # Tạo release kèm file cài đặt + changelog tự động
gh release download v1.0.0                      # Tải file của một release
gh run list                                     # Danh sách lượt chạy GitHub Actions
gh run watch                                    # Theo dõi lượt chạy CI đang diễn ra
gh run rerun <id> --failed                      # Chạy lại các job lỗi
gh workflow run <tên.yml>                       # Kích hoạt workflow thủ công
gh secret set <TÊN>                             # Đặt secret cho Actions
```

Mẫu mô tả PR: tạo `.github/pull_request_template.md` trong repo. Người review tự động theo thư mục:
file `.github/CODEOWNERS`.

---

## 22. Git trong VS Code

| Việc | Cách làm |
|---|---|
| Mở Source Control | `Ctrl+Shift+G` |
| Stage file / một đoạn | Nút `+` cạnh file; mở diff, chọn dòng → chuột phải *Stage Selected Ranges* |
| Commit | Gõ message, `Ctrl+Enter` |
| Push / pull | Nút *Sync Changes*, hoặc `…` → *Push* / *Pull* |
| Chuyển / tạo nhánh | Bấm tên nhánh ở góc trái thanh trạng thái |
| Mọi lệnh Git | `Ctrl+Shift+P` → gõ `Git:` (vd. *Git: Stash*, *Git: Undo Last Commit*) |
| Lịch sử file | Explorer → *Timeline* (kèm *Local History* không cần commit) |
| Blame từng dòng | Bật `git.blame.editorDecoration.enabled` (VS Code ≥ 1.93) hoặc cài GitLens |
| Giải conflict | Nút *Accept Current / Incoming / Both* hoặc *Resolve in Merge Editor* |
| Nhiều repo trong một cửa sổ | Mục *Repositories* trong Source Control; chọn đúng repo trước khi commit / push |

Tiện ích nên có: **GitLens** (blame, lịch sử, so sánh nhánh), **Git Graph** (xem cây nhánh),
**GitHub Pull Requests** (review PR ngay trong VS Code).

---

## 23. Alias & mẹo tăng tốc

```bash
git config --global alias.st "status -sb"
git config --global alias.co switch
git config --global alias.br "branch -vv"
git config --global alias.lg "log --oneline --graph --decorate --all"
git config --global alias.last "log -1 --stat"
git config --global alias.unstage "restore --staged"
git config --global alias.undo "reset --soft HEAD~1"
git config --global alias.amend "commit --amend --no-edit"
git config --global alias.pushf "push --force-with-lease"
git config --global alias.unpushed "log @{u}.. --oneline"
git config --global alias.aliases "config --get-regexp ^alias"
git config --global alias.cleanup '!git branch --merged | grep -vE "^\*|main|master" | xargs -r git branch -d'
# Dùng: git st, git lg, git undo ... Alias bắt đầu bằng ! chạy như lệnh shell.
```

- `git help <lệnh>` hoặc `git <lệnh> -h`: xem hướng dẫn chính thức của một lệnh.
- `-` trong `git switch -` = nhánh trước đó (giống `cd -`).
- Cần mở commit / file trên web: `gh browse`.
- Tab để tự hoàn thành tên nhánh / lệnh trong Git Bash.
- `git -C <thư-mục> status`: chạy lệnh cho repo ở thư mục khác mà không cần `cd`.
- `git --no-pager log -5`: in thẳng ra, không mở trình xem trang.
- `GIT_TRACE=1 git push`: in chi tiết Git đang làm gì (gỡ lỗi); `GIT_CURL_VERBOSE=1` cho lỗi mạng HTTPS.

---

## 24. Chiến lược nhánh & quy tắc làm việc nhóm

### 24.1 Chọn mô hình nhánh

| Mô hình | Nhánh | Hợp với |
|---|---|---|
| **GitHub Flow** (khuyên dùng cho nhóm nhỏ) | `main` luôn chạy được + nhánh `feature/*` ngắn, gộp qua PR | Web / app phát hành liên tục |
| **Trunk-based** | Mọi người commit nhỏ, thường xuyên vào `main`; tính năng dở ẩn bằng cờ (feature flag) | Nhóm có CI tốt |
| **Git Flow** | `main` (bản phát hành) + `develop` + `feature/*`, `release/*`, `hotfix/*` | Phần mềm đóng gói có nhiều bản song song (vd. app desktop bán theo phiên bản) |

### 24.2 Bảo vệ nhánh chính (GitHub → Settings → Branches / Rulesets)

- Không cho push thẳng vào `main`: bắt buộc qua Pull Request.
- Bắt buộc CI xanh (build + test) và ít nhất 1 người duyệt trước khi merge.
- Chặn force push và xoá nhánh `main`.
- Chọn một kiểu merge thống nhất (khuyên *Squash and merge* cho nhánh feature).
- Tự xoá nhánh sau khi PR được merge (*Automatically delete head branches*).

### 24.3 Quy tắc nhỏ nên theo

- Pull / rebase trước khi bắt đầu việc và trước khi tạo PR.
- Nhánh sống ngắn (vài ngày); PR nhỏ (< 400 dòng) để dễ review.
- Không commit: `bin/`, `obj/`, file cấu hình có mật khẩu, file cá nhân của IDE.
- Không force push lên nhánh người khác đang dùng; nếu buộc phải làm, dùng `--force-with-lease` và báo trước.

---

## 25. Quy trình mẫu (workflow) từng bước

### Làm một tính năng mới

```bash
git switch master && git pull                   # 1. Cập nhật nhánh chính
git switch -c feature/ten-tinh-nang             # 2. Tạo nhánh
# ... sửa code ...
git add -p && git commit -m "feat: ..."         # 3. Commit theo từng bước nhỏ
git fetch && git rebase origin/master           # 4. Cập nhật theo master (giải conflict nếu có)
git push -u origin feature/ten-tinh-nang        # 5. Push
gh pr create --fill                             # 6. Tạo Pull Request
# 7. Sau khi PR được merge:
git switch master && git pull && git branch -d feature/ten-tinh-nang
```

### Sửa theo góp ý review trên PR

```bash
# sửa code...
git commit -m "fix: theo review"                # Commit thêm (đơn giản nhất, PR tự cập nhật)
git push
# hoặc giữ lịch sử gọn:
git commit --fixup <commit-cần-sửa> && git rebase -i --autosquash origin/master && git push --force-with-lease
```

### Sửa gấp (hotfix) khi đang làm dở việc khác

```bash
git worktree add -b hotfix/loi-x ../hotfix origin/master   # Thư mục riêng, không đụng việc đang làm
cd ../hotfix
# ... sửa, commit, push, tạo PR ...
cd - && git worktree remove ../hotfix
```

### Mang bản sửa lỗi sang nhánh release cũ

```bash
git switch release/1.0
git cherry-pick -x <commit-sửa-lỗi>             # -x ghi nguồn gốc vào message
git push
git tag -a v1.0.1 -m "Bản vá 1.0.1" && git push origin v1.0.1
```

### Lỡ commit nhầm nhánh (chưa push)

```bash
git branch feature/dung-nhanh                   # Giữ commit ở một nhánh mới
git reset --hard HEAD~1                         # ⚠ Gỡ commit khỏi nhánh hiện tại
git switch feature/dung-nhanh
```

### Lỡ commit vào main nhưng lẽ ra phải tạo PR (đã push)

```bash
git revert <commit>                             # Đảo ngược trên main (an toàn, không viết lại lịch sử)
git push
git switch -c feature/lam-lai <commit>          # Nhánh mới chứa commit đó để tạo PR đàng hoàng
```

### Gộp nhiều commit lặt vặt trước khi tạo PR

```bash
git rebase -i origin/master                     # Đổi "pick" thành "squash" / "fixup" cho các commit cần gộp
git push --force-with-lease                     # Nhánh đã push trước đó thì cần force (an toàn)
```

### Nhánh bị "diverged" (local và server cùng có commit mới)

```bash
git fetch
git log --oneline --graph HEAD origin/<branch>  # Xem hai bên khác nhau thế nào
git rebase origin/<branch>                      # Giữ commit của bạn, đặt lên sau commit trên server
# hoặc bỏ commit local, lấy đúng bản server:
git reset --hard origin/<branch>                # ⚠
```

### Bắt đầu lại từ đầu (bỏ hết thay đổi local)

```bash
git fetch origin
git reset --hard origin/<branch>                # ⚠ Mất mọi commit / thay đổi local chưa push
git clean -fd                                   # ⚠ Xoá file mới chưa theo dõi
```

---

## 26. Lỗi thường gặp & cách sửa

| Thông báo lỗi | Nguyên nhân | Cách sửa |
|---|---|---|
| `! [rejected] ... (fetch first)` / `non-fast-forward` | Server có commit mới mà bạn chưa có | `git pull --rebase` rồi `git push` |
| `Your branch and 'origin/x' have diverged` | Cả local và server cùng có commit mới | Xem mục 25 "diverged" |
| `fatal: The current branch x has no upstream branch` | Nhánh mới chưa gắn remote | `git push -u origin x` (hoặc bật `push.autoSetupRemote`) |
| `error: Your local changes ... would be overwritten by checkout/merge` | Có thay đổi chưa commit đụng file sắp bị thay | `git stash -u`, làm tiếp, rồi `git stash pop`; hoặc commit trước |
| `CONFLICT (content): Merge conflict in <file>` | Hai bên cùng sửa một chỗ | Mục 10 |
| `You are in 'detached HEAD' state` | Đang đứng ở commit / tag, không ở nhánh | `git switch -c <nhánh-mới>` để giữ việc đã làm, hoặc `git switch <nhánh>` |
| `fatal: refusing to merge unrelated histories` | Hai repo không chung gốc (vd. repo GitHub tạo kèm README) | `git pull origin main --allow-unrelated-histories` |
| `error: pathspec 'x' did not match any file(s) known to git` | Sai tên nhánh / file, hoặc nhánh chưa fetch | `git fetch`, kiểm tra `git branch -a` |
| `fatal: not a git repository` | Đang đứng ngoài repo | `cd` vào thư mục repo |
| `Author identity unknown` / `Please tell me who you are` | Chưa đặt tên / email | Mục 2.1 |
| `remote: Permission to X denied to Y` / `403` | Dùng nhầm tài khoản GitHub hoặc không có quyền | Mục 3 (GCM, `credential.username`) |
| `remote: Support for password authentication was removed` | Push bằng mật khẩu | Dùng GCM / token / SSH (mục 3) |
| `Permission denied (publickey)` | SSH key chưa thêm vào GitHub / sai key | `ssh -T git@github.com`, kiểm tra `~/.ssh/config` |
| `Unable to create '.../.git/index.lock': File exists` | Một lệnh Git khác đang chạy / bị tắt ngang | Đóng các cửa sổ Git / IDE; nếu chắc không còn lệnh nào chạy thì xoá `.git/index.lock` |
| `Filename too long` | Đường dẫn > 260 ký tự (Windows) | `git config --global core.longpaths true` |
| `LF will be replaced by CRLF` | Chỉ là cảnh báo xuống dòng | Mục 16.2 (`.gitattributes`) |
| `detected dubious ownership in repository` | Thư mục repo thuộc user khác (ổ ngoài, copy từ máy khác) | `git config --global --add safe.directory D:/duong/dan/repo` |
| `SSL certificate problem: unable to get local issuer certificate` | Mạng công ty chèn chứng chỉ riêng | `git config --global http.sslBackend schannel` (dùng kho chứng chỉ Windows) |
| `File x is 123 MB; this exceeds GitHub's file size limit of 100 MB` | File quá lớn trong một commit | Chưa push: `git reset --soft HEAD~1`, bỏ file; đã có trong lịch sử: mục 17 (LFS / filter-repo) |
| `RPC failed; HTTP 500` / `early EOF` / `the remote end hung up` | Push / clone quá lớn hoặc mạng chập chờn | Clone `--depth 1` rồi `--unshallow`; push từng phần; thử SSH |
| `error: failed to push some refs ... pre-receive hook declined` | Nhánh được bảo vệ / vi phạm quy tắc repo | Tạo PR thay vì push thẳng; đọc thông báo của server |
| `Updates were rejected because the tag already exists` | Tag trùng tên trên server | Đặt tag khác, hoặc xoá tag cũ trên server (mục 14) nếu chắc chắn |
| `warning: adding embedded git repository` | Thư mục con cũng là một repo Git | Dùng `git submodule add` (mục 15.2), hoặc xoá `.git` của thư mục con |
| `git status` báo mọi file đều sửa dù không đụng tới | Đổi xuống dòng / quyền file | `git config core.autocrlf true`, `git config core.fileMode false`; xem `git diff` |

---

## 27. Tính năng mới Git 2.47 → 2.55

Máy đang dùng **Git 2.46**. Cập nhật: `git update-git-for-windows` hoặc `winget upgrade Git.Git`.

| Phiên bản | Tính năng đáng chú ý |
|---|---|
| 2.49 | `git backfill`: tải trước theo lô các file còn thiếu trong partial clone. |
| 2.50 | `git reflog drop` (xoá reflog một nhánh); `git maintenance` thêm việc `worktree-prune`, `rerere-gc`, `reflog-expire`. |
| 2.51 | `git stash export` / `git stash import` (mang stash sang máy khác); `git switch` và `git restore` hết giai đoạn thử nghiệm. |
| 2.52 | `git last-modified`: commit gần nhất sửa từng file, nhanh hơn nhiều so với lặp `git log`; `git maintenance` có chiến lược `geometric`. |
| 2.54 | `git history reword` / `git history split` (thử nghiệm): sửa lịch sử không đụng working tree; `git hook list`; khai báo hook bằng config (`hook.<tên>.command`); `git add -p --no-auto-advance`; `git blame --diff-algorithm`; `git rebase --trailer`. |
| 2.55 | `git history fixup <commit>`: đưa phần đang stage vào commit cũ; nhóm remote `git push <nhóm>` (`remotes.<nhóm>`); `git hook run -j` chạy hook song song; `git log --graph-lane-limit=<n>`. |

Nguồn: GitHub Blog "Highlights from Git 2.50 / 2.51 / 2.52 / 2.54 / 2.55" (github.blog/open-source/git).

---

## 28. Thuật ngữ

| Thuật ngữ | Nghĩa |
|---|---|
| Repository (repo) | Kho chứa code + toàn bộ lịch sử (thư mục `.git`) |
| Working tree | Các file bạn đang thấy và sửa |
| Index / staging area | Vùng chuẩn bị cho commit tới (`git add`) |
| Commit | Ảnh chụp project tại một thời điểm, có hash, tác giả, message |
| Hash / SHA | Mã định danh commit, vd. `a1b2c3d` |
| Branch | Con trỏ tới một commit, tiến lên khi commit |
| HEAD | Vị trí đang đứng (thường là một nhánh) |
| Detached HEAD | Đứng ở một commit, không thuộc nhánh nào |
| Remote / origin | Repo trên server; `origin` là tên mặc định |
| Upstream | Nhánh remote mà nhánh local theo dõi; cũng là tên remote trỏ về repo gốc khi fork |
| Remote-tracking branch | `origin/main`: bản chụp nhánh server tại lần fetch cuối |
| Fetch / Pull / Push | Tải về (không gộp) / tải về + gộp / đẩy lên |
| Merge / Rebase | Gộp bằng merge commit / chép commit lên base mới |
| Fast-forward | Gộp chỉ bằng cách dời con trỏ, không cần merge commit |
| Conflict | Hai bên sửa cùng chỗ, Git cần bạn chọn |
| Stash | Ngăn cất tạm thay đổi chưa commit |
| Tag | Nhãn cố định cho một commit (thường là số phiên bản) |
| Reflog | Nhật ký các vị trí HEAD / nhánh từng đi qua (chỉ trên máy bạn) |
| Cherry-pick | Chép một commit cụ thể sang nhánh khác |
| Squash | Gộp nhiều commit thành một |
| Pull Request (PR) | Đề nghị gộp nhánh trên GitHub, kèm review và CI |
| Fork | Bản sao repo người khác trên tài khoản của bạn |
| Worktree | Thêm một thư mục làm việc cho cùng một repo |
| Submodule | Repo con được nhúng ở một commit cố định |
| Shallow / partial clone | Clone thiếu lịch sử / thiếu nội dung file để nhẹ hơn |
| Hook | Script chạy tự động khi commit / push... |
| LFS | Cách lưu file lớn ngoài repo chính |

---

## 29. Ghi chú riêng

<!-- Thêm lệnh / mẹo của bạn ở đây -->

- Repo `ImageProcessing` đã gắn tài khoản `QDev-15`:
  `git config --local credential.https://github.com.username QDev-15`.
