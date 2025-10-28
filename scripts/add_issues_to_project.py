#!/usr/bin/env python3
"""
Add all TidalHabits Issues to GitHub Project
"""

import json
import subprocess
import sys

PROJECT_ID = "PVT_kwHOBBLams4BGoM4"
REPO = "intervalrain/TidalHabits"

def run_gh_command(cmd):
    """Run gh CLI command and return JSON result"""
    try:
        result = subprocess.run(
            cmd,
            shell=True,
            capture_output=True,
            text=True,
            check=True
        )
        return result.stdout
    except subprocess.CalledProcessError as e:
        print(f"Error: {e.stderr}", file=sys.stderr)
        return None

def get_all_issues():
    """Get all issues from repository"""
    print("📝 取得所有 Issues...")
    cmd = f'gh issue list --repo {REPO} --limit 100 --json id,number,title'
    output = run_gh_command(cmd)
    if output:
        issues = json.loads(output)
        print(f"找到 {len(issues)} 個 Issues")
        return issues
    return []

def add_issue_to_project(issue_id):
    """Add single issue to project"""
    query = f'''
    mutation {{
      addProjectV2ItemById(input: {{projectId: "{PROJECT_ID}", contentId: "{issue_id}"}}) {{
        item {{
          id
        }}
      }}
    }}
    '''
    cmd = f"gh api graphql -f query='{query}'"
    output = run_gh_command(cmd)
    if output:
        try:
            result = json.loads(output)
            return 'data' in result and 'addProjectV2ItemById' in result['data']
        except:
            return False
    return False

def main():
    print("🚀 開始將 Issues 加入 Project...")
    print()

    # Get all issues
    issues = get_all_issues()
    if not issues:
        print("❌ 無法取得 Issues")
        return 1

    print()
    print("➕ 加入 Issues 到 Project...")

    added = 0
    failed = 0

    for issue in issues:
        issue_id = issue['id']
        issue_number = issue['number']
        issue_title = issue['title']

        if add_issue_to_project(issue_id):
            added += 1
            print(f"✓ #{issue_number}: {issue_title}")
        else:
            failed += 1
            print(f"✗ #{issue_number}: {issue_title}")

    print()
    print("✅ 完成!")
    print(f"   成功: {added}")
    print(f"   失敗: {failed}")
    print()
    print("🔗 查看 Project: https://github.com/users/intervalrain/projects/4")

    return 0 if failed == 0 else 1

if __name__ == "__main__":
    sys.exit(main())
