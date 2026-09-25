# Sổ tay Git (tiếng Việt)

Tra cứu nhanh các câu lệnh Git, nhóm theo **công việc**. Mỗi lệnh có chú thích ngay bên cạnh.
Tìm nhanh bằng `Ctrl+F` theo từ khoá (ví dụ: `hoàn tác`, `stash`, `tag`, `tài khoản`, `worktree`).

- Viết cho Git 2.4x trên Windows (Git for Windows + Git Credential Manager). Máy hiện tại: Git 2.46.
- Quy ước trong file:
  - `<...>`: giá trị bạn thay vào, ví dụ `<branch>` → `feature/login`.
  - `[...]`: phần tuỳ chọn, có thể bỏ.
  - ⚠: lệnh có thể **làm mất dữ liệu** hoặc **viết lại lịch sử**. Đọc kỹ chú thích trước khi chạy.
- Tự sửa file này thoải mái. Mục **19. Ghi chú riêng** ở cuối để bạn thêm lệnh của mình.

## Mục lục

1. [Cài đặt & cấu hình lần đầu](#1-cài-đặt--cấu-hình-lần-đầu)
2. [Nhiều tài khoản GitHub / đăng nhập (Credential Manager, SSH)](#2-nhiều-tài-khoản-github--đăng-nhập)
3. [Tạo / lấy repo về máy](#3-tạo--lấy-repo-về-máy)
4. [Xem trạng thái và thay đổi](#4-xem-trạng-thái-và-thay-đổi)
5. [Stage & commit](#5-stage--commit)
6. [Branch (nhánh)](#6-branch-nhánh)
7. [Làm việc với remote: fetch / pull / push](#7-làm-việc-với-remote-fetch--pull--push)
8. [Gộp code: merge / rebase / cherry-pick](#8-gộp-code-merge--rebase--cherry-pick)
9. [Xử lý conflict](#9-xử-lý-conflict)
10. [Hoàn tác & sửa sai](#10-hoàn-tác--sửa-sai)
11. [Stash (cất tạm thay đổi)](#11-stash-cất-tạm-thay-đổi)
12. [Xem lịch sử & tìm kiếm](#12-xem-lịch-sử--tìm-kiếm)
13. [Tag & phát hành (release)](#13-tag--phát-hành-release)
14. [Quản lý workspace: worktree, submodule, sparse-checkout, nhiều repo](#14-quản-lý-workspace)
15. [.gitignore, file lớn (LFS), dọn dẹp repo](#15-gitignore-file-lớn-lfs-dọn-dẹp-repo)
16. [GitHub CLI (`gh`): Pull Request, issue](#16-github-cli-gh)
17. [Alias & mẹo tăng tốc](#17-alias--mẹo-tăng-tốc)
18. [Quy trình mẫu (workflow)](#18-quy-trình-mẫu-workflow)
19. [Ghi chú riêng](#19-ghi-chú-riêng)

---

## 1. Cài đặt & cấu hình lần đầu

Cấu hình có 3 cấp. Cấp càng hẹp càng được ưu tiên: `--local` > `--global` > `--system`.

| Cấp | Phạm vi | File |
|---|---|---|
| `--system` | Mọi user trên máy | `C:\Program Files\Git\etc\gitconfig` |
| `--global` | User hiện tại | `C:\Users\<bạn>\.gitconfig` |
| `--local` (mặc định) | Chỉ repo hiện tại | `<repo>\.git\config` |

```bash
git --version                                   # Xem phiên bản Git
git update-git-for-windows                      # Cập nhật Git for Windows lên bản mới nhất

git config --global user.name "Nguyen Huu Quynh"           # Tên hiển thị trong commit
git config --global user.email "ban@example.com"           # Email trong commit (nên trùng email tài khoản GitHub)
git config --local  user.email "quynh.nguyenhuu@imipgroup.com"  # Email riêng cho repo hiện tại (ghi đè global)

git config --global init.defaultBranch main     # Repo mới tạo dùng nhánh "main" thay vì "master"
git config --global core.editor "code --wait"   # Dùng VS Code để soạn commit message / rebase
git config --global core.autocrlf true          # Windows: checkout ra CRLF, commit vào LF (tránh diff vì xuống dòng)
git config --global core.longpaths true         # Windows: cho phép đường dẫn dài hơn 260 ký tự
git config --global core.quotepath false        # Hiện tên file tiếng Việt đúng dấu, không bị \303\241...
git config --global pull.rebase true            # "git pull" sẽ rebase thay vì tạo merge commit
git config --global fetch.prune true            # Tự xoá các nhánh remote đã bị xoá khi fetch
git config --global push.autoSetupRemote true   # Lần push đầu của nhánh mới tự tạo upstream (khỏi cần -u)
git config --global rerere.enabled true         # Ghi nhớ cách đã giải conflict, lần sau tự áp dụng lại
git config --global merge.conflictstyle zdiff3  # Conflict hiện thêm đoạn gốc (base), dễ giải hơn
git config --global diff.algorithm histogram    # Diff dễ đọc hơn thuật toán mặc định

git config --list --show-origin                 # Liệt kê mọi cấu hình kèm file chứa nó
git config --get user.email                     # Xem một giá trị cụ thể
git config --global --unset core.editor         # Xoá một cấu hình
git config --global --edit                      # Mở file cấu hình global để sửa tay
```

---

## 2. Nhiều tài khoản GitHub / đăng nhập

Máy này đang có 2 tài khoản GitHub trong Git Credential Manager (GCM): `QDev-15` và `quynhvp90`.
Khi một repo không được chỉ định tài khoản, **mỗi lần push GCM sẽ hỏi chọn tài khoản**.

### 2.1 Git Credential Manager (HTTPS, mặc định trên Windows)

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
- Lỗi `403` / `Permission denied` khi push: kiểm tra tài khoản đang dùng có quyền ghi vào repo không.

### 2.2 Tự động chọn tài khoản / email theo thư mục (`includeIf`)

Mọi repo nằm trong một thư mục sẽ tự dùng email và tài khoản riêng, không phải cấu hình từng repo.

Trong `C:\Users\<bạn>\.gitconfig`:

```ini
[includeIf "gitdir/i:D:/Working/project/"]
    path = ~/.gitconfig-work
[includeIf "gitdir/i:D:/Personal/"]
    path = ~/.gitconfig-personal
```

File `~/.gitconfig-work`:

```ini
[user]
    email = quynh.nguyenhuu@imipgroup.com
[credential "https://github.com"]
    username = quynhvp90
```

(`gitdir/i` = không phân biệt hoa thường, nên dùng trên Windows. Đường dẫn dùng dấu `/`.)

### 2.3 SSH (thay cho HTTPS)

```bash
ssh-keygen -t ed25519 -C "ban@example.com" -f ~/.ssh/id_qdev15   # Tạo cặp khoá SSH
cat ~/.ssh/id_qdev15.pub                        # Copy khoá công khai → GitHub → Settings → SSH keys
ssh -T git@github.com                           # Kiểm tra kết nối ("Hi <user>!" là OK)
git remote set-url origin git@github.com:QDev-15/ImageProcessing.git  # Chuyển remote sang SSH
```

Nhiều tài khoản với SSH: đặt alias host trong `~/.ssh/config`.

```
Host github-qdev
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_qdev15
```

Rồi dùng URL `git@github-qdev:QDev-15/ImageProcessing.git`.

---

## 3. Tạo / lấy repo về máy

```bash
git init                                        # Biến thư mục hiện tại thành repo Git
git init <thư-mục>                              # Tạo thư mục mới và init
git clone <url>                                 # Tải repo về (tạo thư mục trùng tên repo)
git clone <url> <thư-mục>                       # Tải về vào thư mục tuỳ chọn
git clone -b <branch> <url>                     # Clone và checkout sẵn một nhánh
git clone --depth 1 <url>                       # Chỉ lấy commit mới nhất (nhanh, nhẹ; không có lịch sử)
git clone --filter=blob:none <url>              # "Partial clone": lấy lịch sử, file tải khi cần (repo lớn)
git clone --recurse-submodules <url>            # Clone kèm các submodule

git remote add origin <url>                     # Gắn repo local với repo trên GitHub
git push -u origin main                         # Push lần đầu và đặt upstream
```

---

## 4. Xem trạng thái và thay đổi

```bash
git status                                      # Trạng thái: file sửa / đã stage / chưa theo dõi
git status -sb                                  # Dạng ngắn + tên nhánh, ahead/behind
git diff                                        # Thay đổi CHƯA stage (working tree so với index)
git diff --staged                               # Thay đổi ĐÃ stage (sẽ vào commit tới)
git diff HEAD                                   # Toàn bộ thay đổi so với commit cuối
git diff <branch1>..<branch2>                   # So sánh 2 nhánh
git diff <commit> -- <file>                     # Diff của một file so với một commit
git diff --stat                                 # Chỉ tóm tắt số dòng thêm / xoá theo file
git diff --word-diff                            # Diff theo từ (hợp với văn bản, README)
git difftool                                    # Mở diff bằng công cụ đồ hoạ đã cấu hình
```

---

## 5. Stage & commit

```bash
git add <file>                                  # Stage một file
git add .                                       # Stage mọi thay đổi trong thư mục hiện tại trở xuống
git add -A                                      # Stage mọi thay đổi trong toàn repo (kể cả file bị xoá)
git add -p                                      # Chọn từng đoạn (hunk) để stage, dùng khi tách commit
git restore --staged <file>                     # Bỏ stage (file vẫn giữ nguyên thay đổi)

git commit -m "Nội dung"                        # Commit với message ngắn
git commit                                      # Mở editor để viết message dài (dòng 1 = tiêu đề)
git commit -am "Nội dung"                       # Stage mọi file ĐÃ được theo dõi + commit (bỏ qua file mới)
git commit --amend                              # ⚠ Sửa commit cuối (message / thêm file). Chỉ dùng khi CHƯA push
git commit --amend --no-edit                    # ⚠ Thêm file vừa stage vào commit cuối, giữ nguyên message
git commit --amend --author="Tên <email>"       # ⚠ Sửa tác giả commit cuối
git commit --allow-empty -m "Trigger CI"        # Commit rỗng (vd. để kích hoạt CI)
git commit --fixup <commit>                     # Tạo commit "sửa cho" commit cũ, gộp lại sau bằng rebase --autosquash

git rm <file>                                   # Xoá file và stage việc xoá
git rm --cached <file>                          # Ngừng theo dõi file nhưng giữ file trên đĩa (vd. lỡ commit file cấu hình)
git mv <cũ> <mới>                               # Đổi tên / di chuyển file (giữ lịch sử)
```

Mẹo viết commit message: dòng đầu ≤ 72 ký tự, mô tả **cái gì và vì sao**. Có thể dùng quy ước
Conventional Commits: `feat:`, `fix:`, `docs:`, `refactor:`, `test:`, `chore:`.

---

## 6. Branch (nhánh)

```bash
git branch                                      # Liệt kê nhánh local (* = nhánh hiện tại)
git branch -a                                   # Liệt kê cả nhánh remote
git branch -vv                                  # Kèm commit cuối + nhánh upstream + ahead/behind
git branch --merged                             # Các nhánh đã merge vào nhánh hiện tại (xoá an toàn)
git branch --no-merged                          # Các nhánh chưa merge

git switch <branch>                             # Chuyển sang nhánh (lệnh mới, thay cho checkout)
git switch -c <branch>                          # Tạo nhánh mới từ vị trí hiện tại và chuyển sang
git switch -c <branch> origin/<branch>          # Tạo nhánh local theo dõi một nhánh remote
git switch -                                    # Quay lại nhánh vừa ở trước đó
git checkout <branch>                           # Cách cũ để chuyển nhánh (vẫn dùng được)

git branch -m <tên-mới>                         # Đổi tên nhánh hiện tại
git branch -m <cũ> <mới>                        # Đổi tên nhánh khác
git branch -d <branch>                          # Xoá nhánh local (chỉ khi đã merge)
git branch -D <branch>                          # ⚠ Xoá nhánh local kể cả chưa merge
git push origin --delete <branch>               # Xoá nhánh trên remote
git branch -u origin/<branch>                   # Đặt upstream cho nhánh hiện tại
```

Đặt tên nhánh gợi ý: `feature/<mô-tả>`, `fix/<mô-tả>`, `hotfix/<mô-tả>`, `release/<phiên-bản>`.

---

## 7. Làm việc với remote: fetch / pull / push

```bash
git remote -v                                   # Xem các remote và URL
git remote add <tên> <url>                      # Thêm remote (vd. "upstream" khi fork)
git remote set-url origin <url>                 # Đổi URL remote
git remote rename <cũ> <mới>                    # Đổi tên remote
git remote remove <tên>                         # Xoá remote
git remote show origin                          # Chi tiết remote: nhánh, upstream, trạng thái

git fetch                                       # Tải commit mới từ remote, KHÔNG đụng code đang làm
git fetch --all --prune                         # Fetch mọi remote + xoá nhánh remote đã bị xoá
git pull                                        # fetch + merge (hoặc rebase nếu pull.rebase=true)
git pull --rebase                               # fetch + rebase commit local lên trên (lịch sử thẳng)
git pull --ff-only                              # Chỉ cập nhật nếu fast-forward được, không tự tạo merge commit

git push                                        # Đẩy nhánh hiện tại lên upstream
git push -u origin <branch>                     # Push lần đầu + đặt upstream
git push origin <local>:<remote>                # Push nhánh local lên nhánh remote khác tên
git push --force-with-lease                     # ⚠ Force push AN TOÀN: từ chối nếu remote có commit người khác mới đẩy
git push --force                                # ⚠⚠ Ghi đè remote bất kể thế nào. Tránh dùng trên nhánh chung
git push --tags                                 # Đẩy toàn bộ tag
git push --dry-run                              # Xem sẽ push gì mà không push thật

git ls-remote --heads origin                    # Xem nhánh trên remote mà không cần fetch
```

---

## 8. Gộp code: merge / rebase / cherry-pick

```bash
git merge <branch>                              # Gộp <branch> vào nhánh hiện tại
git merge --no-ff <branch>                      # Luôn tạo merge commit (giữ dấu vết nhánh feature)
git merge --squash <branch>                     # Gom mọi thay đổi thành 1 lần stage, rồi tự commit
git merge --abort                               # Huỷ merge đang dở (khi conflict), quay về trước merge

git rebase <branch>                             # ⚠ Đặt các commit của nhánh hiện tại lên trên <branch>
git rebase origin/main                          # Cập nhật nhánh feature theo main mới nhất (lịch sử thẳng)
git rebase -i HEAD~5                            # ⚠ Sửa 5 commit gần nhất: pick / reword / squash / fixup / drop / reorder
git rebase -i --autosquash <base>               # Tự gộp các commit "fixup!" vào commit gốc
git rebase --continue                           # Tiếp tục sau khi giải conflict
git rebase --skip                               # Bỏ qua commit đang gây conflict
git rebase --abort                              # Huỷ rebase, quay về như cũ
git rebase --onto <base-mới> <base-cũ> <branch> # Chuyển một đoạn commit sang base khác

git cherry-pick <commit>                        # Chép một commit từ nhánh khác vào nhánh hiện tại
git cherry-pick <c1>..<c2>                      # Chép một dải commit (không gồm c1)
git cherry-pick -n <commit>                     # Chép thay đổi nhưng chưa commit
git cherry-pick --abort                         # Huỷ cherry-pick đang dở
```

**Quy tắc vàng của rebase:** không rebase các commit đã push lên nhánh mà người khác đang dùng.

---

## 9. Xử lý conflict

```bash
git status                                      # Xem file đang conflict ("both modified")
# Mở file, tìm các khối <<<<<<< ======= >>>>>>>, sửa thành nội dung đúng, xoá các dấu đó
git add <file>                                  # Đánh dấu đã giải xong
git merge --continue                            # (hoặc rebase --continue / cherry-pick --continue)

git checkout --ours <file>                      # Lấy nguyên bản của nhánh HIỆN TẠI cho file đó
git checkout --theirs <file>                    # Lấy nguyên bản của nhánh ĐANG GỘP VÀO
git mergetool                                   # Mở công cụ merge đồ hoạ
git diff --name-only --diff-filter=U            # Liệt kê các file còn conflict
```

Lưu ý: khi **rebase**, "ours" là nhánh đích (base) còn "theirs" là commit của bạn, ngược với merge.

---

## 10. Hoàn tác & sửa sai

| Tình huống | Lệnh |
|---|---|
| Bỏ thay đổi chưa stage của 1 file | `git restore <file>` ⚠ |
| Bỏ stage 1 file | `git restore --staged <file>` |
| Lấy lại file như ở commit X | `git restore --source <commit> <file>` |
| Sửa message / thêm file vào commit cuối (chưa push) | `git commit --amend` ⚠ |
| Huỷ commit cuối, giữ thay đổi ở trạng thái stage | `git reset --soft HEAD~1` |
| Huỷ commit cuối, giữ thay đổi (chưa stage) | `git reset HEAD~1` |
| Huỷ commit cuối **và vứt luôn thay đổi** | `git reset --hard HEAD~1` ⚠ |
| Đưa nhánh về đúng như remote | `git reset --hard origin/<branch>` ⚠ |
| Huỷ một commit **đã push** (an toàn, tạo commit đảo ngược) | `git revert <commit>` |
| Revert một merge commit | `git revert -m 1 <merge-commit>` |
| Xoá file chưa theo dõi (xem trước) | `git clean -n` |
| Xoá file / thư mục chưa theo dõi | `git clean -fd` ⚠ |
| Xoá cả file bị .gitignore | `git clean -fdx` ⚠⚠ |

**Cứu dữ liệu** (lỡ reset --hard, xoá nhánh, rebase hỏng):

```bash
git reflog                                      # Nhật ký mọi vị trí HEAD từng đi qua (giữ ~90 ngày)
git reset --hard HEAD@{2}                       # Quay về vị trí trong reflog
git branch cuu-nhanh <commit>                   # Tạo lại nhánh từ commit tìm thấy trong reflog
git fsck --lost-found                           # Tìm commit / blob "mồ côi" (cách cuối cùng)
```

---

## 11. Stash (cất tạm thay đổi)

Dùng khi đang làm dở mà cần chuyển nhánh / pull gấp.

```bash
git stash                                       # Cất thay đổi đã theo dõi, working tree sạch
git stash push -m "đang làm login"              # Cất kèm ghi chú
git stash -u                                    # Cất cả file mới (untracked)
git stash push -- <file1> <file2>               # Chỉ cất một số file
git stash list                                  # Danh sách các lần cất
git stash show -p stash@{0}                     # Xem nội dung một stash
git stash pop                                   # Lấy stash mới nhất ra và XOÁ khỏi danh sách
git stash apply stash@{1}                       # Lấy ra nhưng GIỮ trong danh sách
git stash drop stash@{1}                        # Xoá một stash
git stash clear                                 # ⚠ Xoá toàn bộ stash
git stash branch <branch-mới>                   # Tạo nhánh mới từ stash (khi pop bị conflict)
```

---

## 12. Xem lịch sử & tìm kiếm

```bash
git log                                         # Lịch sử đầy đủ
git log --oneline --graph --decorate --all      # Cây lịch sử gọn, mọi nhánh
git log -n 10                                   # 10 commit gần nhất
git log -p <file>                               # Lịch sử kèm diff của một file
git log --follow <file>                         # Lịch sử file, kể cả trước khi đổi tên
git log --author="Quynh"                        # Lọc theo tác giả
git log --since="2 weeks ago" --until="yesterday"  # Lọc theo thời gian
git log --grep="fix"                            # Tìm theo nội dung commit message
git log -S "ToBitonal"                          # Tìm commit thêm / xoá chuỗi này trong code ("pickaxe")
git log -G "regex"                              # Như -S nhưng dùng regex
git log main..feature                           # Commit có ở feature nhưng chưa có ở main
git log --stat                                  # Kèm thống kê file thay đổi
git log --pretty=format:"%h %ad %an %s" --date=short  # Định dạng tuỳ chỉnh

git show <commit>                               # Chi tiết một commit
git show <commit>:<đường/dẫn/file>              # Nội dung file tại một commit
git blame <file>                                # Ai sửa từng dòng, ở commit nào
git blame -L 10,30 <file>                       # Chỉ các dòng 10-30
git shortlog -sn                                # Số commit theo từng người
git grep "từ khoá"                              # Tìm trong code đang theo dõi (nhanh hơn grep thường)
git grep "từ khoá" <commit>                     # Tìm trong code tại một commit

git bisect start                                # Tìm commit gây lỗi bằng tìm kiếm nhị phân
git bisect bad                                  # Đánh dấu commit hiện tại là lỗi
git bisect good <commit>                        # Đánh dấu một commit cũ là tốt
# ... test, rồi gõ good / bad đến khi Git chỉ ra commit gây lỗi
git bisect reset                                # Kết thúc, quay về nhánh ban đầu
git bisect run <lệnh-test>                      # Tự động: lệnh trả 0 = tốt, khác 0 = lỗi
```

---

## 13. Tag & phát hành (release)

```bash
git tag                                         # Liệt kê tag
git tag -l "v1.*"                               # Lọc tag theo mẫu
git tag v1.0.0                                  # Tag nhẹ (lightweight) tại HEAD
git tag -a v1.0.0 -m "Bản 1.0.0"                # Tag có chú thích (khuyên dùng cho release)
git tag -a v1.0.0 <commit> -m "..."             # Tag một commit cũ
git show v1.0.0                                 # Xem thông tin tag
git push origin v1.0.0                          # Đẩy một tag
git push --tags                                 # Đẩy mọi tag
git tag -d v1.0.0                               # Xoá tag local
git push origin --delete v1.0.0                 # Xoá tag trên remote
git describe --tags                             # Mô tả vị trí hiện tại theo tag gần nhất (vd. v1.0.0-5-gabc123)
git archive --format=zip -o release.zip v1.0.0  # Xuất mã nguồn tại tag thành file zip
```

Đánh số phiên bản gợi ý (SemVer): `MAJOR.MINOR.PATCH`. Tăng MAJOR khi thay đổi không tương thích,
MINOR khi thêm tính năng, PATCH khi sửa lỗi.

---

## 14. Quản lý workspace

### 14.1 Worktree: làm nhiều nhánh cùng lúc, mỗi nhánh một thư mục

Không cần stash / chuyển nhánh. Ví dụ: vừa sửa hotfix vừa giữ nguyên feature đang làm dở.

```bash
git worktree add ../ImageProcessing-hotfix hotfix/x    # Checkout nhánh có sẵn ra thư mục mới
git worktree add -b feature/y ../ImageProcessing-y     # Tạo nhánh mới + thư mục mới
git worktree list                               # Liệt kê các worktree
git worktree remove ../ImageProcessing-hotfix   # Xoá worktree (thư mục phải sạch)
git worktree prune                              # Dọn thông tin các worktree đã bị xoá thư mục bằng tay
git worktree lock <path>                        # Khoá để không bị prune (vd. nằm trên ổ USB)
```

Một nhánh chỉ được checkout ở **một** worktree tại một thời điểm.

### 14.2 Submodule: nhúng repo khác vào repo này

```bash
git submodule add <url> libs/<tên>              # Thêm submodule
git submodule update --init --recursive         # Lấy code submodule sau khi clone
git submodule update --remote                   # Cập nhật submodule lên commit mới nhất của nhánh nó theo dõi
git submodule status                            # Trạng thái các submodule
git submodule foreach git pull                  # Chạy một lệnh trong mọi submodule
git config --global submodule.recurse true      # Pull / checkout tự cập nhật submodule
# Gỡ submodule:
git submodule deinit -f libs/<tên>
git rm -f libs/<tên>
```

### 14.3 Sparse-checkout: chỉ lấy một phần repo (repo lớn / monorepo)

```bash
git clone --filter=blob:none --sparse <url>     # Clone nhẹ, ban đầu chỉ có file ở gốc
git sparse-checkout set Source/ImageCoreService docs   # Chỉ checkout các thư mục này
git sparse-checkout add Installer               # Thêm thư mục
git sparse-checkout list                        # Xem các thư mục đang lấy
git sparse-checkout disable                     # Lấy lại toàn bộ repo
```

### 14.4 Nhiều repo / VS Code workspace

- Mở thư mục cha có nhiều repo con: VS Code (tab Source Control) hiện từng repo riêng. Khi push /
  commit, nhớ chọn **đúng repo** trong danh sách.
- Workspace nhiều gốc: *File → Add Folder to Workspace...* rồi *Save Workspace As...* để tạo file
  `.code-workspace`. Mở lại file này là có đủ các repo.
- Chạy một lệnh cho mọi repo con (Git Bash):

```bash
for d in */.git; do (cd "${d%/.git}" && echo "== ${d%/.git}" && git status -sb); done   # status mọi repo
for d in */.git; do (cd "${d%/.git}" && git pull --ff-only); done                      # pull mọi repo
```

### 14.5 Bảo trì repo

```bash
git maintenance start                           # Đăng ký bảo trì nền định kỳ (fetch, gc, commit-graph)
git gc                                          # Nén, dọn object thừa
git count-objects -vH                           # Dung lượng repo
git fsck                                        # Kiểm tra repo có hỏng không
```

---

## 15. .gitignore, file lớn (LFS), dọn dẹp repo

```bash
# .gitignore: mỗi dòng một mẫu, ví dụ:  bin/   obj/   *.user   /artifacts/
git check-ignore -v <file>                      # Vì sao file này bị ignore (dòng nào, file nào)
git rm -r --cached . && git add .               # Áp dụng lại .gitignore cho file đã lỡ theo dõi
git status --ignored                            # Liệt kê cả file bị ignore
git update-index --assume-unchanged <file>      # Tạm lờ thay đổi của một file đã theo dõi (chỉ máy mình)
git update-index --no-assume-unchanged <file>   # Bỏ lờ

# Git LFS cho file nhị phân lớn (model OCR, dll, ảnh mẫu...)
git lfs install                                 # Bật LFS (một lần cho mỗi máy)
git lfs track "*.traineddata"                   # Theo dõi một loại file bằng LFS (ghi vào .gitattributes)
git lfs ls-files                                # Các file đang dùng LFS
git lfs migrate import --include="*.dll"        # ⚠ Chuyển file cũ trong lịch sử sang LFS (viết lại lịch sử)
```

Lỡ commit mật khẩu / file quá lớn: dùng `git filter-repo` (công cụ cài thêm, thay `filter-branch`).
⚠ Lệnh này viết lại toàn bộ lịch sử, mọi người phải clone lại. Nếu là mật khẩu thì **đổi mật khẩu
ngay**, vì dữ liệu đã lên remote coi như bị lộ.

```bash
git filter-repo --path <file> --invert-paths    # Xoá hẳn một file khỏi mọi commit
```

---

## 16. GitHub CLI (`gh`)

Cài bằng `winget install GitHub.cli`, rồi đăng nhập bằng `gh auth login`.

```bash
gh auth status                                  # Tài khoản gh đang dùng
gh auth switch                                  # Chuyển giữa các tài khoản đã đăng nhập
gh repo clone QDev-15/ImageProcessing           # Clone
gh repo view --web                              # Mở repo trên trình duyệt

gh pr create --fill                             # Tạo Pull Request từ nhánh hiện tại (lấy tiêu đề từ commit)
gh pr create --base master --title "..." --body "..."   # Tạo PR với nhánh đích cụ thể
gh pr list                                      # Danh sách PR
gh pr checkout <số>                             # Checkout code của một PR về máy
gh pr view <số> --web                           # Xem PR trên web
gh pr diff <số>                                 # Xem diff của PR
gh pr merge <số> --squash --delete-branch       # Merge (squash) và xoá nhánh
gh pr checks                                    # Trạng thái CI của PR

gh issue create --title "..." --body "..."      # Tạo issue
gh issue list                                   # Danh sách issue
gh release create v1.0.0 artifacts/installer/*.msi --notes "..."   # Tạo release kèm file cài đặt
gh run list                                     # Danh sách lượt chạy GitHub Actions
gh run watch                                    # Theo dõi lượt chạy CI đang diễn ra
```

---

## 17. Alias & mẹo tăng tốc

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
# Dùng: git st, git lg, git undo ...
```

- `git help <lệnh>` hoặc `git <lệnh> -h`: xem hướng dẫn chính thức của một lệnh.
- `HEAD~1` = commit trước HEAD; `HEAD~3` = 3 commit trước; `HEAD^2` = cha thứ 2 của merge commit.
- `@{u}` = nhánh upstream; `git log @{u}..` = các commit local chưa push.
- `-` trong `git switch -` = nhánh trước đó (giống `cd -`).

---

## 18. Quy trình mẫu (workflow)

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

### Sửa gấp (hotfix) khi đang làm dở việc khác

```bash
git worktree add -b hotfix/loi-x ../hotfix origin/master   # Thư mục riêng, không đụng việc đang làm
cd ../hotfix
# ... sửa, commit, push, tạo PR ...
cd - && git worktree remove ../hotfix
```

### Lỡ commit nhầm nhánh (chưa push)

```bash
git branch feature/dung-nhanh                   # Giữ commit ở một nhánh mới
git reset --hard HEAD~1                         # ⚠ Gỡ commit khỏi nhánh hiện tại
git switch feature/dung-nhanh
```

### Gộp nhiều commit lặt vặt trước khi tạo PR

```bash
git rebase -i origin/master                     # Đổi "pick" thành "squash" / "fixup" cho các commit cần gộp
git push --force-with-lease                     # Nhánh đã push trước đó thì cần force (an toàn)
```

---

## 19. Ghi chú riêng

<!-- Thêm lệnh / mẹo của bạn ở đây -->

- Repo `ImageProcessing` đã gắn tài khoản `QDev-15`:
  `git config --local credential.https://github.com.username QDev-15`.
